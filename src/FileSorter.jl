module FileSorter
# julia FileSorter.jl <path-to-folder>, <rule1> <arg1> <arg2>, <rule2> ...
include("InputParsing.jl")
include("ActionQueue.jl")
using .FileSorterActionQueue
include("BaseData.jl")
using .FileSorterData
include("FileProcessing.jl")
include("CustomRules.jl")
using .CustomRules: dispatch

input = parseInput(ARGS)
if !isdir(input[begin])
    error("Provided target is not a directory")
end

app = FileSorterApp()
hook!(app, dispatch("DeleteFileTypeRule", "out"))
process(app, input[begin])
foreach(item -> execute(item), app.actionQueue.items)
end
