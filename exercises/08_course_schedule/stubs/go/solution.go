// EXERCISE — Course Schedule (Go)
//
// There are numCourses labeled 0..numCourses-1. prerequisites[i] = []int{a, b}
// means you must take course b before course a. Return true if you can finish
// all courses (the dependency graph has no cycle), else false.
//
// Approach: detect a cycle in a directed graph — Kahn's BFS topo-sort, or
// DFS with a three-color marking (unvisited / in-stack / done).
//
//   CanFinish(2, [][]int{{1, 0}})              ->  true
//   CanFinish(2, [][]int{{1, 0}, {0, 1}})      ->  false  (cycle)

package courseschedule

func CanFinish(numCourses int, prerequisites [][]int) bool {
	panic("implement CanFinish")
}
