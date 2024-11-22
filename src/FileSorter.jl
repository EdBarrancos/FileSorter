module FileSorter
# julia FileSorter.jl <path-to-folder>, <rule1> <arg1> <arg2>, <rule2> ...
include("InputParsing.jl")
include("ActionQueue.jl")
using .FileSorterActionQueue
include("BaseData.jl")
using .FileSorterData
include("FileProcessing.jl")

input = parseInput(ARGS)
if !isdir(input[begin])
    error("Provided target is not a directory")
end

# Check Rules and hook analyzers

process(FileSorterApp(), input[begin])

# Process action queue

end # module FileSorter
