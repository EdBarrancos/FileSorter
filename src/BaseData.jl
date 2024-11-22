module FileSorterData

using ..FileSorterActionQueue: ActionQueue

export Analyzer, Analyzation, Node, FileSort, DirSort, FileSorterApp
export pre, pos, fullpath, hook!

abstract type Analyzer end
abstract type Analyzation end
Base.hash(a::Analyzer) = hash(typeof(a))

abstract type Rule end

abstract type Node end
fullpath(node::Node) = node.path * '/' * node.name
struct FileSort <: Node
    name::String
    path::String
    analyzations::Vector{Analyzation}
end
FileSort(name::String, path::String) = FileSort(name, path, [])
struct DirSort <: Node
    name::String
    path::String
    analyzations::Vector{Analyzation}
end
DirSort(name::String, path::String) = DirSort(name, path, [])


function pre(::Analyzer, ::Node) end
function pos(::Analyzer, ::Node) end

struct FileSorterApp
    rules::Vector{Rule}
    actionQueue::ActionQueue
    analyzers::Set{Analyzer}
end

FileSorterApp() = FileSorterApp([], ActionQueue(), Set{Analyzer}())

hook!(app::FileSorterApp, analyzer::Analyzer) = push!(app.analyzers, analyzer)
function process(::FileSorterApp, ::Rule, ::Node)
end

end
