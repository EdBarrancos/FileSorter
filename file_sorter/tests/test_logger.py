from parameterized import parameterized, parameterized_class
import unittest

import logging
from logger import Logger


class TestLogger(unittest.TestCase):
    @parameterized.expand([
        ["INFO", logging.INFO],
        ["CRITICAL", logging.CRITICAL],
        ["ERROR", logging.ERROR],
        ["DEBUG", logging.DEBUG]
    ])
    def test_string_to_logging_level_info(
            self,
            string: str,
            pretended_level: int):
        logging_level = Logger.string_to_logging_level(string)
        self.assertEqual(logging_level, pretended_level)

    @parameterized.expand([
        ["NONE"],
        [""],
        ["WTV"],
        [1],
        [None]
    ])
    def test_string_logging_level_nonexistant(self, string_to_eval):
        logging_level = Logger.string_to_logging_level(string_to_eval)
        self.assertEqual(logging_level, logging.NOTSET)
