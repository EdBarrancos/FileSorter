def reduce_left(fn, tpl: tuple, initial_value):
    if len(tpl) == 0:
        return initial_value
    
    return reduce(
        fn,
        (initial_value,) + tpl,
        lambda tpl: tpl[0],
        lambda tpl: tpl[1:]
    )

def reduce(
        transformer, 
        tpl: tuple, 
        first,
        rest):
    if len(tpl) == 2:
        return transformer(first(tpl), rest(tpl)[0])
    return transformer(
        first(tpl), 
        reduce(
            transformer,
            rest(tpl),
            first,
            rest,
        )
    )