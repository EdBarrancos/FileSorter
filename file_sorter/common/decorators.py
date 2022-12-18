def positional_arguments_notNullorEmpty(error_handler):
    """
    Validate if there is no positional arguments which are not None or `"`"

    If there are, the error_handling function is called
    """
    def decorator(func_to_validate):
        def wrapper(*args, **kwargs):
            failed = list()
            for elem in args:
                if elem is None or (isinstance(elem, str) and elem == ""):
                    failed.append(elem)

            if len(failed) != 0:
                return error_handler(func_to_validate, args[1:len(args)])

            return func_to_validate(*args, **kwargs)
        return wrapper
    return decorator


def positional_arguments_notNull(error_handler):
    """
    Validate if there is no positional arguments which are not None

    If there are, the error_handling function is called
    """
    def decorator(func_to_validate):
        def wrapper(*args, **kwargs):
            failed = list()
            for elem in args:
                if elem is None:
                    failed.append(elem)

            if len(failed) != 0:
                return error_handler(func_to_validate, args[1:len(args)])

            return func_to_validate(*args, **kwargs)
        return wrapper
    return decorator
