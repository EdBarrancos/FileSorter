export parseInput

include("utils/UtilsModule.jl")

function parseInput(args::Array)::Union{String,Nothing}
    if length(args) < 1
        @error "Needed path to folder to sort"
        return nothing
    end

    if length(args) > 1
        @error "Input is <path-to-json-input.json>"
        return nothing
    end

    return string(args[begin])
end
