def positional_arguments_validation(error_handler):
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
                return error_handler(failed)

            return func_to_validate(args, kwargs)
        return wrapper
    return decorator
