import ..FileSorterData: FileSort, DirSort, Analyzer, Analyzation, pre, pos, analyze, fullpath
import Base.Filesystem: StatStruct

struct DepthAnalyzer <: Analyzer
    currentDepth::Vector{Int}
end

struct DepthAnalyzation <: Analyzation
    depth::Int
end

analyze(analyzer::DepthAnalyzer, file::FileSort) = push!(file.analyzations, DepthAnalyzation(analyzer.currentDepth[end]))
pre(analyzer::DepthAnalyzer, ::DirSort) = push!(analyzer.currentDepth, analyzer.currentDepth[end] + 1)
pos(analyzer::DepthAnalyzer, ::DirSort) = pop!(analyzer.currentDepth)


struct TypeAnalyzer <: Analyzer end
struct TypeAnalyzation <: Analyzation
    type::String
end

function analyze(::TypeAnalyzer, file::FileSort)
    if !occursin(".", file.name)
        return
    end

    push!(file.analyzations, TypeAnalyzation(split(file.name, ".")[end]))
end

struct StatAnalyzer <: Analyzer end
struct StatAnalyzation <: Analyzation
    stats::StatStruct
end
analyze(::StatAnalyzer, file::FileSort) = push!(file.analyzations, StatAnalyzation(stat(fullpath(file))))
