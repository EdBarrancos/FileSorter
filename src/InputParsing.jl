export parseInput

include("utils/UtilsModule.jl")

function parseInput(args::Array)::Tuple{Union{String, Vector{String}}}
    if length(ARGS) < 1
        error("Needed path to folder to sort")
    end

    argsString = map(x -> string(x), args)

    pathToFolder = argsString[begin] 

    if length(ARGS) == 1
        return (pathToFolder, )
    end

    return (pathToFolder, split(Utils.fold("", argsString[2:end], (a, b) -> a * " " * b), ","))
end
