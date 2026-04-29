// EXERCISE — Merge Intervals (TypeScript)
//
// Given an array of intervals [start, end], merge all overlapping intervals
// and return the result sorted by start. Touching intervals (e.g. [1,3]
// and [3,5]) count as overlapping and merge into one.
//
//   mergeIntervals([[1,3],[2,6],[8,10],[15,18]])  ->  [[1,6],[8,10],[15,18]]
//   mergeIntervals([[1,4],[4,5]])                 ->  [[1,5]]

export function mergeIntervals(intervals: number[][]): number[][] {
  throw new Error("implement mergeIntervals");
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

import { test } from "node:test";
import assert from "node:assert/strict";

test("empty",       () => assert.deepEqual(mergeIntervals([]),                                  []));
test("single",      () => assert.deepEqual(mergeIntervals([[1, 4]]),                            [[1, 4]]));
test("classic",     () => assert.deepEqual(mergeIntervals([[1,3],[2,6],[8,10],[15,18]]),        [[1,6],[8,10],[15,18]]));
test("touching",    () => assert.deepEqual(mergeIntervals([[1, 4], [4, 5]]),                    [[1, 5]]));
test("disjoint",    () => assert.deepEqual(mergeIntervals([[1, 2], [3, 4], [5, 6]]),            [[1, 2], [3, 4], [5, 6]]));
test("unsorted",    () => assert.deepEqual(mergeIntervals([[15,18],[1,3],[8,10],[2,6]]),        [[1,6],[8,10],[15,18]]));
test("all_overlap", () => assert.deepEqual(mergeIntervals([[1, 4], [2, 3], [3, 5]]),            [[1, 5]]));
