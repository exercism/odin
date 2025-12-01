package grade_school

import "core:slice"
import "core:testing"

grade_array_equal :: proc(a, b: []Grade) -> bool {
	if len(a) != len(b) {
		return false
	}
	for i in 0 ..< len(a) {
		if !slice.equal(a[i].students, b[i].students) {
			return false
		}
	}
	return true
}

@(test)
test_roster_is_empty_when_no_student_is_added :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	result := roster(&school)
	defer delete(result)
	expected: []Grade
	testing.expectf(t, grade_array_equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
test_add_a_student :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	testing.expect(t, add(&school, "Aimee", 2))
}

@(test)
test_student_is_added_to_the_roster :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	testing.expect(t, add(&school, "Aimee", 2))
	result := roster(&school)
	defer delete(result)
	expected := []Grade{{2, {"Aimee"}}}
	testing.expectf(t, grade_array_equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
test_adding_multiple_students_in_the_same_grade_in_the_roster :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	testing.expect(t, add(&school, "Blair", 2))
	testing.expect(t, add(&school, "James", 2))
	testing.expect(t, add(&school, "Paul", 2))
}

@(test)
test_multiple_students_in_the_same_grade_are_added_to_the_roster :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	testing.expect(t, add(&school, "Blair", 2))
	testing.expect(t, add(&school, "James", 2))
	testing.expect(t, add(&school, "Paul", 2))
	result := roster(&school)
	defer delete(result)
	expected := []Grade{{2, {"Blair", "James", "Paul"}}}
	testing.expectf(t, grade_array_equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
test_cannot_add_student_to_same_grade_in_the_roster_more_than_once :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	testing.expect(t, add(&school, "Blair", 2))
	testing.expect(t, add(&school, "James", 2))
	testing.expectf(t, !add(&school, "James", 2), "James already in grade 2")
	testing.expect(t, add(&school, "Paul", 2))
}

@(test)
test_student_not_added_to_same_grade_in_the_roster_more_than_once :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	testing.expect(t, add(&school, "Blair", 2))
	testing.expect(t, add(&school, "James", 2))
	testing.expectf(t, !add(&school, "James", 2), "James already in grade 2")
	testing.expect(t, add(&school, "Paul", 2))
	result := roster(&school)
	defer delete(result)
	expected := []Grade{{2, {"Blair", "James", "Paul"}}}
	testing.expectf(t, grade_array_equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
test_adding_students_in_multiple_grades :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	testing.expect(t, add(&school, "Chelsea", 3))
	testing.expect(t, add(&school, "Logan", 7))
}

@(test)
test_students_in_multiple_grades_are_added_to_the_roster :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	testing.expect(t, add(&school, "Chelsea", 3))
	testing.expect(t, add(&school, "Logan", 7))
	result := roster(&school)
	defer delete(result)
	expected := []Grade{{3, {"Chelsea"}}, {7, {"Logan"}}}
	testing.expectf(t, grade_array_equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
test_cannot_add_same_student_to_multiple_grades_in_the_roster :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	testing.expect(t, add(&school, "Blair", 2))
	testing.expect(t, add(&school, "James", 2))
	testing.expectf(
		t,
		!add(&school, "James", 3),
		"James should not be in grade 3, he already in grade 2",
	)
	testing.expect(t, add(&school, "Paul", 3))
}

