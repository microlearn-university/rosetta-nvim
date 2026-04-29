// EXERCISE — Course Schedule (Rust)
//
// There are `num_courses` labeled 0..num_courses. `prerequisites[i] = vec![a, b]`
// means you must take course b before course a. Return true if you can finish
// all courses (the dependency graph has no cycle), else false.
//
// Approach: detect a cycle in a directed graph — Kahn's BFS topo-sort, or
// DFS with a three-color marking (unvisited / in-stack / done).
//
//   can_finish(2, vec![vec![1, 0]])                  ->  true
//   can_finish(2, vec![vec![1, 0], vec![0, 1]])      ->  false  (cycle)

pub fn can_finish(num_courses: i32, prerequisites: Vec<Vec<i32>>) -> bool {
    todo!()
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn no_prereqs() {
        assert!(can_finish(3, vec![]));
    }

    #[test]
    fn simple_chain() {
        assert!(can_finish(2, vec![vec![1, 0]]));
    }

    #[test]
    fn simple_cycle() {
        assert!(!can_finish(2, vec![vec![1, 0], vec![0, 1]]));
    }

    #[test]
    fn long_chain() {
        assert!(can_finish(4, vec![vec![1, 0], vec![2, 1], vec![3, 2]]));
    }

    #[test]
    fn diamond() {
        assert!(can_finish(
            4,
            vec![vec![1, 0], vec![2, 0], vec![3, 1], vec![3, 2]]
        ));
    }

    #[test]
    fn three_cycle() {
        assert!(!can_finish(3, vec![vec![0, 1], vec![1, 2], vec![2, 0]]));
    }

    #[test]
    fn disconnected_with_cycle() {
        assert!(!can_finish(
            5,
            vec![vec![1, 0], vec![3, 4], vec![4, 3]]
        ));
    }

    #[test]
    fn self_loop() {
        assert!(!can_finish(1, vec![vec![0, 0]]));
    }
}
