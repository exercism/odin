package gigasecond

import "core:time/datetime"

Gigasecond :: datetime.Delta {
	seconds = 1e9,
}

add_gigasecond :: proc(moment: datetime.DateTime) -> datetime.DateTime {
	future, _ := datetime.add(moment, Gigasecond)
	return future
}
