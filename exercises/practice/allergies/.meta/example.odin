package allergies

Allergen :: enum uint {
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
	return (score >> allergen) & 1 == 1
}

list :: proc(score: int) -> []Allergen {
	allergens := make([dynamic]Allergen)
	for allergen in Allergen {
		if allergic_to(score, allergen) {
			append(&allergens, allergen)
		}
	}
	return allergens[:]
}