@(test)
test_student_not_added_to_multiple_grades_in_the_roster :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	testing.expect(t, add(&school, "Blair", 2))
	testing.expect(t, add(&school, "James", 2))
	testing.expectf(
		t,
		!add(&school, "James", 3),
		"James should not be in grade 3, he already in grade 2",
	)
	testing.expect(t, add(&school, "Paul", 3))
	result := roster(&school)
	defer delete(result)
	expected := []Grade{{2, {"Blair", "James"}}, {3, {"Paul"}}}
	testing.expectf(t, grade_array_equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
test_students_are_sorted_by_grades_in_the_roster :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	testing.expect(t, add(&school, "Jim", 3))
	testing.expect(t, add(&school, "Peter", 2))
	testing.expect(t, add(&school, "Anna", 1))
	result := roster(&school)
	defer delete(result)
	expected := []Grade{{1, {"Anna"}}, {2, {"Peter"}}, {3, {"Jim"}}}
	testing.expectf(t, grade_array_equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
test_students_are_sorted_by_name_in_the_roster :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	testing.expect(t, add(&school, "Peter", 2))
	testing.expect(t, add(&school, "Zoe", 2))
	testing.expect(t, add(&school, "Alex", 2))
	result := roster(&school)
	defer delete(result)
	expected := []Grade{{2, {"Alex", "Peter", "Zoe"}}}
	testing.expectf(t, grade_array_equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
test_students_are_sorted_by_grades_and_then_by_name_in_the_roster :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	testing.expect(t, add(&school, "Peter", 2))
	testing.expect(t, add(&school, "Anna", 1))
	testing.expect(t, add(&school, "Barb", 1))
	testing.expect(t, add(&school, "Zoe", 2))
	testing.expect(t, add(&school, "Alex", 2))
	testing.expect(t, add(&school, "Jim", 3))
	testing.expect(t, add(&school, "Charlie", 1))
	result := roster(&school)
	defer delete(result)
	expected := []Grade {
		{1, {"Anna", "Barb", "Charlie"}},
		{2, {"Alex", "Peter", "Zoe"}},
		{3, {"Jim"}},
	}
	testing.expectf(t, grade_array_equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
test_grade_is_empty_if_no_students_in_the_roster :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	result := grade(&school, 1)
	expected := []string{}
	testing.expectf(t, slice.equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
test_grade_is_empty_if_no_students_in_that_grade :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	testing.expect(t, add(&school, "Peter", 2))
	testing.expect(t, add(&school, "Zoe", 2))
	testing.expect(t, add(&school, "Alex", 2))
	testing.expect(t, add(&school, "Jim", 3))
	result := grade(&school, 1)
	expected := []string{}
	testing.expectf(t, slice.equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
test_student_not_added_to_same_grade_more_than_once :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	testing.expect(t, add(&school, "Blair", 2))
	testing.expect(t, add(&school, "James", 2))
	testing.expectf(t, !add(&school, "James", 2), "James already in grade 2")
	testing.expect(t, add(&school, "Paul", 2))
	result := grade(&school, 2)
	expected := []string{"Blair", "James", "Paul"}
	testing.expectf(t, slice.equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
test_student_not_added_to_multiple_grades :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	testing.expect(t, add(&school, "Blair", 2))
	testing.expect(t, add(&school, "James", 2))
	testing.expectf(
		t,
		!add(&school, "James", 3),
		"James should not be in grade 3, he already in grade 2",
	)
	testing.expect(t, add(&school, "Paul", 3))
	result := grade(&school, 2)
	expected := []string{"Blair", "James"}
	testing.expectf(t, slice.equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
test_student_not_added_to_other_grade_for_multiple_grades :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	testing.expect(t, add(&school, "Blair", 2))
	testing.expect(t, add(&school, "James", 2))
	testing.expectf(
		t,
		!add(&school, "James", 3),
		"James should not be in grade 3, he already in grade 2",
	)
	testing.expect(t, add(&school, "Paul", 3))
	result := grade(&school, 3)
	expected := []string{"Paul"}
	testing.expectf(t, slice.equal(result, expected), "expected %v got %v", expected, result)
}

@(test)
test_students_are_sorted_by_name_in_a_grade :: proc(t: ^testing.T) {
	school: School
	defer delete_school(&school)
	testing.expect(t, add(&school, "Franklin", 5))
	testing.expect(t, add(&school, "Bradley", 5))
	testing.expect(t, add(&school, "Jeff", 1))
	result := grade(&school, 5)
	expected := []string{"Bradley", "Franklin"}
	testing.expectf(t, slice.equal(result, expected), "expected %v got %v", expected, result)
}
