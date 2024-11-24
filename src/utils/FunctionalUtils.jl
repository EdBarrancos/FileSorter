import Base: split
export fold, split

function fold(initial::T, collection::Vector{U}, joiner::Function)::T where {T,U}
    folding = initial
    map(item -> folding = joiner(folding, item), collection)
    return folding
end

function reduce(collection::Vector{U}, joiner::Function)::U where {U}
    if isempty(collection)
        return nothing
    elseif length(collection) == 1
        return collection[begin]
    end

    folding = joiner(collection[1], collection[2])
    map(item -> folding = joiner(folding, item), collection[3:end])
    return folding
end

