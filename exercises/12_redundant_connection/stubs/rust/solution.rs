// EXERCISE — Redundant Connection (Rust)
//
// A tree with `n` nodes labeled 1..=n had ONE extra undirected edge added,
// so `edges` has n edges and exactly one cycle. Return the edge that can be
// removed to leave a tree again. If several edges would work, return the
// one that appears LAST in `edges`.
//
//   find_redundant_connection(vec![vec![1, 2], vec![1, 3], vec![2, 3]])  ->  vec![2, 3]
//
// Approach: union-find (disjoint set union). Walk the edges in order; for
// each [u, v], if find(u) == find(v) they're already connected, so this
// edge closes the cycle — return it. Otherwise union(u, v). A `parent:
// Vec<usize>` plus a recursive or iterative `find` is all you need.

pub fn find_redundant_connection(edges: Vec<Vec<i32>>) -> Vec<i32> {
    todo!()
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn triangle() {
        assert_eq!(
            find_redundant_connection(vec![vec![1, 2], vec![1, 3], vec![2, 3]]),
            vec![2, 3]
        );
    }

    #[test]
    fn cycle_with_tail() {
        assert_eq!(
            find_redundant_connection(vec![
                vec![1, 2],
                vec![2, 3],
                vec![3, 4],
                vec![1, 4],
                vec![1, 5]
            ]),
            vec![1, 4]
        );
    }

    #[test]
    fn two_node_cycle() {
        assert_eq!(
            find_redundant_connection(vec![vec![1, 2], vec![2, 1]]),
            vec![2, 1]
        );
    }

    #[test]
    fn cycle_closed_early() {
        // cycle 1-2-3 closes at the 3rd edge; later edges are tree edges
        assert_eq!(
            find_redundant_connection(vec![
                vec![1, 2],
                vec![2, 3],
                vec![3, 1],
                vec![3, 4],
                vec![4, 5]
            ]),
            vec![3, 1]
        );
    }

    #[test]
    fn long_chain_closing() {
        assert_eq!(
            find_redundant_connection(vec![
                vec![2, 3],
                vec![5, 4],
                vec![1, 2],
                vec![4, 3],
                vec![1, 5]
            ]),
            vec![1, 5]
        );
    }

    #[test]
    fn merges_two_components() {
        // {1,2} and {3,4} grow separately, join via 2-3, then 1-4 closes the cycle
        assert_eq!(
            find_redundant_connection(vec![vec![1, 2], vec![3, 4], vec![2, 3], vec![1, 4]]),
            vec![1, 4]
        );
    }
}
