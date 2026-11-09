// EXERCISE — Network Delay Time (Go)
//
// There are n nodes labeled 1..n. times[i] = []int{u, v, w} is a DIRECTED
// edge: a signal sent from u reaches v after w time units (w >= 0). A
// signal is sent from node k. Return how long it takes for ALL n nodes to
// receive it, or -1 if some node is unreachable.
//
//   NetworkDelayTime([][]int{{2, 1, 1}, {2, 3, 1}, {3, 4, 1}}, 4, 2)  ->  2
//   NetworkDelayTime([][]int{{1, 2, 1}}, 2, 2)                        ->  -1
//
// Approach: Dijkstra's shortest paths from k. The answer is the LARGEST of
// the shortest distances — the last node to hear the signal. For a heap,
// implement container/heap's Interface on a slice of (dist, node) pairs —
// or, since n is small, scan for the closest unsettled node each round
// (O(n²) Dijkstra).

package networkdelay

func NetworkDelayTime(times [][]int, n int, k int) int {
	panic("implement NetworkDelayTime")
}
