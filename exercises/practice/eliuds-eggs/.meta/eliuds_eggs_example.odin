package eliuds_eggs

egg_count :: proc(number: uint) -> uint {
	count: uint = 0
	n := number
	for n > 0 {
		if n % 2 == 1 do count += 1
		n /= 2
	}
	return count
}
