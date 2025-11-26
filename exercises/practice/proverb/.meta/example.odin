package proverb

import "core:fmt"

recite :: proc(items: []string) -> []string {
	n := len(items)
	if n == 0 {
		return nil
	}

	result := make([]string, n)

	for i := 0; i + 1 < n; i += 1 {
		result[i] = fmt.aprintf("For want of a %s the %s was lost.", items[i], items[i + 1])
	}
	result[n - 1] = fmt.aprintf("And all for the want of a %s.", items[0])

	// The string slice, as well as each string, has been allocated
	// and will need to be deleted by the caller.

	return result
}
