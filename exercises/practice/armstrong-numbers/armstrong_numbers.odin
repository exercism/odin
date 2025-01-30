package armstrong_numbers

to_digits :: proc(n: u128) -> [dynamic]u8 {
	ret := make([dynamic]u8)
	k := n
	for k > 0 {
		append(&ret, u8(k % 10))
		k /= 10
	}
	return ret
}

fast_pow :: proc(base: u8, exp: int) -> u128 {
	if exp == 0 {
		return 1
	}
	if base < 2 {
		return u128(base)
	}
	ret := u128(1)
	a := u128(base)
	n := exp
	for {
		if n % 2 == 1 {
			ret *= a
		}
		n >>= 1
		if n == 0 {
			break
		}
		a *= a
	}
	return ret
}

is_armstrong_number :: proc(n: u128) -> bool {
	digits := to_digits(n)
	defer delete(digits)
	power := len(digits)
	sum: u128 = 0
	for d in digits {
		sum += fast_pow(d, power)
	}
	return sum == n
}
