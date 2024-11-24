module CustomRules

import ..FileSorterData: Rule, FileSorterApp, FileSort, DirSort, Analyzer, Analyzation, hook!, pre, pos, setup, process, findanalyzation, fullpath
import ..FileSorterActionQueue: QueueItem, enqueue, execute

export dispatch

struct DepthAnalyzer <: Analyzer
    currentDepth::Vector{Int}
end

struct DepthAnalyzation <: Analyzation
    depth::Int
end


struct TypeAnalyzer <: Analyzer end
struct TypeAnalyzation <: Analyzation
    type::String
end

function pre(::TypeAnalyzer, file::FileSort)
    if !occursin(".", file.name)
        return
    end

    push!(file.analyzations, TypeAnalyzation(split(file.name, ".")[end]))
end

struct PrintQueueItem <: QueueItem
    fileName::String
    toPrint::String
end

execute(item::PrintQueueItem) = println(item.fileName * " - " * item.toPrint)

pre(analyzer::DepthAnalyzer, file::FileSort) = push!(file.analyzations, DepthAnalyzation(analyzer.currentDepth[end]))
pre(analyzer::DepthAnalyzer, ::DirSort) = push!(analyzer.currentDepth, analyzer.currentDepth[end] + 1)
pos(analyzer::DepthAnalyzer, ::DirSort) = pop!(analyzer.currentDepth)

struct PrintRule <: Rule end
setup(app::FileSorterApp, ::PrintRule) = hook!(app, DepthAnalyzer([0]))

process(::FileSorterApp, ::PrintRule, dir::DirSort) = println(dir.name)
function process(app::FileSorterApp, ::PrintRule, file::FileSort)
    depthAnalyzations = filter(analyzation -> typeof(analyzation) == DepthAnalyzation, file.analyzations)
    if isempty(depthAnalyzations)
        error("No depth Analyzations")
    end
    enqueue(app.actionQueue, PrintQueueItem(file.name, string(depthAnalyzations[begin].depth)))
end

struct DeleteFileTypeRule <: Rule
    targetTypes::Tuple{String}
end
setup(app::FileSorterApp, ::DeleteFileTypeRule) = hook!(app, TypeAnalyzer())

struct DeleteFile <: QueueItem
    fullpath::String
end

function execute(item::DeleteFile)
	if ! isfile(item.fullpath)
		println("Trying to delete non-existant file / a directory: " * item.fullpath)
		return
	end
	rm(item.fullpath)
end

function process(app::FileSorterApp, rule::DeleteFileTypeRule, file::FileSort)
    typeAnalyzation = findanalyzation(TypeAnalyzation, file)
    if typeAnalyzation.type in rule.targetTypes
        enqueue(app.actionQueue, DeleteFile(fullpath(file)))
    end
end

function dispatch(name, args...)
    return Dict(
        "PrintRule" => PrintRule,
        "DeleteFileTypeRule" => DeleteFileTypeRule)[name](args)
end

end
