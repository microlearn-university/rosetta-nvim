// EXERCISE — Course Schedule (TypeScript)
//
// There are `numCourses` labeled 0..numCourses-1. `prerequisites[i] = [a, b]`
// means you must take course b before course a. Return true if you can finish
// all courses (the dependency graph has no cycle), else false.
//
// Approach: detect a cycle in a directed graph — Kahn's BFS topo-sort, or
// DFS with a three-color marking (unvisited / in-stack / done).
//
//   canFinish(2, [[1, 0]])           ->  true
//   canFinish(2, [[1, 0], [0, 1]])   ->  false  (cycle)

export function canFinish(numCourses: number, prerequisites: number[][]): boolean {
  throw new Error("implement canFinish");
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

import { test } from "node:test";
import assert from "node:assert/strict";

test("no_prereqs",              () => assert.equal(canFinish(3, []),                                true));
test("simple_chain",            () => assert.equal(canFinish(2, [[1, 0]]),                          true));
test("simple_cycle",            () => assert.equal(canFinish(2, [[1, 0], [0, 1]]),                  false));
test("long_chain",              () => assert.equal(canFinish(4, [[1, 0], [2, 1], [3, 2]]),          true));
test("diamond",                 () => assert.equal(canFinish(4, [[1, 0], [2, 0], [3, 1], [3, 2]]),  true));
test("three_cycle",             () => assert.equal(canFinish(3, [[0, 1], [1, 2], [2, 0]]),          false));
test("disconnected_with_cycle", () => assert.equal(canFinish(5, [[1, 0], [3, 4], [4, 3]]),          false));
test("self_loop",               () => assert.equal(canFinish(1, [[0, 0]]),                          false));
