// EXERCISE — Redundant Connection (TypeScript)
//
// A tree with `n` nodes labeled 1..n had ONE extra undirected edge added,
// so `edges` has n edges and exactly one cycle. Return the edge that can be
// removed to leave a tree again. If several edges would work, return the
// one that appears LAST in `edges`.
//
//   findRedundantConnection([[1, 2], [1, 3], [2, 3]])  ->  [2, 3]
//
// Approach: union-find (disjoint set union). Walk the edges in order; for
// each [u, v], if find(u) == find(v) they're already connected, so this
// edge closes the cycle — return it. Otherwise union(u, v).

export function findRedundantConnection(edges: number[][]): number[] {
  throw new Error("implement findRedundantConnection");
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

import { test } from "node:test";
import assert from "node:assert/strict";

test("triangle",              () => assert.deepEqual(findRedundantConnection([[1, 2], [1, 3], [2, 3]]),                   [2, 3]));
test("cycle_with_tail",       () => assert.deepEqual(findRedundantConnection([[1, 2], [2, 3], [3, 4], [1, 4], [1, 5]]),   [1, 4]));
test("two_node_cycle",        () => assert.deepEqual(findRedundantConnection([[1, 2], [2, 1]]),                           [2, 1]));
// cycle 1-2-3 closes at the 3rd edge; later edges are tree edges
test("cycle_closed_early",    () => assert.deepEqual(findRedundantConnection([[1, 2], [2, 3], [3, 1], [3, 4], [4, 5]]),   [3, 1]));
test("long_chain_closing",    () => assert.deepEqual(findRedundantConnection([[2, 3], [5, 4], [1, 2], [4, 3], [1, 5]]),   [1, 5]));
// {1,2} and {3,4} grow separately, join via 2-3, then 1-4 closes the cycle
test("merges_two_components", () => assert.deepEqual(findRedundantConnection([[1, 2], [3, 4], [2, 3], [1, 4]]),           [1, 4]));
