export parseInput

include("utils/UtilsModule.jl")

function parseInput(args::Array)::Union{Tuple{String,Vector{Vector{AbstractString}}},Tuple{String}, Nothing}
    if length(ARGS) < 1
        @error "Needed path to folder to sort"
        return nothing
    end

    argsString = map(x -> string(x), args)

    pathToFolder = argsString[begin]

    if length(ARGS) == 1
        return (pathToFolder,)
    end

    curatedInput = map(a -> filter(x -> !isspace(x), a), argsString[2:end])

    rulesAndArgs = map(
        ruleInput -> split(ruleInput, " "),
        split(
            Utils.reduce(curatedInput, (a, b) -> a * " " * b),
            ","))
    return (pathToFolder, map(filter(a -> !isempty(a)), rulesAndArgs))
end
