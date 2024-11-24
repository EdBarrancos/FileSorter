import ..FileSorterData: FileSort, DirSort, Analyzer, Analyzation, pre, pos

struct DepthAnalyzer <: Analyzer
    currentDepth::Vector{Int}
end

struct DepthAnalyzation <: Analyzation
    depth::Int
end

pre(analyzer::DepthAnalyzer, file::FileSort) = push!(file.analyzations, DepthAnalyzation(analyzer.currentDepth[end]))
pre(analyzer::DepthAnalyzer, ::DirSort) = push!(analyzer.currentDepth, analyzer.currentDepth[end] + 1)
pos(analyzer::DepthAnalyzer, ::DirSort) = pop!(analyzer.currentDepth)


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