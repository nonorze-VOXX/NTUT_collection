import unittest
from tf06 import remove_stop_words

class TestRemoveStopWords(unittest.TestCase):
    def test_remove_stop_words(self):
        result = remove_stop_words(['a', 'b', 'c'])("stop_words.txt")
        expected = ['a']
        self.assertEqual(result, expected)

