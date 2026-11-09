// EXERCISE — Network Delay Time (Rust)
//
// There are `n` nodes labeled 1..=n. `times[i] = vec![u, v, w]` is a
// DIRECTED edge: a signal sent from u reaches v after w time units
// (w >= 0). A signal is sent from node `k`. Return how long it takes for
// ALL n nodes to receive it, or -1 if some node is unreachable.
//
//   network_delay_time(vec![vec![2, 1, 1], vec![2, 3, 1], vec![3, 4, 1]], 4, 2)  ->  2
//   network_delay_time(vec![vec![1, 2, 1]], 2, 2)                                ->  -1
//
// Approach: Dijkstra's shortest paths from k. The answer is the LARGEST of
// the shortest distances — the last node to hear the signal.
// std::collections::BinaryHeap is a MAX-heap; wrap entries in
// std::cmp::Reverse to pop the smallest distance first.

pub fn network_delay_time(times: Vec<Vec<i32>>, n: i32, k: i32) -> i32 {
    todo!()
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn classic() {
        assert_eq!(
            network_delay_time(vec![vec![2, 1, 1], vec![2, 3, 1], vec![3, 4, 1]], 4, 2),
            2
        );
    }

    #[test]
    fn single_edge() {
        assert_eq!(network_delay_time(vec![vec![1, 2, 1]], 2, 1), 1);
    }

    #[test]
    fn unreachable() {
        // edges are directed: 2 can't reach 1
        assert_eq!(network_delay_time(vec![vec![1, 2, 1]], 2, 2), -1);
    }

    #[test]
    fn single_node() {
        assert_eq!(network_delay_time(vec![], 1, 1), 0);
    }

    #[test]
    fn isolated_node() {
        assert_eq!(network_delay_time(vec![vec![1, 2, 1]], 3, 1), -1);
    }

    #[test]
    fn indirect_path_is_shorter() {
        // direct 1->3 costs 10, but 1->2->3 costs 2
        assert_eq!(
            network_delay_time(vec![vec![1, 3, 10], vec![1, 2, 1], vec![2, 3, 1]], 3, 1),
            2
        );
    }

    #[test]
    fn fewest_hops_not_shortest() {
        // BFS by hop count would settle 4 via 1->4 (9); Dijkstra finds 1->2->3->4 (3)
        assert_eq!(
            network_delay_time(
                vec![vec![1, 4, 9], vec![1, 2, 1], vec![2, 3, 1], vec![3, 4, 1]],
                4,
                1
            ),
            3
        );
    }

    #[test]
    fn zero_weight_edges() {
        assert_eq!(network_delay_time(vec![vec![1, 2, 0], vec![2, 3, 0]], 3, 1), 0);
    }

    #[test]
    fn cycle() {
        assert_eq!(
            network_delay_time(vec![vec![1, 2, 1], vec![2, 3, 2], vec![3, 1, 4]], 3, 1),
            3
        );
    }
}
