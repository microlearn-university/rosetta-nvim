# EXERCISE — Redundant Connection (Python)
#
# A tree with `n` nodes labeled 1..n had ONE extra undirected edge added,
# so `edges` has n edges and exactly one cycle. Return the edge that can be
# removed to leave a tree again. If several edges would work, return the
# one that appears LAST in `edges`.
#
#   find_redundant_connection([[1, 2], [1, 3], [2, 3]])  ->  [2, 3]
#
# Approach: union-find (disjoint set union). Walk the edges in order; for
# each [u, v], if find(u) == find(v) they're already connected, so this
# edge closes the cycle — return it. Otherwise union(u, v).


def find_redundant_connection(edges):
    raise NotImplementedError("implement find_redundant_connection")


# ─── Tests ────────────────────────────────────────────────────────────────────
# Do not edit below this line.

import unittest


class TestFindRedundantConnection(unittest.TestCase):
    def test_triangle(self):
        self.assertEqual(
            find_redundant_connection([[1, 2], [1, 3], [2, 3]]), [2, 3]
        )

    def test_cycle_with_tail(self):
        self.assertEqual(
            find_redundant_connection([[1, 2], [2, 3], [3, 4], [1, 4], [1, 5]]),
            [1, 4],
        )

    def test_two_node_cycle(self):
        self.assertEqual(find_redundant_connection([[1, 2], [2, 1]]), [2, 1])

    def test_cycle_closed_early(self):
        # cycle 1-2-3 closes at the 3rd edge; later edges are tree edges
        self.assertEqual(
            find_redundant_connection([[1, 2], [2, 3], [3, 1], [3, 4], [4, 5]]),
            [3, 1],
        )

    def test_long_chain_closing(self):
        self.assertEqual(
            find_redundant_connection([[2, 3], [5, 4], [1, 2], [4, 3], [1, 5]]),
            [1, 5],
        )

    def test_merges_two_components(self):
        # {1,2} and {3,4} grow separately, join via 2-3, then 1-4 closes the cycle
        self.assertEqual(
            find_redundant_connection([[1, 2], [3, 4], [2, 3], [1, 4]]), [1, 4]
        )


if __name__ == "__main__":
    unittest.main()
