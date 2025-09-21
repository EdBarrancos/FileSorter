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

using JSON3

function __init__()
    input_file = parseInput(ARGS)
    if isnothing(input_file)
        exit()
    end

    input::FileSorterInput = JSON3.read(read(input_file, String), FileSorterInput)
    if !isdir(input.target)
        @error "Provided target is not a directory"
        return
    end
    app = FileSorterApp()
    if length(input.rules) > 1
        create_rules(app, input.rules)
    end

    process(app, input.target)
    foreach(item -> execute(item), app.actionQueue.items)
end

function create_rules(app::FileSorterApp, rules_input::Vector{RuleInput})
    foreach(rule -> hook!(app, dispatch(rule)), rules_input)
end

end
