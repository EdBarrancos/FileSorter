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

function __init__()
    tstart = time()
    input = parseInput(ARGS)
    if isnothing(input)
        exit()
    end
    if !isdir(input[begin])
        @error "Provided target is not a directory"
        return
    end
    tinput = time()
    print("Input parsed: ")
    println(tinput - tstart)
    app::FileSorterApp = FileSorterApp()
    if length(input) > 1
        foreach(rule -> length(rule) == 1 ?
                        hook!(app, dispatch(rule[begin])) :
                        hook!(app, dispatch(rule[begin], rule[2:end]...)), input[2:end]...)
    end

    thook = time()
    print("Rules hooked: ")
    println(thook - tstart)

    process(app, input[begin])

    tprocessed = time()
    print("Rules processed: ")
    println(tprocessed - tstart)

    foreach(item -> execute(item), app.actionQueue.items)

    tactionQueue = time()
    print("Action queue: ")
    println(tactionQueue - tstart)
    tend = time()
    println(tend - tstart)
end

end
