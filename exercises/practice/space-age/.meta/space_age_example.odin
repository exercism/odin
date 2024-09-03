package space_age

Planet :: enum {
	Mercury,
	Venus,
	Earth,
	Mars,
	Jupiter,
	Saturn,
	Uranus,
	Neptune,
}

period := map[Planet]f64 {
	.Mercury = 0.2408467,
	.Venus   = 0.61519726,
	.Earth   = 1.0,
	.Mars    = 1.8808158,
	.Jupiter = 11.862615,
	.Saturn  = 29.447498,
	.Uranus  = 84.016846,
	.Neptune = 164.79132,
}

seconds_per_earth_year :: 31_557_600

age :: proc(planet: Planet, seconds: int) -> f64 {
	return f64(seconds) / seconds_per_earth_year / period[planet]
}
