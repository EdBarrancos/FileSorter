import unittest

import logging
from file_sorter.logger import Logger


class TestLogger(unittest.TestCase):
    def test_string_to_logging_level_info(self):
        logging_level = Logger.string_to_logging_level("INFO")
        self.assertAlmostEqual(logging_level, logging.INFO)

    def test_string_logging_level_nonexistant(self):
        logging_level = Logger.string_to_logging_level("NON")
        self.assertAlmostEqual(logging_level, logging.NOTSET)
