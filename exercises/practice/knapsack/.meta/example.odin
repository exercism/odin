package knapsack

Item :: struct {
	weight: u32,
	value:  u32,
}

maximum_value :: proc(maximum_weight: u32, items: []Item) -> u32 {
	f := make([]u32, maximum_weight + 1)
	defer delete(f)
	for item in items {
		for i := maximum_weight; i >= item.weight; i -= 1 {
			skip := f[i]
			carry := f[i - item.weight] + item.value
			f[i] = max(skip, carry)
		}
	}
	return f[maximum_weight]
}
