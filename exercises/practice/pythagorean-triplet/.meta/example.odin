package pythagorean_triplet

Triplet :: struct {
	a, b, c: int,
}

// O(n^2) - brute force search
triplets_with_sum_slow :: proc(n: int) -> []Triplet {
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

// O(n) - algebra
// a^2 + b^2 = (n - a - b)^2
// b = n*(n-2a)/(n-a)/2
triplets_with_sum :: proc(n: int) -> []Triplet {
	amax := n / 3
	triplets: [dynamic]Triplet
	for a in 1 ..= amax {
		b := n * (n - 2 * a) / (n - a) / 2
		c := n - a - b
		if a < b && b < c && a * a + b * b == c * c {
			append(&triplets, Triplet{a, b, c})
		}
	}
	return triplets[:]
}
