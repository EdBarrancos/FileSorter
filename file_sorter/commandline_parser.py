from typing import Tuple

from file_sorter.common.logger import Logger
from file_sorter.common.decorators import positional_arguments_validation


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
            retriver=None) -> None:
        self.name = name
        self.shortForm = shortForm
        self.longForm = longForm
        self.retriever = retriver


class InputParsed:
    @positional_arguments_validation(argument_error_handling)
    def __init__(self, name: str, value: str):
        self.name = name
        self.value = value


def parse_command_line_arguments(arguments: Tuple(InputConfiguration)):
    pass
