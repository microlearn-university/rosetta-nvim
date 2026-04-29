// EXERCISE — Binary Search (TypeScript)
//
// Implement `binarySearch` on a sorted array.
// Return the index of target, or -1 if not present.
//
//   binarySearch([1, 3, 5, 7, 9], 5)  ->  2
//   binarySearch([1, 3, 5, 7, 9], 4)  -> -1

export function binarySearch(arr: number[], target: number): number {
  throw new Error("implement binarySearch");
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

import { test } from "node:test";
import assert from "node:assert/strict";

test("found_middle", () => assert.equal(binarySearch([1, 3, 5, 7, 9], 5), 2));
test("found_first",  () => assert.equal(binarySearch([1, 3, 5, 7, 9], 1), 0));
test("found_last",   () => assert.equal(binarySearch([1, 3, 5, 7, 9], 9), 4));
test("missing",      () => assert.equal(binarySearch([1, 3, 5, 7, 9], 4), -1));
test("empty",        () => assert.equal(binarySearch([], 1), -1));
test("single_hit",   () => assert.equal(binarySearch([42], 42), 0));
test("single_miss",  () => assert.equal(binarySearch([42], 7), -1));
