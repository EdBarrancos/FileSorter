module FileSorterData

using Base: println
using ..FileSorterActionQueue: ActionQueue

export Analyzer, Analyzation, Node, FileSort, DirSort, FileSorterApp
export pre, pos, fullpath, hook!, setup, process

abstract type Analyzer end
abstract type Analyzation end
Base.hash(a::Analyzer) = hash(typeof(a))

abstract type Rule end

abstract type Node end
fullpath(node::Node) = node.path * '/' * node.name
Base.println(node::Node) = println(fullpath(node))
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
function setup(::FileSorterApp, ::Rule) end
function hook!(app::FileSorterApp, rule::Rule)
    push!(app.rules, rule)
    setup(app, rule)
end
hook!(app::FileSorterApp, analyzer::Analyzer) = push!(app.analyzers, analyzer)

function process(::FileSorterApp, ::Rule, ::FileSort) end
function process(::FileSorterApp, ::Rule, ::DirSort) end

end
