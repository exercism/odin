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
	// Implement this procedure.
	return nil, .Unimplemented
}
