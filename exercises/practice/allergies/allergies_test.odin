package allergies

import "core:fmt"
import "core:testing"

// Given an allergy score, determine if the person is allergic to a given allergen.

@(test)
test_testing_for_eggs_allergy__not_allergic_to_anything :: proc(t: ^testing.T) {
	result := allergic_to(0, Allergen.Eggs)

	testing.expect(t, !result)
}

@(test)
test_testing_for_eggs_allergy__allergic_only_to_eggs :: proc(t: ^testing.T) {
	result := allergic_to(1, Allergen.Eggs)

	testing.expect(t, result)
}

@(test)
test_testing_for_eggs_allergy__allergic_to_eggs_and_something_else :: proc(t: ^testing.T) {
	result := allergic_to(3, Allergen.Eggs)

	testing.expect(t, result)
}

@(test)
test_testing_for_eggs_allergy__allergic_to_something_but_not_eggs :: proc(t: ^testing.T) {
	result := allergic_to(2, Allergen.Eggs)

	testing.expect(t, !result)
}

@(test)
test_testing_for_eggs_allergy__allergic_to_everything :: proc(t: ^testing.T) {
	result := allergic_to(255, Allergen.Eggs)

	testing.expect(t, result)
}

@(test)
test_testing_for_peanuts_allergy__not_allergic_to_anything :: proc(t: ^testing.T) {
	result := allergic_to(0, Allergen.Peanuts)

	testing.expect(t, !result)
}

@(test)
test_testing_for_peanuts_allergy__allergic_only_to_peanuts :: proc(t: ^testing.T) {
	result := allergic_to(2, Allergen.Peanuts)

	testing.expect(t, result)
}

@(test)
test_testing_for_peanuts_allergy__allergic_to_peanuts_and_something_else :: proc(t: ^testing.T) {
	result := allergic_to(7, Allergen.Peanuts)

	testing.expect(t, result)
}

@(test)
test_testing_for_peanuts_allergy__allergic_to_something_but_not_peanuts :: proc(t: ^testing.T) {
	result := allergic_to(5, Allergen.Peanuts)

	testing.expect(t, !result)
}

@(test)
test_testing_for_peanuts_allergy__allergic_to_everything :: proc(t: ^testing.T) {
	result := allergic_to(255, Allergen.Peanuts)

	testing.expect(t, result)
}

@(test)
test_testing_for_shellfish_allergy__not_allergic_to_anything :: proc(t: ^testing.T) {
	result := allergic_to(0, Allergen.Shellfish)

	testing.expect(t, !result)
}

@(test)
test_testing_for_shellfish_allergy__allergic_only_to_shellfish :: proc(t: ^testing.T) {
	result := allergic_to(4, Allergen.Shellfish)

	testing.expect(t, result)
}

@(test)
test_testing_for_shellfish_allergy__allergic_to_shellfish_and_something_else :: proc(
	t: ^testing.T,
) {
	result := allergic_to(14, Allergen.Shellfish)

	testing.expect(t, result)
}

@(test)
test_testing_for_shellfish_allergy__allergic_to_something_but_not_shellfish :: proc(
	t: ^testing.T,
) {
	result := allergic_to(10, Allergen.Shellfish)

	testing.expect(t, !result)
}

@(test)
test_testing_for_shellfish_allergy__allergic_to_everything :: proc(t: ^testing.T) {
	result := allergic_to(255, Allergen.Shellfish)

	testing.expect(t, result)
}

@(test)
test_testing_for_strawberries_allergy__not_allergic_to_anything :: proc(t: ^testing.T) {
	result := allergic_to(0, Allergen.Strawberries)

	testing.expect(t, !result)
}

@(test)
test_testing_for_strawberries_allergy__allergic_only_to_strawberries :: proc(t: ^testing.T) {
	result := allergic_to(8, Allergen.Strawberries)

	testing.expect(t, result)
}

