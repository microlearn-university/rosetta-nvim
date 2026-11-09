// EXERCISE — Network Delay Time (TypeScript)
//
// There are `n` nodes labeled 1..n. `times[i] = [u, v, w]` is a DIRECTED
// edge: a signal sent from u reaches v after w time units (w >= 0).
// A signal is sent from node `k`. Return how long it takes for ALL n nodes
// to receive it, or -1 if some node is unreachable.
//
//   networkDelayTime([[2, 1, 1], [2, 3, 1], [3, 4, 1]], 4, 2)  ->  2
//   networkDelayTime([[1, 2, 1]], 2, 2)                        ->  -1
//
// Approach: Dijkstra's shortest paths from k. The answer is the LARGEST of
// the shortest distances — the last node to hear the signal. JS has no
// built-in heap: write a small binary heap, or (since n is small) scan for
// the closest unsettled node each round (O(n²) Dijkstra).

export function networkDelayTime(times: number[][], n: number, k: number): number {
  throw new Error("implement networkDelayTime");
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

import { test } from "node:test";
import assert from "node:assert/strict";

test("classic",                  () => assert.equal(networkDelayTime([[2, 1, 1], [2, 3, 1], [3, 4, 1]], 4, 2),             2));
test("single_edge",              () => assert.equal(networkDelayTime([[1, 2, 1]], 2, 1),                                   1));
// edges are directed: 2 can't reach 1
test("unreachable",              () => assert.equal(networkDelayTime([[1, 2, 1]], 2, 2),                                   -1));
test("single_node",              () => assert.equal(networkDelayTime([], 1, 1),                                            0));
test("isolated_node",            () => assert.equal(networkDelayTime([[1, 2, 1]], 3, 1),                                   -1));
// direct 1->3 costs 10, but 1->2->3 costs 2
test("indirect_path_is_shorter", () => assert.equal(networkDelayTime([[1, 3, 10], [1, 2, 1], [2, 3, 1]], 3, 1),            2));
// BFS by hop count would settle 4 via 1->4 (9); Dijkstra finds 1->2->3->4 (3)
test("fewest_hops_not_shortest", () => assert.equal(networkDelayTime([[1, 4, 9], [1, 2, 1], [2, 3, 1], [3, 4, 1]], 4, 1),  3));
test("zero_weight_edges",        () => assert.equal(networkDelayTime([[1, 2, 0], [2, 3, 0]], 3, 1),                        0));
test("cycle",                    () => assert.equal(networkDelayTime([[1, 2, 1], [2, 3, 2], [3, 1, 4]], 3, 1),             3));
