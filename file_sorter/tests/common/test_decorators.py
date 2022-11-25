from parameterized import parameterized
import unittest

from common.decorators import positional_arguments_validation


FAILURE = "failure"
SUCCESS = "success"


class TestPositionalArgumentValidation(unittest.TestCase):
    def error_handling(*args):
        return FAILURE

    @positional_arguments_validation(error_handling)
    def under_test_one_argument(arg):
        return arg

    @positional_arguments_validation(error_handling)
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
        [""],
        [None]
    ])
    def test_failure_one_argument(self, input):
        response = \
            TestPositionalArgumentValidation.under_test_one_argument(input)
        self.assertEqual(response, FAILURE)

    @parameterized.expand([
        [SUCCESS, ""],
        ["", SUCCESS],
        ["", ""],
        [SUCCESS, None],
        [None, SUCCESS],
        [None, None],
        ["", None]
    ])
    def test_failure_two_arguments(self, arg1, arg2):
        response = \
            TestPositionalArgumentValidation.under_test_two_arguments(
                arg1, arg2)
        self.assertEqual(response, FAILURE)
