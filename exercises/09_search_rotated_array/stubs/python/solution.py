# EXERCISE — Search in Rotated Sorted Array (Python)
#
# `nums` is a sorted array of DISTINCT integers that has been rotated at
# some unknown pivot (e.g. [0,1,2,4,5,6,7] -> [4,5,6,7,0,1,2]). Return the
# index of `target`, or -1 if it isn't present. Must run in O(log n).
#
#   search([4, 5, 6, 7, 0, 1, 2], 0)  ->  4
#   search([4, 5, 6, 7, 0, 1, 2], 3)  ->  -1
#
# Approach: modified binary search. At every mid, at least one half
# (lo..mid or mid..hi) is in sorted order — check whether target falls
# inside that half's range, and discard the other half if so.


def search(nums, target):
    raise NotImplementedError("implement search")


# ─── Tests ────────────────────────────────────────────────────────────────────
# Do not edit below this line.

import unittest


class TestSearch(unittest.TestCase):
    def test_found_after_pivot(self):
        self.assertEqual(search([4, 5, 6, 7, 0, 1, 2], 0), 4)

    def test_found_before_pivot(self):
        self.assertEqual(search([4, 5, 6, 7, 0, 1, 2], 5), 1)

    def test_missing(self):
        self.assertEqual(search([4, 5, 6, 7, 0, 1, 2], 3), -1)

    def test_not_rotated(self):
        self.assertEqual(search([1, 2, 3, 4, 5], 4), 3)

    def test_pivot_at_end(self):
        self.assertEqual(search([2, 3, 4, 5, 1], 1), 4)

    def test_pivot_at_start(self):
        self.assertEqual(search([5, 1, 2, 3, 4], 5), 0)

    def test_empty(self):
        self.assertEqual(search([], 1), -1)

    def test_single_hit(self):
        self.assertEqual(search([1], 1), 0)

    def test_single_miss(self):
        self.assertEqual(search([1], 0), -1)

    def test_two_elements_rotated(self):
        self.assertEqual(search([3, 1], 1), 1)


if __name__ == "__main__":
    unittest.main()
