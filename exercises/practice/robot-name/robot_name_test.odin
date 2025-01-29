package robotname

import "core:fmt"
import "core:strings"
import "core:testing"
import "core:text/regex"

name_valid :: proc(name: string) -> bool {
	pat, err := regex.create(`^[A-Z]{2}\d{3}$`)
	defer regex.destroy(pat)
	if err != regex.Creation_Error.None {
		return false
	}
	captures, matched := regex.match(pat, name)
	defer regex.destroy(captures)
	return matched
}

@(test)
test_name_valid :: proc(t: ^testing.T) {
	storage := make_storage()
	defer delete_storage(&storage)
	r, e := new_robot(&storage)
	testing.expect(t, e == nil)
	testing.expect(t, name_valid(r.name))
}

@(test)
test_successive_robots_have_different_names :: proc(t: ^testing.T) {
	storage := make_storage()
	defer delete_storage(&storage)
	n1, e1 := new_robot(&storage)
	n2, e2 := new_robot(&storage)
	testing.expect(t, e1 == nil)
	testing.expect(t, e2 == nil)
	testing.expect(t, n1 != n2)
}

@(test)
test_reset_name :: proc(t: ^testing.T) {
	storage := make_storage()
	defer delete_storage(&storage)
	r, e := new_robot(&storage)
	n1 := r.name
	reset(&storage, &r)
	n2 := r.name
	testing.expect(t, e == nil)
	testing.expect(t, n1 != n2)
}

@(test)
test_multiple_names :: proc(t: ^testing.T) {
	n := 100
	storage := make_storage()
	defer delete_storage(&storage)
	seen := make(map[string]bool)
	defer delete(seen)
	for i := 0; i <= n; i += 1 {
		r, e := new_robot(&storage)
		testing.expect(t, e == nil)
		testing.expect(t, !seen[r.name])
		seen[r.name] = true
	}
}

dfs_fill_names :: proc(storage: ^RobotStorage) {
	GO_BACK_SENTINEL := u8('-')
	NAME_LENGTH := 5
	LETTERS := "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	NUMBERS := "0123456789"
	stack := make([dynamic]u8)
	defer delete(stack)
	current := make([]u8, NAME_LENGTH)
	defer delete(current)
	for i in 0 ..< len(LETTERS) {
		append(&stack, LETTERS[i])
	}
	depth := 0
	for len(stack) > 0 {
		ch := pop(&stack)
		go_back := ch == GO_BACK_SENTINEL
		if go_back {
			depth -= 1
			continue
		}
		current[depth] = ch
		depth += 1
		if depth == NAME_LENGTH {
			key := string(current)
			storage.names[key] = true
			n := len(storage.names)
			if n % 8673 == 0 {
				fmt.printfln("[%d] '%s',", n, key)
			}
			depth -= 1
			continue
		}
		append(&stack, GO_BACK_SENTINEL)
		if depth < 2 {
			for i in 0 ..< len(LETTERS) {
				append(&stack, LETTERS[i])
			}
		} else {
			for i in 0 ..< len(NUMBERS) {
				append(&stack, NUMBERS[i])
			}
		}
	}
}

@(test)
test_collisions :: proc(t: ^testing.T) {
	storage := make_storage()
	defer delete_storage(&storage)
	dfs_fill_names(&storage)
	r, e := new_robot(&storage)
	testing.expect_value(t, e, Error.CouldNotCreateName)
}
