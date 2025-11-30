package dominoes

import "core:slice"
import "core:testing"

array_equal :: proc(a, b: []$T) -> bool {
	if len(a) != len(b) {
		return false
	}
	for i in 0 ..< len(a) {
		if a[i] != b[i] {
			return false
		}
	}
	return true
}

can_build_chain :: proc(a, b: []Domino) -> bool {
	normalize :: proc(a: []Domino) {
		for &d in a {
			if d.first > d.second {
				tmp := d.first
				d.first = d.second
				d.second = tmp
			}
		}
	}
	cmp :: proc(a, b: Domino) -> bool {
		if a.first == b.first {
			return a.second < b.second
		}
		return a.first < b.first
	}
	normalize(a)
	normalize(b)
	slice.sort_by(a, cmp)
	slice.sort_by(b, cmp)
	return array_equal(a, b)
}

is_valid :: proc(chain: []Domino) -> bool {
	n := len(chain)
	for i in 0 ..< n {
		j := (i + 1) % n
		if chain[i].second != chain[j].first {
			return false
		}
	}
	return true
}

@(test)
test_empty_input :: proc(t: ^testing.T) {
	dominoes := []Domino{}
	result, ok := chain(dominoes)
	defer delete(result)
	testing.expect(t, ok)
	testing.expectf(t, is_valid(result), "not a valid domino chain %v", result)
	testing.expectf(
		t,
		can_build_chain(dominoes, result),
		"can't build %v from %v",
		result,
		dominoes,
	)
}

@(test)
test_singleton_input :: proc(t: ^testing.T) {
	dominoes := []Domino{{1, 1}}
	result, ok := chain(dominoes)
	defer delete(result)
	testing.expect(t, ok)
	testing.expectf(t, is_valid(result), "not a valid domino chain %v", result)
	testing.expectf(
		t,
		can_build_chain(dominoes, result),
		"can't build %v from %v",
		result,
		dominoes,
	)
}

@(test)
test_singleton_that_cant_be_chained :: proc(t: ^testing.T) {
	dominoes := []Domino{{1, 2}}
	result, ok := chain(dominoes)
	defer delete(result)
	testing.expect(t, !ok)
}

@(test)
test_three_elements :: proc(t: ^testing.T) {
	dominoes := []Domino{{1, 2}, {3, 1}, {2, 3}}
	result, ok := chain(dominoes)
	defer delete(result)
	testing.expect(t, ok)
	testing.expectf(t, is_valid(result), "not a valid domino chain %v", result)
	testing.expectf(
		t,
		can_build_chain(dominoes, result),
		"can't build %v from %v",
		result,
		dominoes,
	)
}

@(test)
test_can_reverse_dominoes :: proc(t: ^testing.T) {
	dominoes := []Domino{{1, 2}, {1, 3}, {2, 3}}
	result, ok := chain(dominoes)
	defer delete(result)
	testing.expect(t, ok)
	testing.expectf(t, is_valid(result), "not a valid domino chain %v", result)
	testing.expectf(
		t,
		can_build_chain(dominoes, result),
		"can't build %v from %v",
		result,
		dominoes,
	)
}

@(test)
test_cant_be_chained :: proc(t: ^testing.T) {
	dominoes := []Domino{{1, 2}, {4, 1}, {2, 3}}
	result, ok := chain(dominoes)
	defer delete(result)
	testing.expect(t, !ok)
}

@(test)
test_disconnected_simple :: proc(t: ^testing.T) {
	dominoes := []Domino{{1, 1}, {2, 2}}
	result, ok := chain(dominoes)
	defer delete(result)
	testing.expect(t, !ok)
}

@(test)
test_disconnected_double_loop :: proc(t: ^testing.T) {
	dominoes := []Domino{{1, 2}, {2, 1}, {3, 4}, {4, 3}}
	result, ok := chain(dominoes)
	defer delete(result)
	testing.expect(t, !ok)
}

@(test)
test_disconnected_single_isolated :: proc(t: ^testing.T) {
	dominoes := []Domino{{1, 2}, {2, 3}, {3, 1}, {4, 4}}
	result, ok := chain(dominoes)
	defer delete(result)
	testing.expect(t, !ok)
}

@(test)
test_need_backtrack :: proc(t: ^testing.T) {
	dominoes := []Domino{{1, 2}, {2, 3}, {3, 1}, {2, 4}, {2, 4}}
	result, ok := chain(dominoes)
	defer delete(result)
	testing.expect(t, ok)
	testing.expectf(t, is_valid(result), "not a valid domino chain %v", result)
	testing.expectf(
		t,
		can_build_chain(dominoes, result),
		"can't build %v from %v",
		result,
		dominoes,
	)
}

@(test)
test_separate_loops :: proc(t: ^testing.T) {
	dominoes := []Domino{{1, 2}, {2, 3}, {3, 1}, {1, 1}, {2, 2}, {3, 3}}
	result, ok := chain(dominoes)
	defer delete(result)
	testing.expect(t, ok)
	testing.expectf(t, is_valid(result), "not a valid domino chain %v", result)
	testing.expectf(
		t,
		can_build_chain(dominoes, result),
		"can't build %v from %v",
		result,
		dominoes,
	)
}

@(test)
test_nine_elements :: proc(t: ^testing.T) {
	dominoes := []Domino{{1, 2}, {5, 3}, {3, 1}, {1, 2}, {2, 4}, {1, 6}, {2, 3}, {3, 4}, {5, 6}}
	result, ok := chain(dominoes)
	defer delete(result)
	testing.expect(t, ok)
	testing.expectf(t, is_valid(result), "not a valid domino chain %v", result)
	testing.expectf(
		t,
		can_build_chain(dominoes, result),
		"can't build %v from %v",
		result,
		dominoes,
	)
}

@(test)
test_separate_three_domino_loops :: proc(t: ^testing.T) {
	dominoes := []Domino{{1, 2}, {2, 3}, {3, 1}, {4, 5}, {5, 6}, {6, 4}}
	result, ok := chain(dominoes)
	defer delete(result)
	testing.expect(t, !ok)
}
