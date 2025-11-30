package pythagorean_triplet

Triplet :: struct {
	a, b, c: int,
}

triplets_with_sum :: proc(n: int) -> []Triplet {
	amax := n / 3
	triplets: [dynamic]Triplet
	for a in 1 ..= amax {
		bmax := a + (n - a) / 2
		for b in a + 1 ..= bmax {
			c := n - a - b
			if c < b {
				break
			}
			if a * a + b * b == c * c {
				append(&triplets, Triplet{a, b, c})
			}
		}
	}
	return triplets[:]
}
