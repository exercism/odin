package luhn

import "core:unicode"

valid :: proc(value: string) -> bool {
	digits := make([dynamic]int)
	defer delete(digits)

	for r in value {
		if unicode.is_space(r) {
			continue
		}
		if !unicode.is_digit(r) {
			return false
		}
		append(&digits, int(r - '0'))
	}

	if len(digits) <= 1 {
		return false
	}

	sum := 0
	digits_len := len(digits)
	for i := digits_len - 1; i >= 0; i -= 1 {
		digit := digits[i]
		if (digits_len - i) % 2 == 0 {
			digit *= 2
			if digit > 9 {
				digit -= 9
			}
		}
		sum += digit
	}

	return sum % 10 == 0
}
