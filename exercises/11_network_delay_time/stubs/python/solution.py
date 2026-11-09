# EXERCISE — Network Delay Time (Python)
#
# There are `n` nodes labeled 1..n. `times[i] = [u, v, w]` is a DIRECTED
# edge: a signal sent from u reaches v after w time units (w >= 0).
# A signal is sent from node `k`. Return how long it takes for ALL n nodes
# to receive it, or -1 if some node is unreachable.
#
#   network_delay_time([[2, 1, 1], [2, 3, 1], [3, 4, 1]], 4, 2)  ->  2
#   network_delay_time([[1, 2, 1]], 2, 2)                        ->  -1
#
# Approach: Dijkstra's shortest paths from k. The answer is the LARGEST of
# the shortest distances — the last node to hear the signal. Use a
# min-heap (heapq) keyed on distance.


def network_delay_time(times, n, k):
    raise NotImplementedError("implement network_delay_time")


# ─── Tests ────────────────────────────────────────────────────────────────────
# Do not edit below this line.

import unittest


class TestNetworkDelayTime(unittest.TestCase):
    def test_classic(self):
        self.assertEqual(
            network_delay_time([[2, 1, 1], [2, 3, 1], [3, 4, 1]], 4, 2), 2
        )

    def test_single_edge(self):
        self.assertEqual(network_delay_time([[1, 2, 1]], 2, 1), 1)

    def test_unreachable(self):
        # edges are directed: 2 can't reach 1
        self.assertEqual(network_delay_time([[1, 2, 1]], 2, 2), -1)

    def test_single_node(self):
        self.assertEqual(network_delay_time([], 1, 1), 0)

    def test_isolated_node(self):
        self.assertEqual(network_delay_time([[1, 2, 1]], 3, 1), -1)

    def test_indirect_path_is_shorter(self):
        # direct 1->3 costs 10, but 1->2->3 costs 2
        self.assertEqual(
            network_delay_time([[1, 3, 10], [1, 2, 1], [2, 3, 1]], 3, 1), 2
        )

    def test_fewest_hops_not_shortest(self):
        # BFS by hop count would settle 4 via 1->4 (9); Dijkstra finds 1->2->3->4 (3)
        self.assertEqual(
            network_delay_time(
                [[1, 4, 9], [1, 2, 1], [2, 3, 1], [3, 4, 1]], 4, 1
            ),
            3,
        )

    def test_zero_weight_edges(self):
        self.assertEqual(network_delay_time([[1, 2, 0], [2, 3, 0]], 3, 1), 0)

    def test_cycle(self):
        self.assertEqual(
            network_delay_time([[1, 2, 1], [2, 3, 2], [3, 1, 4]], 3, 1), 3
        )


if __name__ == "__main__":
    unittest.main()
