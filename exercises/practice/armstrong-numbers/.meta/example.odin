package armstrong_numbers

to_digits :: proc(n: u128) -> [dynamic]u8 {
	digits := make([dynamic]u8)
	for k := n; k > 0; k /= 10 {
		append(&digits, u8(k % 10))
	}
	return digits
}

fast_pow :: proc(base: u8, exp: int) -> u128 {
	if exp == 0 {
		return 1
	}
	if base < 2 {
		return u128(base)
	}
	power := u128(1)
	k := u128(base)
	n := exp
	for {
		if n % 2 == 1 {
			power *= k
		}
		n >>= 1
		if n == 0 {
			break
		}
		k *= k
	}
	return power
}

is_armstrong_number :: proc(n: u128) -> bool {
	digits := to_digits(n)
	defer delete(digits)
	exp := len(digits)
	sum: u128 = 0
	for d in digits {
		sum += fast_pow(d, exp)
	}
	return sum == n
}
