package matching_brackets

is_balanced :: proc(input: string) -> bool {
	n := 0
	stack := make([]rune, len(input))
	defer delete(stack)
	for c in input {
		switch c {
		case '[', '{', '(':
			stack[n] = c
			n += 1
		case ']', '}', ')':
			if n == 0 {
				return false
			}
			n -= 1
			if (stack[n] == '[' && c != ']') ||
			   (stack[n] == '{' && c != '}') ||
			   (stack[n] == '(' && c != ')') {
				return false
			}
		case:
		}
	}
	return n == 0
}
