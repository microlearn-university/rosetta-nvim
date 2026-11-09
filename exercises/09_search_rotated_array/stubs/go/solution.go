// EXERCISE — Search in Rotated Sorted Array (Go)
//
// nums is a sorted slice of DISTINCT integers that has been rotated at some
// unknown pivot (e.g. [0,1,2,4,5,6,7] -> [4,5,6,7,0,1,2]). Return the index
// of target, or -1 if it isn't present. Must run in O(log n).
//
//   Search([]int{4, 5, 6, 7, 0, 1, 2}, 0)  ->  4
//   Search([]int{4, 5, 6, 7, 0, 1, 2}, 3)  ->  -1
//
// Approach: modified binary search. At every mid, at least one half
// (lo..mid or mid..hi) is in sorted order — check whether target falls
// inside that half's range, and discard the other half if so.

package searchrotated

func Search(nums []int, target int) int {
	panic("implement Search")
}
