# EXERCISE — Binary Search (Python)
#
# Implement `binary_search` on a sorted list.
# Return the index of `target`, or -1 if not present.
#
#   binary_search([1, 3, 5, 7, 9], 5)  ->  2
#   binary_search([1, 3, 5, 7, 9], 4)  -> -1


def binary_search(arr, target):
    raise NotImplementedError("implement binary_search")


# ─── Tests ────────────────────────────────────────────────────────────────────
# Do not edit below this line.

import unittest


class TestBinarySearch(unittest.TestCase):
    def test_found_middle(self):
        self.assertEqual(binary_search([1, 3, 5, 7, 9], 5), 2)

    def test_found_first(self):
        self.assertEqual(binary_search([1, 3, 5, 7, 9], 1), 0)

    def test_found_last(self):
        self.assertEqual(binary_search([1, 3, 5, 7, 9], 9), 4)

    def test_missing(self):
        self.assertEqual(binary_search([1, 3, 5, 7, 9], 4), -1)

    def test_empty(self):
        self.assertEqual(binary_search([], 1), -1)

    def test_single_hit(self):
        self.assertEqual(binary_search([42], 42), 0)

    def test_single_miss(self):
        self.assertEqual(binary_search([42], 7), -1)


if __name__ == "__main__":
    unittest.main()
