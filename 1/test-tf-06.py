import unittest
from tf06 import remove_stop_words

class TestRemoveStopWords(unittest.TestCase):
    def test_remove_stop_words(self):
        result = remove_stop_words(['aa', 'bb', 'c'])("../stop_words.txt")
        expected = ['aa']
        self.assertEqual(result, expected)


if __name__ == '__main__':
    unittest.main()