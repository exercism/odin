package grade_school

import "core:slice"

School :: struct {
	grades:   map[u8][dynamic]string,
	students: map[string]bool,
}

Grade :: struct {
	id:       u8,
	students: []string,
}

add :: proc(self: ^School, student: string, grade: u8) -> bool {
	if student in self.students {
		return false
	}
	self.students[student] = true
	if grade not_in self.grades {
		self.grades[grade] = make([dynamic]string)
	}
	arr := &self.grades[grade]
	if i, found := slice.binary_search(arr[:], student); !found {
		inject_at(arr, i, student)
	}
	return true
}

grade :: proc(self: ^School, id: u8) -> []string {
	if grade, ok := self.grades[id]; ok {
		return grade[:]
	}
	return nil
}

roster :: proc(self: ^School) -> []Grade {
	grades := make([dynamic]Grade)
	for id, grade in self.grades {
		append(&grades, Grade{id = id, students = grade[:]})
	}
	slice.sort_by(grades[:], proc(a, b: Grade) -> bool {
		return a.id < b.id
	})
	return grades[:]
}

delete_school :: proc(self: ^School) {
	for _, grade in self.grades {
		delete(grade)
	}
	delete(self.grades)
	delete(self.students)
}
