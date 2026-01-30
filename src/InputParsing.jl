export parseInput

include("utils/UtilsModule.jl")

function parseInput(args::Array)::Union{Tuple{String,Vector{Vector{AbstractString}}},Tuple{String},Nothing}
    if length(ARGS) < 1
        @error "Needed path to folder to sort"
        return nothing
    end

    pathToFolder = string(args[begin])

    if length(ARGS) == 1
        return (pathToFolder,)
    end

    rulesAndArgs::Vector{Vector{String}} = []
    target::Vector{String} = []
    for arg in args[begin+1:end]
        if (isspace(arg[begin]))
            continue
        end

        if arg[end] == ','
            push!(target, string(arg[begin:end-1]))
            push!(rulesAndArgs, target)
            target = []
            continue
        end

        push!(target, string(arg))
    end

    return (pathToFolder, map(filter(a -> !isempty(a)), rulesAndArgs))
end

precompile(parseInput, (Array,))
