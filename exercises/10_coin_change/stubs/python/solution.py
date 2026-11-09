# EXERCISE — Coin Change (Python)
#
# Given a list of coin denominations and a target `amount`, return the
# FEWEST number of coins that sum to `amount`. Each denomination can be
# used any number of times. Return -1 if the amount can't be made.
# An amount of 0 needs 0 coins.
#
#   coin_change([1, 2, 5], 11)  ->  3    (5 + 5 + 1)
#   coin_change([2], 3)         ->  -1
#
# Approach: bottom-up DP. dp[a] = fewest coins to make amount a.
# dp[0] = 0; dp[a] = 1 + min(dp[a - c]) over every coin c <= a.
# Greedy (always take the biggest coin) is NOT correct — see the tests.


def coin_change(coins, amount):
    raise NotImplementedError("implement coin_change")


# ─── Tests ────────────────────────────────────────────────────────────────────
# Do not edit below this line.

import unittest


class TestCoinChange(unittest.TestCase):
    def test_classic(self):
        self.assertEqual(coin_change([1, 2, 5], 11), 3)

    def test_impossible(self):
        self.assertEqual(coin_change([2], 3), -1)

    def test_zero_amount(self):
        self.assertEqual(coin_change([1], 0), 0)

    def test_single_coin_exact(self):
        self.assertEqual(coin_change([7], 21), 3)

    def test_greedy_fails(self):
        # greedy takes 4+1+1 (3 coins); optimal is 3+3 (2 coins)
        self.assertEqual(coin_change([1, 3, 4], 6), 2)

    def test_unsorted_coins(self):
        self.assertEqual(coin_change([5, 1, 2], 7), 2)

    def test_no_ones_reachable(self):
        self.assertEqual(coin_change([3, 7], 13), 3)

    def test_no_ones_unreachable(self):
        self.assertEqual(coin_change([3, 7], 11), -1)

    def test_larger_amount(self):
        self.assertEqual(coin_change([186, 419, 83, 408], 6249), 20)


if __name__ == "__main__":
    unittest.main()
