// EXERCISE — Two Sum (Rust)
//
// Given a slice of integers and a target, return the indices (i, j) of the
// two distinct elements that sum to target. Exactly one solution exists.
// Return the pair with i < j.
//
//   two_sum(&[2, 7, 11, 15], 9)  ->  (0, 1)
//   two_sum(&[3, 2, 4], 6)       ->  (1, 2)

pub fn two_sum(nums: &[i32], target: i32) -> (usize, usize) {
    todo!()
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn basic() {
        assert_eq!(two_sum(&[2, 7, 11, 15], 9), (0, 1));
    }

    #[test]
    fn middle() {
        assert_eq!(two_sum(&[3, 2, 4], 6), (1, 2));
    }

    #[test]
    fn duplicates() {
        assert_eq!(two_sum(&[3, 3], 6), (0, 1));
    }

    #[test]
    fn negatives() {
        assert_eq!(two_sum(&[-3, 4, 3, 90], 0), (0, 2));
    }

    #[test]
    fn last_two() {
        assert_eq!(two_sum(&[1, 5, 8, 13, 21], 34), (3, 4));
    }
}
