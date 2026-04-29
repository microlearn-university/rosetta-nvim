// EXERCISE — Merge Sort (Rust)
//
// Implement `merge_sort(nums)` returning a NEW sorted Vec (ascending).
// Classic divide-and-conquer: split, recursively sort each half, merge.
// Target O(n log n) time, O(n) extra space. Don't call slice::sort.
//
//   merge_sort(&[5, 2, 4, 1, 3])  ->  vec![1, 2, 3, 4, 5]
//   merge_sort(&[])               ->  vec![]

pub fn merge_sort(nums: &[i32]) -> Vec<i32> {
    todo!()
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn empty() {
        assert_eq!(merge_sort(&[]), Vec::<i32>::new());
    }

    #[test]
    fn single() {
        assert_eq!(merge_sort(&[7]), vec![7]);
    }

    #[test]
    fn sorted() {
        assert_eq!(merge_sort(&[1, 2, 3, 4, 5]), vec![1, 2, 3, 4, 5]);
    }

    #[test]
    fn reverse() {
        assert_eq!(merge_sort(&[5, 4, 3, 2, 1]), vec![1, 2, 3, 4, 5]);
    }

    #[test]
    fn mixed() {
        assert_eq!(merge_sort(&[5, 2, 4, 1, 3]), vec![1, 2, 3, 4, 5]);
    }

    #[test]
    fn duplicates() {
        assert_eq!(merge_sort(&[3, 1, 2, 3, 1]), vec![1, 1, 2, 3, 3]);
    }

    #[test]
    fn negatives() {
        assert_eq!(merge_sort(&[-2, 5, 0, -7, 3]), vec![-7, -2, 0, 3, 5]);
    }
}
