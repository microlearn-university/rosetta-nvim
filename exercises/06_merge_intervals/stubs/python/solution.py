# EXERCISE — Merge Intervals (Python)
#
# Given a list of intervals [start, end], merge all overlapping intervals
# and return the result sorted by start. Touching intervals (e.g. [1,3]
# and [3,5]) count as overlapping and merge into one.
#
#   merge_intervals([[1,3],[2,6],[8,10],[15,18]])  ->  [[1,6],[8,10],[15,18]]
#   merge_intervals([[1,4],[4,5]])                 ->  [[1,5]]


def merge_intervals(intervals):
    raise NotImplementedError("implement merge_intervals")


# ─── Tests ────────────────────────────────────────────────────────────────────
# Do not edit below this line.

import unittest


class TestMergeIntervals(unittest.TestCase):
    def test_empty(self):
        self.assertEqual(merge_intervals([]), [])

    def test_single(self):
        self.assertEqual(merge_intervals([[1, 4]]), [[1, 4]])

    def test_classic(self):
        self.assertEqual(
            merge_intervals([[1, 3], [2, 6], [8, 10], [15, 18]]),
            [[1, 6], [8, 10], [15, 18]],
        )

    def test_touching(self):
        self.assertEqual(merge_intervals([[1, 4], [4, 5]]), [[1, 5]])

    def test_disjoint(self):
        self.assertEqual(
            merge_intervals([[1, 2], [3, 4], [5, 6]]),
            [[1, 2], [3, 4], [5, 6]],
        )

    def test_unsorted(self):
        self.assertEqual(
            merge_intervals([[15, 18], [1, 3], [8, 10], [2, 6]]),
            [[1, 6], [8, 10], [15, 18]],
        )

    def test_all_overlap(self):
        self.assertEqual(merge_intervals([[1, 4], [2, 3], [3, 5]]), [[1, 5]])


if __name__ == "__main__":
    unittest.main()
