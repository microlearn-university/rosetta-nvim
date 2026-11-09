// EXERCISE — Coin Change (TypeScript)
//
// Given an array of coin denominations and a target `amount`, return the
// FEWEST number of coins that sum to `amount`. Each denomination can be
// used any number of times. Return -1 if the amount can't be made.
// An amount of 0 needs 0 coins.
//
//   coinChange([1, 2, 5], 11)  ->  3    (5 + 5 + 1)
//   coinChange([2], 3)         ->  -1
//
// Approach: bottom-up DP. dp[a] = fewest coins to make amount a.
// dp[0] = 0; dp[a] = 1 + min(dp[a - c]) over every coin c <= a.
// Greedy (always take the biggest coin) is NOT correct — see the tests.

export function coinChange(coins: number[], amount: number): number {
  throw new Error("implement coinChange");
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

import { test } from "node:test";
import assert from "node:assert/strict";

test("classic",             () => assert.equal(coinChange([1, 2, 5], 11),               3));
test("impossible",          () => assert.equal(coinChange([2], 3),                      -1));
test("zero_amount",         () => assert.equal(coinChange([1], 0),                      0));
test("single_coin_exact",   () => assert.equal(coinChange([7], 21),                     3));
// greedy takes 4+1+1 (3 coins); optimal is 3+3 (2 coins)
test("greedy_fails",        () => assert.equal(coinChange([1, 3, 4], 6),                2));
test("unsorted_coins",      () => assert.equal(coinChange([5, 1, 2], 7),                2));
test("no_ones_reachable",   () => assert.equal(coinChange([3, 7], 13),                  3));
test("no_ones_unreachable", () => assert.equal(coinChange([3, 7], 11),                  -1));
test("larger_amount",       () => assert.equal(coinChange([186, 419, 83, 408], 6249),   20));
