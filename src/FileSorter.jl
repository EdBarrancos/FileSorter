module FileSorter
	# julia FileSorter.jl <path-to-folder>, <rule1> <arg1> <arg2>, <rule2> ...
	include("InputParsing.jl")

	input = parseInput(ARGS)
	if !isdir(input[begin])
		error("Provided target is not a directory")
	end

	function process(app::FileSorterApp, name::String, path::String)
		if isdir(path * '/' * name)
			return evaluateDir(app, Directory(name, path))
		end
		return evaluateDir(app, File(name, path))
	end

	function evaluateDir(app::FileSorterApp, dir::Directory)
		map(analyzer -> pre(analyzer, dir), app.analyzers)
		map(element -> process(app, element, fullpath(dir)), readdir(dir))
		map(analyzer -> pos(analyzer, dir), app.analyzers)
	end

	abstract type Analyzer end
	abstract type Analyzation end
	Base.hash(a::Analyzer) = hash(typeof(a))
	pre(::Analyzer, ::File) = error("Not Implemented")
	pre(::Analyzer, ::Directory) = error("Not Implemented")
	pos(::Analyzer, ::File) = error("Not Implemented")
	pos(::Analyzer, ::Directory) = error("Not Implemented")

	abstract type Node end
	fullpath(node::Node) = node.path * '/' * node.name
	struct File <: Node
		name::String
		path::String
		analyzations::Vector{Analyzation}
	end
	File(name::String, path::String) = File(name, path, [])
	struct Directory <: Node
		name::String
		path::String
		analyzations::Vector{Analyzation}
	end
	Directory(name::String, path::String) = Directory(name, path, [])
	readdir(dir::Directory) = readdir(fullpath(dir))

	struct FileSorterApp
		analyzers::Set{Analyzer}
	end

	FileSorterApp() = FileSorterApp(Set{Analyzer}())

	hook!(app::FileSorterApp, analyzer::Analyzer) = push!(app.analyzers, analyzer)

end # module FileSorter
