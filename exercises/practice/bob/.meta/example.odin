package bob

import "core:strings"

response :: proc(input: string) -> string {
	trimmed := strings.trim_right_space(input)

	is_silence := len(trimmed) == 0
	is_asking := strings.has_suffix(trimmed, "?")
	is_yelling :=
		strings.contains_any(trimmed, "ABCDEFGHIJKLMNOPQRSTUVWXYZ") &&
		!strings.contains_any(trimmed, "abcdefghijklmnopqrstuvwxyz")

	if is_silence {
		return "Fine. Be that way!"
	}
	if is_asking && is_yelling {
		return "Calm down, I know what I'm doing!"
	}
	if is_asking {
		return "Sure."
	}
	if is_yelling {
		return "Whoa, chill out!"
	}
	return "Whatever."
}
