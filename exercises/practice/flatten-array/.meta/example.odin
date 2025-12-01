package flatten_array

Item :: union {
	i32,
	[]Item,
}

flatten :: proc(input: Item) -> []i32 {
	final := make([dynamic]i32)
	stack := make([dynamic]Item)
	defer delete(stack)
	append(&stack, input)
	for len(stack) > 0 {
		item := pop(&stack)
		switch v in item {
		case i32:
			append(&final, v)
		case []Item:
			#reverse for child in v {
				append(&stack, child)
			}
		}
	}
	return final[:]
}
