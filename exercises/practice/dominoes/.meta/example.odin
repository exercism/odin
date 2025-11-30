package dominoes

Pair :: struct($A, $B: typeid) {
	first:  A,
	second: B,
}

Domino :: Pair(u8, u8)

chain :: proc(dominoes: []Domino) -> (ret: []Domino, ok: bool) {
	n := len(dominoes)
	if n == 0 {
		return nil, true
	}
	dot_map: map[u8][dynamic]int
	defer {
		for _, v in dot_map {
			delete(v)
		}
		delete(dot_map)
	}
	for d, i in dominoes {
		if d.first not_in dot_map {
			dot_map[d.first] = make([dynamic]int)
		}
		if d.second not_in dot_map {
			dot_map[d.second] = make([dynamic]int)
		}
		append(&dot_map[d.first], i)
		append(&dot_map[d.second], i)
	}
	path: [dynamic]Domino
	defer if !ok {
		delete(path)
	}
	vis := make([]bool, n)
	defer delete(vis)
	Entry :: Pair(int, Domino)
	stack := make([dynamic]Entry)
	defer delete(stack)
	append(&stack, Entry{0, dominoes[0]})
	for len(stack) > 0 {
		node := pop_safe(&stack) or_break
		i := node.first
		current := node.second
		if i < 0 {
			pop(&path)
			vis[-i] = false
			continue
		}
		if vis[i] {
			continue
		}
		vis[i] = true
		append(&path, current)
		if len(path) == n {
			// check if chain closes
			tail := path[len(path) - 1]
			head := path[0]
			if tail.second == head.first {
				return path[:], true
			}
			pop(&path)
			vis[i] = false
			continue
		}
		// push backtracking marker
		append(&stack, Entry{-i, {}})
		for j in dot_map[current.second] {
			next := dominoes[j]
			if next.first == current.second {
				append(&stack, Entry{j, next})
			} else {
				append(&stack, Entry{j, Domino{next.second, next.first}})
			}
		}
	}
	return nil, false // no valid chain
}
