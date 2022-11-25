from typing import Tuple, List

from common.logger import Logger
from common.decorators import positional_arguments_validation


def argument_error_handling(values_received):
    Logger.critical("Expected non empty arguments,"
                    + f'instead got {values_received}')


class InputConfiguration:
    @positional_arguments_validation(argument_error_handling)
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
    @positional_arguments_validation(argument_error_handling)
    def __init__(self, name: str, value):
        self.name = name
        self.value = value


def parse_command_line_arguments(
        argv: tuple(),
        arguments: tuple()):
    Logger.info("Parsing Command Line Arguments")
    parser_arguments: List[InputParsed] = list()
    for argument in arguments:
        index = get_index(argument, argv)
        if index != -1:
            parser_arguments.append(
                InputParsed(
                    argument.name,
                    argument.retriever(
                        get_elem_or_empty(index + 1))))
            Logger.info(f'{argument.name} argument parsed')


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
                return arguments.index(target.shortForm)
            except ValueError:
                return -1
        return -1
