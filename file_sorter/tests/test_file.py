from parameterized import parameterized
import unittest

from file import File

class TestIsDuplicate(unittest.TestCase):
    @parameterized.expand([
        ["file(1)"],
        ["file (1)"],
        ["file (21345670)"],
        ["file         (1)"]
    ])
    def test_is_duplicate(self, file_name: str):
        file = File(file_name, "", 0, "")
        self.assertTrue(file.is_duplicate())

    @parameterized.expand([
        ["file"],
        ["file (0)"],
        ["file ()"],
        ["file ("],
        ["file)"],
        ["file (0123456)"]
    ])
    def test_is_not_duplicate(self, file_name: str):
        file = File(file_name, "", 0, "")
        self.assertFalse(file.is_duplicate())