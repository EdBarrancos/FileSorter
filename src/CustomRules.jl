module CustomRules

import ..FileSorterData: Rule, FileSorterApp, FileSort, DirSort, Analyzer, Analyzation, hook!, pre, pos, setup, process
import ..FileSorterActionQueue: QueueItem, enqueue, execute

struct DepthAnalyzer <: Analyzer
    currentDepth::Vector{Int}
end

struct DepthAnalyzation <: Analyzation
    depth::Int
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

end
