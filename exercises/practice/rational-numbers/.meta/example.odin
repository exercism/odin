package rational_numbers

import "core:math"

Rational :: struct {
	numerator:   int,
	denominator: int,
}

abs :: proc(a: Rational) -> Rational {
	r := reduce(a)
	return Rational{math.abs(r.numerator), r.denominator}
}

add :: proc(a: Rational, b: Rational) -> Rational {
	den := a.denominator * b.denominator
	num := a.numerator * b.denominator + b.numerator * a.denominator
	return reduce(Rational{num, den})
}

div :: proc(a: Rational, b: Rational) -> Rational {
	return mul(a, inv(b))
}

exprational :: proc(a: Rational, power: int) -> Rational {
	if power < 0 {
		return reduce(
			Rational {
				intpow(a.denominator, -power),
				intpow(a.numerator, -power),
			},
		)
	}
	return reduce(
		Rational{intpow(a.numerator, power), intpow(a.denominator, power)},
	)
}

expreal :: proc(x: f64, a: Rational) -> f64 {
	return nthroot(math.pow(x, f64(a.numerator)), f64(a.denominator))
}

nthroot :: proc(n: f64, root: f64) -> f64 {
	return math.pow(math.E, math.ln(n) / root)
}

mul :: proc(a: Rational, b: Rational) -> Rational {
	return reduce(
		Rational{a.numerator * b.numerator, a.denominator * b.denominator},
	)
}

reduce :: proc(a: Rational) -> Rational {
	den := math.abs(a.denominator)
	num := a.numerator * (a.denominator / den)
	divisor := math.gcd(math.abs(num), den)

	return Rational{num / divisor, den / divisor}
}

sub :: proc(a: Rational, b: Rational) -> Rational {
	return add(a, neg(b))
}

neg :: proc(a: Rational) -> Rational {
	return reduce(Rational{-1 * a.numerator, a.denominator})
}

inv :: proc(a: Rational) -> Rational {
	return reduce(Rational{a.denominator, a.numerator})
}

intpow :: proc(n: int, p: int) -> int {
	result := 1
	for i := 1; i <= p; i += 1 {
		result *= n
	}
	return result
}
