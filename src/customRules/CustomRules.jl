using Dates

import ..FileSorterData: Rule, FileSorterApp, FileSort, DirSort, hook!, setup, process, findanalyzation, fullpath
import ..FileSorterActionQueue: enqueue

export dispatch

struct PrintDepthOfFile <: Rule end
PrintDepthOfFile(::Any) = PrintDepthOfFile()
setup(app::FileSorterApp, ::PrintDepthOfFile) = hook!(app, DepthAnalyzer([0]))

function process(app::FileSorterApp, ::PrintDepthOfFile, file::FileSort)
    depthAnalyzation = findanalyzation(DepthAnalyzation, file)
    enqueue(app.actionQueue, PrintQueueItem(file.name, string(depthAnalyzation.depth)))
end

struct DeleteFilesByType <: Rule
    targetTypes::Vector{AbstractString}
end
setup(app::FileSorterApp, ::DeleteFilesByType) = hook!(app, TypeAnalyzer())

function process(app::FileSorterApp, rule::DeleteFilesByType, file::FileSort)
    typeAnalyzation = findanalyzation(TypeAnalyzation, file)
    if typeAnalyzation.type in rule.targetTypes
        enqueue(app.actionQueue, DeleteFile(fullpath(file)))
    end
end

struct DeleteFilesByTypeCreatedSinceDays <: Rule
    targetTypes::Vector{AbstractString}
    modifiedSinceDays::Int
end
DeleteFilesByTypeCreatedSinceDays(args::Vector{AbstractString}) = DeleteFilesByTypeCreatedSinceDays(args[begin:end-1], parse(Int, args[end]))
setup(app::FileSorterApp, ::DeleteFilesByTypeCreatedSinceDays) = begin
    hook!(app, TypeAnalyzer())
    hook!(app, StatAnalyzer())
end
function process(app::FileSorterApp, rule::DeleteFilesByTypeCreatedSinceDays, file::FileSort)
    typeAnalyzation = findanalyzation(TypeAnalyzation, file)
    if !(typeAnalyzation.type in rule.targetTypes)
        return
    end
    statAnalyzation = findanalyzation(StatAnalyzation, file)
    timeSinceModification = now() - unix2datetime(statAnalyzation.stats.ctime)

    if timeSinceModification <= Dates.Day(rule.modifiedSinceDays)
        return
    end

    enqueue(app.actionQueue, DeleteFile(fullpath(file)))
end


function dispatch(name, args...)
    return Dict(
        "PrintDepthOfFile" => PrintDepthOfFile,
        "DeleteFilesByType" => DeleteFilesByType,
        "DeleteFilesByTypeCreatedSinceDays" => DeleteFilesByTypeCreatedSinceDays)[name](convert(Vector{AbstractString},collect(args)))
end
