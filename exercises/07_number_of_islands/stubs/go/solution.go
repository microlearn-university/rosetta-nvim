// EXERCISE — Number of Islands (Go)
//
// Given a 2D grid of '1' (land) and '0' (water), count the number of
// islands. An island is a group of 1s connected 4-directionally
// (up/down/left/right). Diagonals don't count.
//
//   NumIslands([][]byte{
//       {'1','1','0','0','0'},
//       {'1','1','0','0','0'},
//       {'0','0','1','0','0'},
//       {'0','0','0','1','1'},
//   })  ->  3
//
// Approach: scan the grid; when you hit '1', flood-fill (BFS or DFS) and
// increment the count. Mark visited cells (e.g. flip to '0') to avoid
// recounting.

package numislands

func NumIslands(grid [][]byte) int {
	panic("implement NumIslands")
}
