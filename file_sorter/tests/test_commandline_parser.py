from parameterized import parameterized
import unittest

from commandline_parser import InputConfiguration, \
    InputParsed, parse_command_line_arguments, \
    get_elem_or_empty, get_index


class TestGetElemOrEmpty(unittest.TestCase):
    @parameterized.expand([
        ["Index 0", 0, "1"],
        ["Index 1", 1, "2"],
        ["Index 2", 2, "3"]
    ])
    def test_success(self, _title, index, result):
        response = get_elem_or_empty(("1", "2", "3"), index)
        self.assertEqual(response, result)

    @parameterized.expand([
        ["Low bound", -100000],
        ["Low edge", -1],
        ["High edge", 3],
        ["High bound", 1000]
    ])
    def test_empty(self, _title, index):
        response = get_elem_or_empty(("1", "2", "3"), index)
        self.assertEqual(response, "")


class TestGetIndex(unittest.TestCase):
    target = InputConfiguration("test", "-t", "--test")

    @parameterized.expand([
        ["Index 0, 2 elems", ("-t", "-r"), 0],
        ["Index 0, 1 elem", ("-t",), 0],
        ["Index 1, 2 elems", ("-r", "-t"), 1],
        ["Empty", (), -1],
        ["Not found, 1 elem", ("-r",), -1]
    ])
    def test_shortForm(self, _title, under_test, pretended):
        self.assertEqual(
            get_index(TestGetIndex.target, under_test),
            pretended)

    @parameterized.expand([
        ["Index 0, 2 elems", ("--test", "-r"), 0],
        ["Index 0, 1 elem", ("--test",), 0],
        ["Index 1, 2 elems", ("-r", "--test"), 1],
        ["Empty", (), -1],
        ["Not found, 1 elem", ("-r",), -1]
    ])
    def test_longForm(self, _title, under_test, pretended):
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
            "Found, 2 elem",
            "-t -r",
            (InputConfiguration("test", "-t"),),
            (InputParsed("test", ""),)
        ],
        [
            "Not found, 1 elem",
            "-r",
            (InputConfiguration("test", "-t"),),
            tuple()
        ],
        [
            "Found and value",
            "-t 12",
            (InputConfiguration("test", "-t", retriver=lambda x: x),),
            (InputParsed("test", "12"),)
        ],
        [
            "Found (longform) and value",
            "--test 12",
            (InputConfiguration(
                "test",
                "-t",
                longForm="--test",
                retriver=lambda x: x),),
            (InputParsed("test", "12"),)
        ]
    ])
    def test_parse(self, _title, argv, arguments, expected_parse_arguments):
        under_test = parse_command_line_arguments(argv, arguments)
        self.assertEqual(under_test, expected_parse_arguments)
