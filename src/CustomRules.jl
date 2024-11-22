module CustomRules

using ..FileSorterData: Rule, FileSorterApp, FileSort, DirSort, Analyzation, hook!, pre, pos
using ..FileSorterActionQueue

struct DepthAnalyzer <: Analyzer 
    currentDepth::Vector{Int}
end


struct DepthAnalyzation <: Analyzation 
	depth::Int
end

pre(analyzer::DepthAnalyzer, file::FileSort) = push!(file.analyzations, DepthAnalyzation(analyzer.currentDepth[end]))
pre(analyzer::DepthAnalyzer, dir::DirSort) = push!(analyzer.currentDepth, analyzer.currentDepth[end] + 1)
pos(analyzer::DepthAnalyzer, dir::DirSort) = pop!(analyzer.currentDepth)

struct PrintRule <: Rule end
function PrintRule(app::FileSorterApp)
    hook!(app, DepthAnalyzer([0]))
    return PrintRule()
end

process(::FileSorterApp, ::PrintRule, dir::DirSort) = println(dir.name)
function process(app::FileSorterApp, ::PrintRule, file::FileSort)
	depthAnalyzations = filter(analyzation -> analyzation is DepthAnalyzation, file.analyzations)
	if isempty(depthAnalyzations)
		return
	end


end
end
