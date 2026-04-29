// EXERCISE — Merge Sort (TypeScript)
//
// Implement `mergeSort(nums)` returning a NEW sorted array (ascending).
// Classic divide-and-conquer: split, recursively sort each half, merge.
// Target O(n log n) time, O(n) extra space. Don't call Array.prototype.sort.
//
//   mergeSort([5, 2, 4, 1, 3])  ->  [1, 2, 3, 4, 5]
//   mergeSort([])               ->  []

export function mergeSort(nums: number[]): number[] {
  throw new Error("implement mergeSort");
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

import { test } from "node:test";
import assert from "node:assert/strict";

test("empty",      () => assert.deepEqual(mergeSort([]),                []));
test("single",     () => assert.deepEqual(mergeSort([7]),               [7]));
test("sorted",     () => assert.deepEqual(mergeSort([1, 2, 3, 4, 5]),   [1, 2, 3, 4, 5]));
test("reverse",    () => assert.deepEqual(mergeSort([5, 4, 3, 2, 1]),   [1, 2, 3, 4, 5]));
test("mixed",      () => assert.deepEqual(mergeSort([5, 2, 4, 1, 3]),   [1, 2, 3, 4, 5]));
test("duplicates", () => assert.deepEqual(mergeSort([3, 1, 2, 3, 1]),   [1, 1, 2, 3, 3]));
test("negatives",  () => assert.deepEqual(mergeSort([-2, 5, 0, -7, 3]), [-7, -2, 0, 3, 5]));
