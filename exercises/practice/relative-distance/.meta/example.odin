package relative_distance

import "core:container/queue"

Name :: string
Children :: []Name
FamilyTree :: map[Name]Children

Node :: struct {
	name:     string,
	distance: int,
}

Set :: map[string]bool

Neighbors :: map[string]Set

// First establish 1-degree separation between members of the family (Neighbors graph)
// - parent to child
// - child to parent
// - child to other child
// Then use BFS (Breath-First-Search) to find a path between the `from` and `to` individuals.
// Because we use BFS, the path found will be the shortest path. This only works because all the
// weigths in the Neighbors graph are 1.
degree_of_separation :: proc(family: FamilyTree, from: string, to: string) -> int {

	if from == to { return 0 }

	neighbors := collect_neighbors(family)
	defer destroy_neighbors(neighbors)

	visited: Set
	visited[from] = true
	defer delete(visited)

	to_visit: queue.Queue(Node)
	queue.init(&to_visit)
	defer queue.destroy(&to_visit)
	queue.push_back(&to_visit, Node{from, 0})

	for queue.len(to_visit) > 0 {
		node := queue.pop_front(&to_visit)
		for neighbor in neighbors[node.name] {
			if neighbor == to {
				return node.distance + 1
			}
			if !visited[neighbor] {
				visited[neighbor] = true
				queue.push(&to_visit, Node{neighbor, node.distance + 1})
			}
		}
	}
	// No path found
	return -1
}

collect_neighbors :: proc(family: FamilyTree) -> Neighbors {

	neighbors: Neighbors
	for parent, children in family {
		for child in children {
			add_neighbor(&neighbors, parent, child)
			add_neighbor(&neighbors, child, parent)
			for other_child in children {
				if other_child != child {
					add_neighbor(&neighbors, child, other_child)
				}
			}
		}
	}
	return neighbors
}

add_neighbor :: proc(neighbors: ^Neighbors, name: string, neighbor: string) {

	if name not_in neighbors {
		neighbors[name] = make(Set)
	}
	set := neighbors[name]
	set[neighbor] = true
	neighbors[name] = set

}

destroy_neighbors :: proc(neighbors: Neighbors) {

	for key, _ in neighbors {
		set := neighbors[key]
		delete(set)
	}
	delete(neighbors)
}
