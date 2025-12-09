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

seconds_per_earth_year :: 31_557_600

age :: proc(planet: Planet, seconds: int) -> f64 {
	return f64(seconds) / seconds_per_earth_year / period(planet)
}

period :: proc(p: Planet) -> f64 {
	period: f64
	switch p {
	case .Mercury:
		period = 0.2408467
	case .Venus:
		period = 0.61519726
	case .Earth:
		period = 1.0
	case .Mars:
		period = 1.8808158
	case .Jupiter:
		period = 11.862615
	case .Saturn:
		period = 29.447498
	case .Uranus:
		period = 84.016846
	case .Neptune:
		period = 164.79132
	}
	return period
}
