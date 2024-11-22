module CustomRules

using ..FileSorterData: Rule, FileSorterApp, FileSort, DirSort, hook!

struct DepthAnalyzer <: Analyzer 
    currentDepth::Vector{Int}
end

struct PrintRule <: Rule end
function PrintRule(app::FileSorterApp)
    hook!(app, DepthAnalyzer([0]))
    return PrintRule()
end

process(::FileSorterApp, ::PrintRule, file::FileSort) = println(file.name)

process(::FileSorterApp, ::PrintRule, dir::DirSort) = println(file.name)


end