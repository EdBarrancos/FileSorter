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
    target = InputConfiguration("test", "-t", "--test")

    @parameterized.expand([
        [("-t", "-r"), 0],
        [("-t",), 0],
        [("-r", "-t"), 1],
        [(), -1],
        [("-r",), -1]
    ])
    def test_shortForm(self, under_test, pretended):
        self.assertEqual(
            get_index(TestGetIndex.target, under_test),
            pretended)

    @parameterized.expand([
        [("--test", "-r"), 0],
        [("--test",), 0],
        [("-r", "--test"), 1],
        [(), -1],
        [("-r",), -1]
    ])
    def test_longForm(self, under_test, pretended):
        self.assertEqual(
            get_index(TestGetIndex.target, under_test),
            pretended)


class TestParseCommandLineArguments(unittest.TestCase):
    def test_parse_basic(self):
        argv = "-t"
        arguments = (InputConfiguration("test", "-t"),)
        parsed_arguments = (InputParsed("test", ""),)
        under_test = parse_command_line_arguments(argv, arguments)
        self.assertEqual(under_test, parsed_arguments)

    @parameterized.expand([
        [
            "-t -r",
            (InputConfiguration("test", "-t"),),
            (InputParsed("test", ""),)
        ],
        [
            "-r",
            (InputConfiguration("test", "-t"),),
            tuple()
        ],
        [
            "-t 12",
            (InputConfiguration("test", "-t", retriver=lambda x: x),),
            (InputParsed("test", "12"),)
        ],
        [
            "--test 12",
            (InputConfiguration(
                "test",
                "-t",
                longForm="--test",
                retriver=lambda x: x),),
            (InputParsed("test", "12"),)
        ]
    ])
    def test_parse(self, argv, arguments, expected_parse_arguments):
        under_test = parse_command_line_arguments(argv, arguments)
        self.assertEqual(under_test, expected_parse_arguments)
