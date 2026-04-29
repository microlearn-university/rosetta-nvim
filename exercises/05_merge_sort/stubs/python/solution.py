# EXERCISE — Merge Sort (Python)
#
# Implement `merge_sort(nums)` returning a NEW sorted list (ascending).
# Classic divide-and-conquer: split, recursively sort each half, merge.
# Target O(n log n) time, O(n) extra space. Don't call list.sort or sorted.
#
#   merge_sort([5, 2, 4, 1, 3])  ->  [1, 2, 3, 4, 5]
#   merge_sort([])               ->  []


def merge_sort(nums):
    raise NotImplementedError("implement merge_sort")


# ─── Tests ────────────────────────────────────────────────────────────────────
# Do not edit below this line.

import unittest


class TestMergeSort(unittest.TestCase):
    def test_empty(self):
        self.assertEqual(merge_sort([]), [])

    def test_single(self):
        self.assertEqual(merge_sort([7]), [7])

    def test_sorted(self):
        self.assertEqual(merge_sort([1, 2, 3, 4, 5]), [1, 2, 3, 4, 5])

    def test_reverse(self):
        self.assertEqual(merge_sort([5, 4, 3, 2, 1]), [1, 2, 3, 4, 5])

    def test_mixed(self):
        self.assertEqual(merge_sort([5, 2, 4, 1, 3]), [1, 2, 3, 4, 5])

    def test_duplicates(self):
        self.assertEqual(merge_sort([3, 1, 2, 3, 1]), [1, 1, 2, 3, 3])

    def test_negatives(self):
        self.assertEqual(merge_sort([-2, 5, 0, -7, 3]), [-7, -2, 0, 3, 5])


if __name__ == "__main__":
    unittest.main()
