from parameterized import parameterized
import unittest

from commandline_parser import InputConfiguration, \
    InputParsed, parse_command_line_arguments, \
    get_elem_or_empty, get_index


class TestGetElemOrEmpty(unittest.TestCase):
    @parameterized.expand([
        [0, "1"],
        [1, "2"],
        [2, "3"]
    ])
    def test_success(self, index, result):
        response = get_elem_or_empty(("1", "2", "3"), index)
        self.assertEqual(response, result)

    @parameterized.expand([
        [-100000],
        [-1],
        [3],
        [1000]
    ])
    def test_empty(self, index):
        response = get_elem_or_empty(("1", "2", "3"), index)
        self.assertEqual(response, "")


class TestGetIndex(unittest.TestCase):
    pass


class TestParseCommandLineArguments(unittest.TestCase):
    pass
