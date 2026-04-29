// EXERCISE — Binary Search (Rust)
//
// Implement `binary_search` on a sorted slice.
// Return `Some(index)` if found, `None` if not.
//
//   binary_search(&[1, 3, 5, 7, 9], 5)  ->  Some(2)
//   binary_search(&[1, 3, 5, 7, 9], 4)  ->  None

pub fn binary_search(arr: &[i32], target: i32) -> Option<usize> {
    todo!()
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn found_middle() {
        assert_eq!(binary_search(&[1, 3, 5, 7, 9], 5), Some(2));
    }

    #[test]
    fn found_first() {
        assert_eq!(binary_search(&[1, 3, 5, 7, 9], 1), Some(0));
    }

    #[test]
    fn found_last() {
        assert_eq!(binary_search(&[1, 3, 5, 7, 9], 9), Some(4));
    }

    #[test]
    fn missing() {
        assert_eq!(binary_search(&[1, 3, 5, 7, 9], 4), None);
    }

    #[test]
    fn empty() {
        assert_eq!(binary_search(&[], 1), None);
    }

    #[test]
    fn single_hit() {
        assert_eq!(binary_search(&[42], 42), Some(0));
    }

    #[test]
    fn single_miss() {
        assert_eq!(binary_search(&[42], 7), None);
    }
}
