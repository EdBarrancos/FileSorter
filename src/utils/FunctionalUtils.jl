export fold, split

function fold(initial::T, collection::Vector{U}, joiner::Function)::T where {T, U}
    folding = initial
    map(item -> folding = joiner(folding, item), collection)
    return folding
end