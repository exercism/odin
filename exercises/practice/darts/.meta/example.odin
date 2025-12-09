package darts

import "core:math"

score :: proc(x, y: f64) -> int {
	r := math.sqrt_f64(x * x + y * y)
	switch {
	case r <= 1.0:
		return 10
	case r <= 5.0:
		return 5
	case r <= 10.0:
		return 1
	case:
		return 0
	}
}
