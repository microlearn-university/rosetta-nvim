# EXERCISE — Maximum Subarray (Python)
#
# Given a non-empty list of integers (may include negatives), return the
# largest sum of any contiguous subarray. Must run in O(n) — Kadane's
# algorithm. The tests include a large input where O(n²) would hang.
#
#   max_subarray([-2, 1, -3, 4, -1, 2, 1, -5, 4])  ->  6      ([4, -1, 2, 1])
#   max_subarray([-3, -1, -2])                     -> -1      (all negative)


def max_subarray(nums):
    raise NotImplementedError("implement max_subarray")


# ─── Tests ────────────────────────────────────────────────────────────────────
# Do not edit below this line.

import unittest


class TestMaxSubarray(unittest.TestCase):
    def test_classic(self):
        self.assertEqual(max_subarray([-2, 1, -3, 4, -1, 2, 1, -5, 4]), 6)

    def test_single(self):
        self.assertEqual(max_subarray([5]), 5)

    def test_all_positive(self):
        self.assertEqual(max_subarray([1, 2, 3, 4]), 10)

    def test_all_negative(self):
        self.assertEqual(max_subarray([-3, -1, -2]), -1)

    def test_mixed(self):
        self.assertEqual(max_subarray([5, 4, -1, 7, 8]), 23)

    def test_two(self):
        self.assertEqual(max_subarray([-2, -1]), -1)


if __name__ == "__main__":
    unittest.main()
