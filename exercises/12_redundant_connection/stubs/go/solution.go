// EXERCISE — Redundant Connection (Go)
//
// A tree with n nodes labeled 1..n had ONE extra undirected edge added, so
// edges has n edges and exactly one cycle. Return the edge that can be
// removed to leave a tree again. If several edges would work, return the
// one that appears LAST in edges.
//
//   FindRedundantConnection([][]int{{1, 2}, {1, 3}, {2, 3}})  ->  []int{2, 3}
//
// Approach: union-find (disjoint set union). Walk the edges in order; for
// each [u, v], if find(u) == find(v) they're already connected, so this
// edge closes the cycle — return it. Otherwise union(u, v).

package redundantconnection

func FindRedundantConnection(edges [][]int) []int {
	panic("implement FindRedundantConnection")
}
