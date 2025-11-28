package diamond

import "core:strings"

A :: 'A'

rows :: proc(letter: rune) -> (diamond: string) {
	n := int(letter - A)
	size := 2 * n + 1
	lines := make([]string, size)

	for i in 0 ..= n {
		line := create_line(size, n, i)
		lines[i] = line
		lines[size - 1 - i] = line
	}

	diamond = strings.join(lines, "\n")

	for i in 0 ..= n { delete(lines[i]) }
	delete(lines)

	return
}

@(private)
create_line :: proc(size, n, i: int) -> string {
	char := rune(A + i)

	sb := strings.builder_make()
	defer strings.builder_destroy(&sb)

	for j := 1; j <= n - i; j += 1 { strings.write_rune(&sb, ' ') }

	strings.write_rune(&sb, char)

	if i > 0 {
		for j := 1; j <= 2 * i - 1; j += 1 { strings.write_rune(&sb, ' ') }
		strings.write_rune(&sb, char)
	}

	for j := 1; j <= n - i; j += 1 { strings.write_rune(&sb, ' ') }

	return strings.clone(strings.to_string(sb))
}
