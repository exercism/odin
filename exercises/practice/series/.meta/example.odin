package series

Error :: enum {
	None,
	Invalid_Series_Length_Too_Large,
	Invalid_Series_Length_Zero,
	Invalid_Series_Length_Negative,
	Invalid_Sequence_Empty,
	Unimplemented,
}
series :: proc(sequence: string, series_len: int) -> ([]string, Error) {

	if len(sequence) == 0 { return nil, .Invalid_Sequence_Empty }
	if series_len > len(sequence) { return nil, .Invalid_Series_Length_Too_Large }
	if series_len == 0 { return nil, .Invalid_Series_Length_Zero }
	if series_len < 0 { return nil, .Invalid_Series_Length_Negative }

	series: [dynamic]string
	for i := 0; i + series_len <= len(sequence); i += 1 {
		append(&series, sequence[i:i + series_len])
	}
	return series[:], .None
}
