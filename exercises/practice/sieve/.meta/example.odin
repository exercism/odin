package sieve

primes :: proc(limit: int) -> []int {
	if limit < 2 {
		return nil
	}

	flags := make([]bool, limit + 1)
	defer delete(flags)

	for i in 2 ..= limit {
		flags[i] = true
	}

	mark_multiples :: proc(flags: []bool, prime, step, limit: int) {
		for i := prime * prime; i <= limit; i += step {
			flags[i] = false
		}
	}

	// mark multiples of 2 as non-prime
	mark_multiples(flags, 2, 2, limit)

	for n := 3; n * n <= limit; n += 2 {
		if flags[n] {
			// n is a prime
			mark_multiples(flags, n, 2 * n, limit)
		}
	}

	primes: [dynamic]int
	defer delete(primes)

	for flag, i in flags {
		if flag {
			append(&primes, i)
		}
	}

	return primes[:]
}
