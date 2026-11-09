// EXERCISE — Coin Change (Go)
//
// Given a slice of coin denominations and a target amount, return the
// FEWEST number of coins that sum to amount. Each denomination can be used
// any number of times. Return -1 if the amount can't be made. An amount of
// 0 needs 0 coins.
//
//   CoinChange([]int{1, 2, 5}, 11)  ->  3    (5 + 5 + 1)
//   CoinChange([]int{2}, 3)         ->  -1
//
// Approach: bottom-up DP. dp[a] = fewest coins to make amount a.
// dp[0] = 0; dp[a] = 1 + min(dp[a - c]) over every coin c <= a.
// Greedy (always take the biggest coin) is NOT correct — see the tests.

package coinchange

func CoinChange(coins []int, amount int) int {
	panic("implement CoinChange")
}
