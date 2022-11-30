from parameterized import parameterized
import unittest

from common.decorators import positional_arguments_notNullorEmpty


FAILURE = "failure"
SUCCESS = "success"


class TestPositionalArgumentValidation(unittest.TestCase):
    def error_handling(*args):
        return FAILURE

    @positional_arguments_notNullorEmpty(error_handling)
    def under_test_one_argument(arg):
        return arg

    @positional_arguments_notNullorEmpty(error_handling)
    def under_test_two_arguments(arg1, arg2):
        return (arg1, arg2)

    def test_success_one_argument(self):
        response = \
            TestPositionalArgumentValidation.under_test_one_argument(SUCCESS)
        self.assertEqual(response, SUCCESS)

    def test_success_two_arguments(self):
        response = \
            TestPositionalArgumentValidation.under_test_two_arguments(
                SUCCESS, SUCCESS)
        self.assertEqual(response, (SUCCESS, SUCCESS))

    @parameterized.expand([
        ["Empty String", ""],
        ["None", None]
    ])
    def test_failure_one_argument(self, _title, input):
        response = \
            TestPositionalArgumentValidation.under_test_one_argument(input)
        self.assertEqual(response, FAILURE)

    @parameterized.expand([
        ["First argument valid, second empty", SUCCESS, ""],
        ["First empty, second valid", "", SUCCESS],
        ["First empty, second empty", "", ""],
        ["First valid, second none", SUCCESS, None],
        ["First none, second valid", None, SUCCESS],
        ["First none, second none", None, None],
        ["First empty, second none", "", None]
    ])
    def test_failure_two_arguments(self, _title, arg1, arg2):
        response = \
            TestPositionalArgumentValidation.under_test_two_arguments(
                arg1, arg2)
        self.assertEqual(response, FAILURE)
