package book_store

import "core:slice"

calculate :: proc(counts: [5]u32) -> u32 {
	ret: f32 = 0.0
	used: u32 = 0
	base_price: f32 = 800.0
	n := len(counts)
	for i in 0 ..< n {
		m := n - i
		x := counts[i] - used
		used = counts[i]
		price := base_price * f32(m) * f32(x)
		discount: f32
		switch m {
		case 2:
			discount = 0.95
		case 3:
			discount = 0.90
		case 4:
			discount = 0.80
		case 5:
			discount = 0.75
		case:
			discount = 1.0
		}
		ret += price * discount
	}
	return u32(ret)
}

total :: proc(basket: []u32) -> u32 {
	counts: [5]u32
	for book in basket do counts[book - 1] += 1
	slice.sort(counts[:])
	delta := min(counts[0], counts[2] - counts[1])
	counts[0] -= delta
	counts[1] += delta
	return calculate(counts)
}
