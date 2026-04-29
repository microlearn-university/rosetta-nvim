# EXERCISE — Course Schedule (Python)
#
# There are `num_courses` labeled 0..num_courses-1. `prerequisites[i] = [a, b]`
# means you must take course b before course a. Return True if you can finish
# all courses (the dependency graph has no cycle), else False.
#
# Approach: detect a cycle in a directed graph — Kahn's BFS topo-sort, or
# DFS with a three-color marking (unvisited / in-stack / done).
#
#   can_finish(2, [[1, 0]])           ->  True   (take 0, then 1)
#   can_finish(2, [[1, 0], [0, 1]])   ->  False  (cycle)


def can_finish(num_courses, prerequisites):
    raise NotImplementedError("implement can_finish")


# ─── Tests ────────────────────────────────────────────────────────────────────
# Do not edit below this line.

import unittest


class TestCanFinish(unittest.TestCase):
    def test_no_prereqs(self):
        self.assertTrue(can_finish(3, []))

    def test_simple_chain(self):
        self.assertTrue(can_finish(2, [[1, 0]]))

    def test_simple_cycle(self):
        self.assertFalse(can_finish(2, [[1, 0], [0, 1]]))

    def test_long_chain(self):
        self.assertTrue(can_finish(4, [[1, 0], [2, 1], [3, 2]]))

    def test_diamond(self):
        # 0 -> 1 -> 3, 0 -> 2 -> 3 (DAG, finishable)
        self.assertTrue(can_finish(4, [[1, 0], [2, 0], [3, 1], [3, 2]]))

    def test_three_cycle(self):
        self.assertFalse(can_finish(3, [[0, 1], [1, 2], [2, 0]]))

    def test_disconnected_with_cycle(self):
        # one valid chain (0->1) plus an isolated 2-cycle (3<->4)
        self.assertFalse(can_finish(5, [[1, 0], [3, 4], [4, 3]]))

    def test_self_loop(self):
        self.assertFalse(can_finish(1, [[0, 0]]))


if __name__ == "__main__":
    unittest.main()
