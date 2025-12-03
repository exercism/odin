package allergies

Allergen :: enum {
	Eggs,
	Peanuts,
	Shellfish,
	Strawberries,
	Tomatoes,
	Chocolate,
	Pollen,
	Cats,
}

allergic_to :: proc(score: int, allergen: Allergen) -> bool {
	// Implement this procedure.
	return false
}

list :: proc(score: int) -> []Allergen {
	// Implement this procedure.
	return nil
}
