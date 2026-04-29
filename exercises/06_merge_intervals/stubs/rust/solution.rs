// EXERCISE — Merge Intervals (Rust)
//
// Given a Vec of intervals [start, end], merge all overlapping intervals
// and return the result sorted by start. Touching intervals (e.g. [1,3]
// and [3,5]) count as overlapping and merge into one.
//
//   merge_intervals(vec![vec![1,3],vec![2,6],vec![8,10],vec![15,18]])
//     -> vec![vec![1,6],vec![8,10],vec![15,18]]

pub fn merge_intervals(intervals: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    todo!()
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn empty() {
        let v: Vec<Vec<i32>> = vec![];
        assert_eq!(merge_intervals(v), Vec::<Vec<i32>>::new());
    }

    #[test]
    fn single() {
        assert_eq!(merge_intervals(vec![vec![1, 4]]), vec![vec![1, 4]]);
    }

    #[test]
    fn classic() {
        assert_eq!(
            merge_intervals(vec![vec![1, 3], vec![2, 6], vec![8, 10], vec![15, 18]]),
            vec![vec![1, 6], vec![8, 10], vec![15, 18]]
        );
    }

    #[test]
    fn touching() {
        assert_eq!(
            merge_intervals(vec![vec![1, 4], vec![4, 5]]),
            vec![vec![1, 5]]
        );
    }

    #[test]
    fn disjoint() {
        assert_eq!(
            merge_intervals(vec![vec![1, 2], vec![3, 4], vec![5, 6]]),
            vec![vec![1, 2], vec![3, 4], vec![5, 6]]
        );
    }

    #[test]
    fn unsorted() {
        assert_eq!(
            merge_intervals(vec![vec![15, 18], vec![1, 3], vec![8, 10], vec![2, 6]]),
            vec![vec![1, 6], vec![8, 10], vec![15, 18]]
        );
    }

    #[test]
    fn all_overlap() {
        assert_eq!(
            merge_intervals(vec![vec![1, 4], vec![2, 3], vec![3, 5]]),
            vec![vec![1, 5]]
        );
    }
}
