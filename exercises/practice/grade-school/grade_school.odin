package grade_school

School :: struct {} // implement School struct

Grade :: struct {
	id:       u8,
	students: []string,
}

add :: proc(self: ^School, student: string, grade: u8) -> bool {
	// Implement this procedure.
	return false
}

grade :: proc(self: ^School, id: u8) -> []string {
	// Implement this procedure.
	return nil
}

roster :: proc(self: ^School) -> []Grade {
	// Implement this procedure.
	return nil
}

delete_school :: proc(self: ^School) {

}
