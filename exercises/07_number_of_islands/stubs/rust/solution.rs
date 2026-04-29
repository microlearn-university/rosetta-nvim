// EXERCISE — Number of Islands (Rust)
//
// Given a 2D grid of '1' (land) and '0' (water), count the number of
// islands. An island is a group of 1s connected 4-directionally
// (up/down/left/right). Diagonals don't count.
//
//   num_islands(vec![
//       vec!['1','1','0','0','0'],
//       vec!['1','1','0','0','0'],
//       vec!['0','0','1','0','0'],
//       vec!['0','0','0','1','1'],
//   ])  ->  3
//
// Approach: scan the grid; when you hit '1', flood-fill (BFS or DFS) and
// increment the count. Mark visited cells (e.g. flip to '0') to avoid
// recounting. Take `mut` ownership if you mutate.

pub fn num_islands(grid: Vec<Vec<char>>) -> i32 {
    todo!()
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

#[cfg(test)]
mod tests {
    use super::*;

    fn grid(rows: &[&str]) -> Vec<Vec<char>> {
        rows.iter().map(|r| r.chars().collect()).collect()
    }

    #[test]
    fn empty() {
        let g: Vec<Vec<char>> = vec![];
        assert_eq!(num_islands(g), 0);
    }

    #[test]
    fn all_water() {
        assert_eq!(num_islands(grid(&["000", "000", "000"])), 0);
    }

    #[test]
    fn all_land() {
        assert_eq!(num_islands(grid(&["111", "111", "111"])), 1);
    }

    #[test]
    fn single_cell() {
        assert_eq!(num_islands(grid(&["1"])), 1);
    }

    #[test]
    fn classic() {
        assert_eq!(
            num_islands(grid(&["11000", "11000", "00100", "00011"])),
            3
        );
    }

    #[test]
    fn diagonal_not_connected() {
        assert_eq!(num_islands(grid(&["101", "010", "101"])), 5);
    }
}
