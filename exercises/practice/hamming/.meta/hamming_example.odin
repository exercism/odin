package hamming

Error :: enum {
	None,
	UnequalLengths,
}

distance :: proc(strand1, strand2: string) -> (int, Error) {
	if len(strand1) != len(strand2) do return 0, .UnequalLengths
	diff_count := 0
	for i := 0; i < len(strand1); i += 1 {
		if strand1[i] != strand2[i] do diff_count += 1
	}
	return diff_count, .None
}
