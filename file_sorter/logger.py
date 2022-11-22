import logging
import sys

from file_sorter.configs import Configutations

FORMATTER = logging.Formatter(
    "%(asctime)s — %(name)s — %(levelname)s — %(message)s")


def get_console_handler():
    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setFormatter(FORMATTER)
    return console_handler


def get_file_handler(file_name: str):
    # TODO: Test, I dont think this is right
    file_handler = logging.FileHandler(file_name, mode='w')
    file_handler.setFormatter(FORMATTER)
    return file_handler


def string_to_logging_level(logging_level_str) -> int:
    if logging_level_str == "CRITICAL":
        return logging.CRITICAL
    elif logging_level_str == "ERROR":
        return logging.ERROR
    elif logging_level_str == "WARNING":
        return logging.WARNING
    elif logging_level_str == "INFO":
        return logging.INFO
    elif logging_level_str == "DEBUG":
        return logging.DEBUG
    else:
        return logging.NOTSET


def get_logger(
        logger_name: str, configuration: Configutations) -> logging.Logger:
    logger = logging.getLogger(logger_name)
    logger.setLevel(string_to_logging_level(configuration.get_logging_level()))
    logger.addHandler(get_console_handler())
    logger.addHandler(get_file_handler(configuration.get_logging_file()))
    logger.propagate = False
    return logger
