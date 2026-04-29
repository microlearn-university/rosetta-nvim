// EXERCISE — Maximum Subarray (TypeScript)
//
// Given a non-empty array of integers (may include negatives), return the
// largest sum of any contiguous subarray. Must run in O(n) — Kadane's
// algorithm. The tests include a large input where O(n²) would hang.
//
//   maxSubarray([-2, 1, -3, 4, -1, 2, 1, -5, 4])  ->  6
//   maxSubarray([-3, -1, -2])                     -> -1

export function maxSubarray(nums: number[]): number {
  throw new Error("implement maxSubarray");
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

import { test } from "node:test";
import assert from "node:assert/strict";

test("classic",      () => assert.equal(maxSubarray([-2, 1, -3, 4, -1, 2, 1, -5, 4]),  6));
test("single",       () => assert.equal(maxSubarray([5]),                              5));
test("all_positive", () => assert.equal(maxSubarray([1, 2, 3, 4]),                    10));
test("all_negative", () => assert.equal(maxSubarray([-3, -1, -2]),                    -1));
test("mixed",        () => assert.equal(maxSubarray([5, 4, -1, 7, 8]),                23));
test("two",          () => assert.equal(maxSubarray([-2, -1]),                        -1));
