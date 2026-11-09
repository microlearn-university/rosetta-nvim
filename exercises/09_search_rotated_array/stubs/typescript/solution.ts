// EXERCISE — Search in Rotated Sorted Array (TypeScript)
//
// `nums` is a sorted array of DISTINCT integers that has been rotated at
// some unknown pivot (e.g. [0,1,2,4,5,6,7] -> [4,5,6,7,0,1,2]). Return the
// index of `target`, or -1 if it isn't present. Must run in O(log n).
//
//   search([4, 5, 6, 7, 0, 1, 2], 0)  ->  4
//   search([4, 5, 6, 7, 0, 1, 2], 3)  ->  -1
//
// Approach: modified binary search. At every mid, at least one half
// (lo..mid or mid..hi) is in sorted order — check whether target falls
// inside that half's range, and discard the other half if so.

export function search(nums: number[], target: number): number {
  throw new Error("implement search");
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

import { test } from "node:test";
import assert from "node:assert/strict";

test("found_after_pivot",    () => assert.equal(search([4, 5, 6, 7, 0, 1, 2], 0), 4));
test("found_before_pivot",   () => assert.equal(search([4, 5, 6, 7, 0, 1, 2], 5), 1));
test("missing",              () => assert.equal(search([4, 5, 6, 7, 0, 1, 2], 3), -1));
test("not_rotated",          () => assert.equal(search([1, 2, 3, 4, 5], 4),       3));
test("pivot_at_end",         () => assert.equal(search([2, 3, 4, 5, 1], 1),       4));
test("pivot_at_start",       () => assert.equal(search([5, 1, 2, 3, 4], 5),       0));
test("empty",                () => assert.equal(search([], 1),                    -1));
test("single_hit",           () => assert.equal(search([1], 1),                   0));
test("single_miss",          () => assert.equal(search([1], 0),                   -1));
test("two_elements_rotated", () => assert.equal(search([3, 1], 1),                1));
