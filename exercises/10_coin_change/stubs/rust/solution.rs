// EXERCISE — Coin Change (Rust)
//
// Given a slice of coin denominations and a target `amount`, return the
// FEWEST number of coins that sum to `amount`. Each denomination can be
// used any number of times. Return -1 if the amount can't be made.
// An amount of 0 needs 0 coins.
//
//   coin_change(&[1, 2, 5], 11)  ->  3    (5 + 5 + 1)
//   coin_change(&[2], 3)         ->  -1
//
// Approach: bottom-up DP. dp[a] = fewest coins to make amount a.
// dp[0] = 0; dp[a] = 1 + min(dp[a - c]) over every coin c <= a.
// Greedy (always take the biggest coin) is NOT correct — see the tests.

pub fn coin_change(coins: &[i32], amount: i32) -> i32 {
    todo!()
}

// ─── Tests ────────────────────────────────────────────────────────────────────
// Do not edit below this line.

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn classic() {
        assert_eq!(coin_change(&[1, 2, 5], 11), 3);
    }

    #[test]
    fn impossible() {
        assert_eq!(coin_change(&[2], 3), -1);
    }

    #[test]
    fn zero_amount() {
        assert_eq!(coin_change(&[1], 0), 0);
    }

    #[test]
    fn single_coin_exact() {
        assert_eq!(coin_change(&[7], 21), 3);
    }

    #[test]
    fn greedy_fails() {
        // greedy takes 4+1+1 (3 coins); optimal is 3+3 (2 coins)
        assert_eq!(coin_change(&[1, 3, 4], 6), 2);
    }

    #[test]
    fn unsorted_coins() {
        assert_eq!(coin_change(&[5, 1, 2], 7), 2);
    }

    #[test]
    fn no_ones_reachable() {
        assert_eq!(coin_change(&[3, 7], 13), 3);
    }

    #[test]
    fn no_ones_unreachable() {
        assert_eq!(coin_change(&[3, 7], 11), -1);
    }

    #[test]
    fn larger_amount() {
        assert_eq!(coin_change(&[186, 419, 83, 408], 6249), 20);
    }
}
