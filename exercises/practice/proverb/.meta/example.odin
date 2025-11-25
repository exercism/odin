package proverb

import "core:fmt"

recite :: proc(items: []string) -> []string {
	n := len(items)
	if n == 0 {
		return nil
	}

	result := make([]string, n)
	defer delete(result)

	for i := 0; i + 1 < n; i += 1 {
		result[i] = fmt.tprintf("For want of a %s the %s was lost.", items[i], items[i + 1])
	}
	result[n - 1] = fmt.tprintf("And all for the want of a %s.", items[0])

	return result
}
