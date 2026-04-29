// EXERCISE — Maximum Subarray (Rust)
//
// Given a non-empty slice of integers (may include negatives), return the
// largest sum of any contiguous subarray. Must run in O(n) — Kadane's
// algorithm. The tests include a large input where O(n²) would hang.
//
//   max_subarray(&[-2, 1, -3, 4, -1, 2, 1, -5, 4])  ->  6   ([4, -1, 2, 1])
//   max_subarray(&[-3, -1, -2])                     -> -1   (all negative)

pub fn max_subarray(nums: &[i32]) -> i32 {
    todo!()
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn classic() {
        assert_eq!(max_subarray(&[-2, 1, -3, 4, -1, 2, 1, -5, 4]), 6);
    }

    #[test]
    fn single() {
        assert_eq!(max_subarray(&[5]), 5);
    }

    #[test]
    fn all_positive() {
        assert_eq!(max_subarray(&[1, 2, 3, 4]), 10);
    }

    #[test]
    fn all_negative() {
        assert_eq!(max_subarray(&[-3, -1, -2]), -1);
    }

    #[test]
    fn mixed() {
        assert_eq!(max_subarray(&[5, 4, -1, 7, 8]), 23);
    }

    #[test]
    fn two() {
        assert_eq!(max_subarray(&[-2, -1]), -1);
    }
}
