# EXERCISE — Number of Islands (Python)
#
# Given a 2D grid of '1' (land) and '0' (water), count the number of
# islands. An island is a group of 1s connected 4-directionally
# (up/down/left/right). Diagonals don't count.
#
#   num_islands([
#       ['1','1','0','0','0'],
#       ['1','1','0','0','0'],
#       ['0','0','1','0','0'],
#       ['0','0','0','1','1'],
#   ])  ->  3
#
# Approach: scan the grid; when you hit a '1', flood-fill (BFS or DFS)
# and increment the count. Mark visited cells (e.g. flip to '0') to avoid
# recounting.


def num_islands(grid):
    raise NotImplementedError("implement num_islands")


# ─── Tests ────────────────────────────────────────────────────────────────────
# Do not edit below this line.

import unittest


def _grid(rows):
    return [list(r) for r in rows]


class TestNumIslands(unittest.TestCase):
    def test_empty(self):
        self.assertEqual(num_islands([]), 0)

    def test_all_water(self):
        self.assertEqual(num_islands(_grid(["000", "000", "000"])), 0)

    def test_all_land(self):
        self.assertEqual(num_islands(_grid(["111", "111", "111"])), 1)

    def test_single_cell(self):
        self.assertEqual(num_islands(_grid(["1"])), 1)

    def test_classic(self):
        self.assertEqual(
            num_islands(_grid(["11000", "11000", "00100", "00011"])),
            3,
        )

    def test_diagonal_not_connected(self):
        self.assertEqual(num_islands(_grid(["101", "010", "101"])), 5)


if __name__ == "__main__":
    unittest.main()
