// EXERCISE — Search in Rotated Sorted Array (Rust)
//
// `nums` is a sorted slice of DISTINCT integers that has been rotated at
// some unknown pivot (e.g. [0,1,2,4,5,6,7] -> [4,5,6,7,0,1,2]). Return
// `Some(index)` of `target`, or `None` if it isn't present. Must run in
// O(log n).
//
//   search(&[4, 5, 6, 7, 0, 1, 2], 0)  ->  Some(4)
//   search(&[4, 5, 6, 7, 0, 1, 2], 3)  ->  None
//
// Approach: modified binary search. At every mid, at least one half
// (lo..mid or mid..hi) is in sorted order — check whether target falls
// inside that half's range, and discard the other half if so.

pub fn search(nums: &[i32], target: i32) -> Option<usize> {
    todo!()
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn found_after_pivot() {
        assert_eq!(search(&[4, 5, 6, 7, 0, 1, 2], 0), Some(4));
    }

    #[test]
    fn found_before_pivot() {
        assert_eq!(search(&[4, 5, 6, 7, 0, 1, 2], 5), Some(1));
    }

    #[test]
    fn missing() {
        assert_eq!(search(&[4, 5, 6, 7, 0, 1, 2], 3), None);
    }

    #[test]
    fn not_rotated() {
        assert_eq!(search(&[1, 2, 3, 4, 5], 4), Some(3));
    }

    #[test]
    fn pivot_at_end() {
        assert_eq!(search(&[2, 3, 4, 5, 1], 1), Some(4));
    }

    #[test]
    fn pivot_at_start() {
        assert_eq!(search(&[5, 1, 2, 3, 4], 5), Some(0));
    }

    #[test]
    fn empty() {
        assert_eq!(search(&[], 1), None);
    }

    #[test]
    fn single_hit() {
        assert_eq!(search(&[1], 1), Some(0));
    }

    #[test]
    fn single_miss() {
        assert_eq!(search(&[1], 0), None);
    }

    #[test]
    fn two_elements_rotated() {
        assert_eq!(search(&[3, 1], 1), Some(1));
    }
}
