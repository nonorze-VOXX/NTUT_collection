import unittest
import tf05 as tf
from copy import deepcopy


class TestIdempotent(unittest.TestCase):
    def test_read_file(self):
        '''
        becase the read_file function have same input but not same output
        the function is not idempotent
        because the function read file and use + to put into the data
        '''
        tf.read_file('../stop_words.txt')
        once = deepcopy(tf.data)
        tf.read_file('../stop_words.txt')
        twice = deepcopy(tf.data)
        self.assertNotEqual(once, twice)

    def test_filter_chars_and_normalize(self):
        '''
        normalize function let:
        A -> a
        a -> a
        1 -> ' '
        ' ' -> ' '
        so the function is idempotent
        '''
        tf.data = ['a', 'A', '1', ' ']
        tf.filter_chars_and_normalize()
        once = deepcopy(tf.data)
        tf.filter_chars_and_normalize()
        twice = deepcopy(tf.data)
        self.assertEqual(once, twice)

    def test_scan(self):
        '''
        scan function is not idempotent
        because the function use + to put into the words
        '''
        tf.data = ['a', 'A', '1', ' ']
        tf.scan()
        once = deepcopy(tf.words)
        tf.scan()
        twice = deepcopy(tf.words)
        self.assertNotEqual(once, twice)

    def test_remove_stop_words(self):
        '''
        remove_stop_words function is idempotent
        because the function remove word from the words by stop_wordks
        so run the function twice will get the same result
        '''
        tf.words = ['aa', 'AA', '11', 'bb']
        tf.remove_stop_words()
        once = deepcopy(tf.words)
        tf.remove_stop_words()
        twice = deepcopy(tf.words)
        self.assertEqual(once, twice)

    def test_frequencies(self):
        '''
        frequencies function is not idempotent
        because run the function twice will get different result
        the function no clear word_freqs in the beginning
        '''
        tf.words = ['aa', 'AA', '11', 'bb']
        tf.frequencies()
        once = deepcopy(tf.word_freqs)
        tf.frequencies()
        twice = deepcopy(tf.word_freqs)
        self.assertNotEqual(once, twice)

    def test_sort(self):
        '''
        sort function is idempotent
        because the function sort the word_freqs by frequency
        so run the function twice will get the same result
        '''
        tf.word_freqs = [['aa', 2], ['bb', 1], ['cc', 3]]
        tf.sort()
        once = deepcopy(tf.word_freqs)
        tf.sort()
        twice = deepcopy(tf.word_freqs)
        self.assertEqual(once, twice)


if __name__ == '__main__':
    unittest.main()
