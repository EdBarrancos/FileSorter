module FileSorter
# julia FileSorter.jl <path-to-folder>, <rule1> <arg1> <arg2>, <rule2> ...

include("InputParsing.jl")
include("ActionQueue.jl")
using .FileSorterActionQueue
include("BaseData.jl")
using .FileSorterData
include("FileProcessing.jl")
include("customRules/CustomRulesModule.jl")
using .CustomRules: dispatch

input = parseInput(ARGS)
if !isdir(input[begin])
    error("Provided target is not a directory")
end
app = FileSorterApp()
if length(input) > 1
    foreach(rule -> length(rule) == 1 ?
                    hook!(app, dispatch(rule[begin])) :
                    hook!(app, dispatch(rule[begin], rule[2:end]...)), input[2:end]...)
end


process(app, input[begin])
foreach(item -> execute(item), app.actionQueue.items)

end