@(test)
test_testing_for_strawberries_allergy__allergic_to_strawberries_and_something_else :: proc(
	t: ^testing.T,
) {
	result := allergic_to(28, Allergen.Strawberries)

	testing.expect(t, result)
}

@(test)
test_testing_for_strawberries_allergy__allergic_to_something_but_not_strawberries :: proc(
	t: ^testing.T,
) {
	result := allergic_to(20, Allergen.Strawberries)

	testing.expect(t, !result)
}

@(test)
test_testing_for_strawberries_allergy__allergic_to_everything :: proc(t: ^testing.T) {
	result := allergic_to(255, Allergen.Strawberries)

	testing.expect(t, result)
}

@(test)
test_testing_for_tomatoes_allergy__not_allergic_to_anything :: proc(t: ^testing.T) {
	result := allergic_to(0, Allergen.Tomatoes)

	testing.expect(t, !result)
}

@(test)
test_testing_for_tomatoes_allergy__allergic_only_to_tomatoes :: proc(t: ^testing.T) {
	result := allergic_to(16, Allergen.Tomatoes)

	testing.expect(t, result)
}

@(test)
test_testing_for_tomatoes_allergy__allergic_to_tomatoes_and_something_else :: proc(t: ^testing.T) {
	result := allergic_to(56, Allergen.Tomatoes)

	testing.expect(t, result)
}

@(test)
test_testing_for_tomatoes_allergy__allergic_to_something_but_not_tomatoes :: proc(t: ^testing.T) {
	result := allergic_to(40, Allergen.Tomatoes)

	testing.expect(t, !result)
}

@(test)
test_testing_for_tomatoes_allergy__allergic_to_everything :: proc(t: ^testing.T) {
	result := allergic_to(255, Allergen.Tomatoes)

	testing.expect(t, result)
}

@(test)
test_testing_for_chocolate_allergy__not_allergic_to_anything :: proc(t: ^testing.T) {
	result := allergic_to(0, Allergen.Chocolate)

	testing.expect(t, !result)
}

@(test)
test_testing_for_chocolate_allergy__allergic_only_to_chocolate :: proc(t: ^testing.T) {
	result := allergic_to(32, Allergen.Chocolate)

	testing.expect(t, result)
}

@(test)
test_testing_for_chocolate_allergy__allergic_to_chocolate_and_something_else :: proc(
	t: ^testing.T,
) {
	result := allergic_to(112, Allergen.Chocolate)

	testing.expect(t, result)
}

@(test)
test_testing_for_chocolate_allergy__allergic_to_something_but_not_chocolate :: proc(
	t: ^testing.T,
) {
	result := allergic_to(80, Allergen.Chocolate)

	testing.expect(t, !result)
}

@(test)
test_testing_for_chocolate_allergy__allergic_to_everything :: proc(t: ^testing.T) {
	result := allergic_to(255, Allergen.Chocolate)

	testing.expect(t, result)
}

@(test)
test_testing_for_pollen_allergy__not_allergic_to_anything :: proc(t: ^testing.T) {
	result := allergic_to(0, Allergen.Pollen)

	testing.expect(t, !result)
}

@(test)
test_testing_for_pollen_allergy__allergic_only_to_pollen :: proc(t: ^testing.T) {
	result := allergic_to(64, Allergen.Pollen)

	testing.expect(t, result)
}

@(test)
test_testing_for_pollen_allergy__allergic_to_pollen_and_something_else :: proc(t: ^testing.T) {
	result := allergic_to(224, Allergen.Pollen)

	testing.expect(t, result)
}

@(test)
test_testing_for_pollen_allergy__allergic_to_something_but_not_pollen :: proc(t: ^testing.T) {
	result := allergic_to(160, Allergen.Pollen)

	testing.expect(t, !result)
}

@(test)
test_testing_for_pollen_allergy__allergic_to_everything :: proc(t: ^testing.T) {
	result := allergic_to(255, Allergen.Pollen)

	testing.expect(t, result)
}

