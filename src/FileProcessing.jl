abstract type Node end
fullpath(node::Node) = node.path * '/' * node.name
struct FileSort <: Node
	name::String
	path::String
	analyzations::Vector{Analyzation}
end
FileSort(name::String, path::String) = File(name, path, [])
struct DirSort <: Node
	name::String
	path::String
	analyzations::Vector{Analyzation}
end
DirSort(name::String, path::String) = DirSort(name, path, [])
readdir(dir::DirSort) = readdir(fullpath(dir))


function process(app::FileSorterApp, name::String, path::String)
	if isdir(path * '/' * name)
		return evaluate(app, DirSort(name, path))
	end
	return evaluate(app, FileSort(name, path))
end

function evauluate(app::FileSorterApp, file::FileSort)
	map(analyzer -> pre(analyzer, file), app.analyzers)
	map(analyzer -> pos(analyzer, file), app.analyzers)
end

function evaluate(app::FileSorterApp, dir::DirSort)
	map(analyzer -> pre(analyzer, dir), app.analyzers)
	map(element -> process(app, element, fullpath(dir)), readdir(dir))
	map(analyzer -> pos(analyzer, dir), app.analyzers)
end

