from typing import Tuple, List
from inspect import signature

from common.logger import Logger
from common.decorators import positional_arguments_notNullorEmpty, \
    positional_arguments_notNull


def argument_error_handling(function, values_received):
    Logger.critical("Expected non empty arguments,"
                    + f'in {function.__name__}{signature(function)} '
                    + f'instead got {values_received}')


class InputConfiguration:
    @positional_arguments_notNullorEmpty(argument_error_handling)
    def __init__(
            self,
            name: str,
            shortForm: str,
            longForm="",
            retriver=lambda x: "") -> None:
        self.name = name
        self.shortForm = shortForm
        self.longForm = longForm
        self.retriever = retriver


class InputParsed:
    @positional_arguments_notNull(argument_error_handling)
    def __init__(self, name: str, value):
        self.name = name
        self.value = value

    def __eq__(self, other: object) -> bool:
        if isinstance(other, InputParsed):
            return self.name == other.name and self.value == other.value
        return False


def parse_command_line_arguments(
        argv: tuple(),
        arguments: tuple()):
    Logger.info("Parsing Command Line Arguments")

    def _parse_command_line_arguments(argv, rest_arguments):
        if len(rest_arguments) == 0:
            return tuple()

        index = get_index(rest_arguments[0], argv)
        if index != -1:
            parsed_arg = InputParsed(
                            rest_arguments[0].name,
                            rest_arguments[0].retriever(
                                get_elem_or_empty(argv, index + 1)))

            Logger.debug(f'{rest_arguments[0].name} argument parsed')

            return (parsed_arg,) \
                + _parse_command_line_arguments(
                    argv,
                    rest_arguments[1: len(rest_arguments)])

        return _parse_command_line_arguments(
            argv,
            rest_arguments[1: len(rest_arguments)])

    return _parse_command_line_arguments(argv, arguments)


def get_elem_or_empty(tpl: tuple(), index: int) -> str:
    if index <= len(tpl) - 1 and index >= 0:
        return tpl[index]
    return ""


def get_index(target: InputConfiguration, arguments: tuple()):
    try:
        return arguments.index(target.shortForm)
    except ValueError:
        if target.longForm != "":
            try:
                return arguments.index(target.longForm)
            except ValueError:
                return -1
        return -1
