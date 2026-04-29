// EXERCISE — Number of Islands (TypeScript)
//
// Given a 2D grid of '1' (land) and '0' (water), count the number of
// islands. An island is a group of 1s connected 4-directionally
// (up/down/left/right). Diagonals don't count.
//
//   numIslands([
//     ['1','1','0','0','0'],
//     ['1','1','0','0','0'],
//     ['0','0','1','0','0'],
//     ['0','0','0','1','1'],
//   ])  ->  3
//
// Approach: scan the grid; when you hit '1', flood-fill (BFS or DFS) and
// increment the count. Mark visited cells (e.g. flip to '0') to avoid
// recounting.

export function numIslands(grid: string[][]): number {
  throw new Error("implement numIslands");
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

import { test } from "node:test";
import assert from "node:assert/strict";

const g = (rows: string[]): string[][] => rows.map((r) => r.split(""));

test("empty",                  () => assert.equal(numIslands([]),                                      0));
test("all_water",              () => assert.equal(numIslands(g(["000", "000", "000"])),                0));
test("all_land",               () => assert.equal(numIslands(g(["111", "111", "111"])),                1));
test("single_cell",            () => assert.equal(numIslands(g(["1"])),                                1));
test("classic",                () => assert.equal(numIslands(g(["11000", "11000", "00100", "00011"])), 3));
test("diagonal_not_connected", () => assert.equal(numIslands(g(["101", "010", "101"])),                5));
