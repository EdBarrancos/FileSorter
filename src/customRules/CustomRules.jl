import Dates
import JSON3

import ..FileSorterData: Rule, FileSorterApp, FileSort, DirSort, hook!, setup, process, findanalyzation, fullpath, stop
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
    timeSinceModification = Dates.now() - Dates.unix2datetime(statAnalyzation.stats.ctime)

    if timeSinceModification <= Dates.Day(rule.modifiedSinceDays)
        return
    end

    enqueue(app.actionQueue, DeleteFile(fullpath(file)))
end

struct SkipAnalysis <: Rule
    skipAnlysisSinceMinutes::Int
    fileRecordKeeper::String
end
mutable struct SkipAnalysisRecord
    lastAnalysis::Dates.DateTime
end
SkipAnalysis(args::Vector{AbstractString}) = SkipAnalysis(parse(Int, args[begin]), args[end])
setup(app::FileSorterApp, rule::SkipAnalysis) = begin
    projectDirectory = dirname(dirname(dirname(@__FILE__)))
    filePath = projectDirectory * "/tmp/" * rule.fileRecordKeeper *
               (endswith(rule.fileRecordKeeper, ".json") ? "" : ".json")
    if !isfile(filePath)
        open(filePath, "w") do io
            JSON3.write(io, SkipAnalysisRecord(Dates.now()))
        end
        return
    end

    content = JSON3.read(read(filePath, String), SkipAnalysisRecord)
    sinceLastAnalysis = Dates.now() - Dates.DateTime(content.lastAnalysis)
    if sinceLastAnalysis < Dates.Minute(rule.skipAnlysisSinceMinutes)
        println("Skipping Analysis. Last analysis was " *
                string(Dates.canonicalize(Dates.CompoundPeriod(sinceLastAnalysis))) *
                " ago")
        stop(app)
        return
    end
    content.lastAnalysis = Dates.now()
    open(filePath, "w") do io
        JSON3.write(io, content)
    end
end


function dispatch(name, args...)
    return Dict(
        "PrintDepthOfFile" => PrintDepthOfFile,
        "DeleteFilesByType" => DeleteFilesByType,
        "DeleteFilesByTypeCreatedSinceDays" => DeleteFilesByTypeCreatedSinceDays,
        "SkipAnalysis" => SkipAnalysis)[name](convert(Vector{AbstractString}, collect(args)))
end
