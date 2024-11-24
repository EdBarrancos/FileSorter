using Dates

import ..FileSorterData: Rule, FileSorterApp, FileSort, DirSort, hook!, setup, process, findanalyzation, fullpath
import ..FileSorterActionQueue: enqueue

export dispatch

struct PrintDepthOfFileRule <: Rule end
PrintDepthOfFileRule(::Any) = PrintDepthOfFileRule()
setup(app::FileSorterApp, ::PrintDepthOfFileRule) = hook!(app, DepthAnalyzer([0]))

function process(app::FileSorterApp, ::PrintDepthOfFileRule, file::FileSort)
    depthAnalyzation = findanalyzation(DepthAnalyzation, file)
    enqueue(app.actionQueue, PrintQueueItem(file.name, string(depthAnalyzation.depth)))
end

struct DeleteFileTypeRule <: Rule
    targetTypes::Tuple{String}
end
setup(app::FileSorterApp, ::DeleteFileTypeRule) = hook!(app, TypeAnalyzer())

function process(app::FileSorterApp, rule::DeleteFileTypeRule, file::FileSort)
    typeAnalyzation = findanalyzation(TypeAnalyzation, file)
    if typeAnalyzation.type in rule.targetTypes
        enqueue(app.actionQueue, DeleteFile(fullpath(file)))
    end
end

struct DeleteFilesByTypeModifiedSinceDays <: Rule
    targetTypes::Tuple{String}
    modifiedSinceDays::Int
end
DeleteFilesByTypeModifiedSinceDays(args::Tuple) = DeleteFilesByTypeModifiedSinceDays(args[begin:end-1], parse(Int, args[end]))
setup(app::FileSorterApp, ::DeleteFilesByTypeModifiedSinceDays) = begin
    hook!(app, TypeAnalyzer())
    hook!(app, StatAnalyzer())
end
function process(app::FileSorterApp, rule::DeleteFilesByTypeModifiedSinceDays, file::FileSort)
    typeAnalyzation = findanalyzation(TypeAnalyzation, file)
    if !(typeAnalyzation.type in rule.targetTypes)
        return
    end
    statAnalyzation = findanalyzation(StatAnalyzation, file)
    timeSinceModification = now() - unix2datetime(statAnalyzation.stats.mtime)

    if timeSinceModification <= Dates.Day(rule.modifiedSinceDays)
        return
    end

    enqueue(app.actionQueue, DeleteFile(fullpath(file)))
end


function dispatch(name, args...)
    return Dict(
        "PrintDepthOfFileRule" => PrintDepthOfFileRule,
        "DeleteFileTypeRule" => DeleteFileTypeRule,
        "DeleteFilesByTypeModifiedSinceDays" => DeleteFilesByTypeModifiedSinceDays)[name](args)
end