@(test)
test_testing_for_cats_allergy__not_allergic_to_anything :: proc(t: ^testing.T) {
	result := allergic_to(0, Allergen.Cats)

	testing.expect(t, !result)
}

@(test)
test_testing_for_cats_allergy__allergic_only_to_cats :: proc(t: ^testing.T) {
	result := allergic_to(128, Allergen.Cats)

	testing.expect(t, result)
}

@(test)
test_testing_for_cats_allergy__allergic_to_cats_and_something_else :: proc(t: ^testing.T) {
	result := allergic_to(192, Allergen.Cats)

	testing.expect(t, result)
}

@(test)
test_testing_for_cats_allergy__allergic_to_something_but_not_cats :: proc(t: ^testing.T) {
	result := allergic_to(64, Allergen.Cats)

	testing.expect(t, !result)
}

@(test)
test_testing_for_cats_allergy__allergic_to_everything :: proc(t: ^testing.T) {
	result := allergic_to(255, Allergen.Cats)

	testing.expect(t, result)
}

// Given an allergy score, determine the list of allergens.

expect_slices_match :: proc(t: ^testing.T, actual, expected: []$E, loc := #caller_location) {
	result := fmt.aprintf("%v", actual)
	exp_str := fmt.aprintf("%v", expected)
	defer {
		delete(result)
		delete(exp_str)
	}

	testing.expect_value(t, result, exp_str)
}

@(test)
test_list_when__no_allergies :: proc(t: ^testing.T) {
	result := list(0)
	defer delete(result)
	expected := []Allergen{}

	expect_slices_match(t, result, expected)
}

@(test)
test_list_when__just_eggs :: proc(t: ^testing.T) {
	result := list(1)
	defer delete(result)
	expected := []Allergen{.Eggs}

	expect_slices_match(t, result, expected)
}

@(test)
test_list_when__just_peanuts :: proc(t: ^testing.T) {
	result := list(2)
	defer delete(result)
	expected := []Allergen{.Peanuts}

	expect_slices_match(t, result, expected)
}

@(test)
test_list_when__just_strawberries :: proc(t: ^testing.T) {
	result := list(8)
	defer delete(result)
	expected := []Allergen{.Strawberries}

	expect_slices_match(t, result, expected)
}

@(test)
test_list_when__eggs_and_peanuts :: proc(t: ^testing.T) {
	result := list(3)
	defer delete(result)
	expected := []Allergen{.Eggs, .Peanuts}

	expect_slices_match(t, result, expected)
}

@(test)
test_list_when__more_than_eggs_but_not_peanuts :: proc(t: ^testing.T) {
	result := list(5)
	defer delete(result)
	expected := []Allergen{.Eggs, .Shellfish}

	expect_slices_match(t, result, expected)
}

@(test)
test_list_when__lots_of_stuff :: proc(t: ^testing.T) {
	result := list(248)
	defer delete(result)
	expected := []Allergen{.Strawberries, .Tomatoes, .Chocolate, .Pollen, .Cats}

	expect_slices_match(t, result, expected)
}

@(test)
test_list_when__everything :: proc(t: ^testing.T) {
	result := list(255)
	defer delete(result)
	expected := []Allergen {
		.Eggs,
		.Peanuts,
		.Shellfish,
		.Strawberries,
		.Tomatoes,
		.Chocolate,
		.Pollen,
		.Cats,
	}

	expect_slices_match(t, result, expected)
}

@(test)
test_list_when__no_allergen_score_parts :: proc(t: ^testing.T) {
	result := list(509)
	defer delete(result)
	expected := []Allergen{.Eggs, .Shellfish, .Strawberries, .Tomatoes, .Chocolate, .Pollen, .Cats}

	expect_slices_match(t, result, expected)
}

@(test)
test_list_when__no_allergen_score_parts_without_highest_valid_score :: proc(t: ^testing.T) {
	result := list(257)
	defer delete(result)
	expected := []Allergen{.Eggs}

	expect_slices_match(t, result, expected)
}
