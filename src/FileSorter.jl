module FileSorter
# julia FileSorter.jl <path-to-folder>, <rule1> <arg1> <arg2>, <rule2> ...
using Base: File
include("InputParsing.jl")

input = parseInput(ARGS)
if !isdir(input[begin])
    error("Provided target is not a directory")
end

abstract type Analyzer end
abstract type Analyzation end
Base.hash(a::Analyzer) = hash(typeof(a))
pre(::Analyzer, ::FileSort) = error("Not Implemented")
pre(::Analyzer, ::DirSort) = error("Not Implemented")
pos(::Analyzer, ::FileSort) = error("Not Implemented")
pos(::Analyzer, ::DirSort) = error("Not Implemented")

struct FileSorterApp
    analyzers::Set{Analyzer}
end

FileSorterApp() = FileSorterApp(Set{Analyzer}())

hook!(app::FileSorterApp, analyzer::Analyzer) = push!(app.analyzers, analyzer)

end # module FileSorter
