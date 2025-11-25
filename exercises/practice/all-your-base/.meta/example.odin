package all_your_base

Error :: enum {
	None,
	Invalid_Input_Digit,
	Input_Base_Too_Small,
	Output_Base_Too_Small,
	Unimplemented,
}

rebase :: proc(input_base: int, digits: []int, output_base: int) -> ([]int, Error) {
	if input_base < 2 { return nil, .Input_Base_Too_Small }
	if output_base < 2 { return nil, .Output_Base_Too_Small }

	decimal := 0
	for digit in digits {
		if digit < 0 || digit >= input_base {
			return nil, .Invalid_Input_Digit
		}
		decimal = decimal * input_base + digit
	}

	output_digits: [dynamic]int

	if decimal == 0 {
		append(&output_digits, 0)
	} else {
		for decimal > 0 {
			inject_at(&output_digits, 0, decimal % output_base)
			decimal /= output_base
		}
	}

	return output_digits[:], .None
}
