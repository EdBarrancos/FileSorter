from typing import List
import logging
import sys
import inspect

from configs import Configutations


class Logger:
    FORMATTER = logging.Formatter(
        "%(asctime)s — %(name)s — %(levelname)s — %(message)s")
    logger_modules: List[str] = []

    def critical(message):
        frm = inspect.stack()[1]
        mod = inspect.getmodule(frm[0])
        Logger.get_or_create_logger(mod.__name__).critical(message)

    def error(message):
        frm = inspect.stack()[1]
        mod = inspect.getmodule(frm[0])
        Logger.get_or_create_logger(mod.__name__).error(message)

    def warn(message):
        frm = inspect.stack()[1]
        mod = inspect.getmodule(frm[0])
        Logger.get_or_create_logger(mod.__name__).warn(message)

    def info(message):
        frm = inspect.stack()[1]
        mod = inspect.getmodule(frm[0])
        Logger.get_or_create_logger(mod.__name__).info(message)

    def debug(message):
        frm = inspect.stack()[1]
        mod = inspect.getmodule(frm[0])
        Logger.get_or_create_logger(mod.__name__).debug(message)

    def get_or_create_logger(module_name: str):
        if len(tuple(filter(
                lambda name: name == module_name,
                Logger.logger_modules))) >= 1:
            return logging.getLogger(module_name)
        return Logger.create_logger(module_name)

    def create_logger(
            logger_name: str) -> logging.Logger:
        logger = logging.getLogger(logger_name)
        logger.setLevel(
            Logger.string_to_logging_level(
                Configutations.get_logging_level()))
        logger.addHandler(Logger.get_console_handler())
        logger.addHandler(
            Logger.get_file_handler(
                Configutations.get_logging_file()))
        logger.propagate = False
        Logger.logger_modules.append(logger_name)
        return logger

    def get_console_handler():
        console_handler = logging.StreamHandler(sys.stdout)
        console_handler.setFormatter(Logger.FORMATTER)
        return console_handler

    def get_file_handler(file_name: str):
        # TODO: Test, I dont think this is right
        file_handler = logging.FileHandler(file_name, mode='w')
        file_handler.setFormatter(Logger.FORMATTER)
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
