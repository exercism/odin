package leap

Error :: enum {
	None = 0,
	NotImplemented
}

is_leap_year :: proc(year: int) -> (bool, Error) {
	return year % 400 == 0 || year % 4 == 0 && year % 100 != 0, .None
}
