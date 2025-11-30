package word_count

import "core:strings"

count_word :: proc(input: string) -> (word_counts: map[string]u32) {
	input := input
	delims := [?]string{" ", ",", ".", "\n"}
	for str in strings.split_multi_iterate(&input, delims[:]) {
		normalized := strings.to_lower(str)
		defer delete(normalized)
		key := strings.trim(normalized, "'\"()!&@$%^:")
		if len(key) <= 0 {
			continue
		}
		if key in word_counts {
			// map already have the same key
			word_counts[key] += 1
		} else {
			// map own the key now
			word_counts[strings.clone(key)] = 1
		}
	}
	return
}
