// EXERCISE — Two Sum (TypeScript)
//
// Given an array of integers and a target, return the indices [i, j] of the
// two distinct elements that sum to target. Exactly one solution exists.
// Return the pair with i < j.
//
//   twoSum([2, 7, 11, 15], 9)  ->  [0, 1]
//   twoSum([3, 2, 4], 6)       ->  [1, 2]

export function twoSum(nums: number[], target: number): [number, number] {
  throw new Error("implement twoSum");
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

import { test } from "node:test";
import assert from "node:assert/strict";

test("basic",      () => assert.deepEqual(twoSum([2, 7, 11, 15], 9), [0, 1]));
test("middle",     () => assert.deepEqual(twoSum([3, 2, 4], 6),      [1, 2]));
test("duplicates", () => assert.deepEqual(twoSum([3, 3], 6),          [0, 1]));
test("negatives",  () => assert.deepEqual(twoSum([-3, 4, 3, 90], 0),  [0, 2]));
test("last_two",   () => assert.deepEqual(twoSum([1, 5, 8, 13, 21], 34), [3, 4]));
