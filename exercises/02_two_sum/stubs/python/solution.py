# EXERCISE — Two Sum (Python)
#
# Given a list of integers and a target, return the indices (i, j) of the
# two distinct elements that sum to target. Exactly one solution exists.
# Return the pair with i < j.
#
#   two_sum([2, 7, 11, 15], 9)  ->  (0, 1)
#   two_sum([3, 2, 4], 6)       ->  (1, 2)


def two_sum(nums, target):
    raise NotImplementedError("implement two_sum")


# ─── Tests ────────────────────────────────────────────────────────────────────
# Do not edit below this line.

import unittest


class TestTwoSum(unittest.TestCase):
    def test_basic(self):
        self.assertEqual(two_sum([2, 7, 11, 15], 9), (0, 1))

    def test_middle(self):
        self.assertEqual(two_sum([3, 2, 4], 6), (1, 2))

    def test_duplicates(self):
        self.assertEqual(two_sum([3, 3], 6), (0, 1))

    def test_negatives(self):
        self.assertEqual(two_sum([-3, 4, 3, 90], 0), (0, 2))

    def test_last_two(self):
        self.assertEqual(two_sum([1, 5, 8, 13, 21], 34), (3, 4))


if __name__ == "__main__":
    unittest.main()
