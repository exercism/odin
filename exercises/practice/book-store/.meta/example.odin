package book_store

import "core:slice"

calculate :: proc(counts: []u32) -> u32 {
	grand_total: f32 = 0.0
	used: u32 = 0
	BASE_PRICE: f32 : 800.0
	n := len(counts)
	get_discount :: proc(book: int) -> f32 {
		switch book {
		case 2:
			return 0.95
		case 3:
			return 0.90
		case 4:
			return 0.80
		case 5:
			return 0.75
		case:
			return 1.0
		}
	}
	for i in 0 ..< n {
		m := n - i
		x := counts[i] - used
		used = counts[i]
		price := BASE_PRICE * f32(m) * f32(x)
		grand_total += price * get_discount(m)
	}
	return u32(grand_total)
}

total :: proc(basket: []u32) -> u32 {
	counts: [5]u32
	for book in basket {
		counts[book - 1] += 1
	}
	slice.sort(counts[:])
	delta := min(counts[0], counts[2] - counts[1])
	counts[0] -= delta
	counts[1] += delta
	return calculate(counts[:])
}
