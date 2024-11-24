using Base: readdir
import .FileSorterData: process

export readdir, process

Base.readdir(dir::DirSort) = readdir(fullpath(dir))

function evaluate(app::FileSorterApp, file::FileSort)
    foreach(analyzer -> pre(analyzer, file), app.analyzers)
    foreach(analyzer -> pos(analyzer, file), app.analyzers)
    foreach(rule -> process(app, rule, file), app.rules)
end

function evaluate(app::FileSorterApp, dir::DirSort)
    foreach(analyzer -> pre(analyzer, dir), app.analyzers)
    map(element -> process(app, element, fullpath(dir)), readdir(dir))
    foreach(analyzer -> pos(analyzer, dir), app.analyzers)
    foreach(rule -> process(app, rule, dir), app.rules)
end

function process(app::FileSorterApp, name::String, path::String)
    if isdir(path * '/' * name)
        return evaluate(app, DirSort(name, path))
    end
    return evaluate(app, FileSort(name, path))
end

function process(app::FileSorterApp, fullDirPath::String)
    children = readdir(fullDirPath)
    for child in children
        process(app, child, fullDirPath)
    end
end


