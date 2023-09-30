package common

import "core:fmt"
import "core:strings"

TomlAssignment :: struct {
	name: string,
  value: string
}

// This is lazy and only processes variable declaration lines :D
read_toml_lines :: proc(yaml: string) -> []TomlAssignment {
	lines := strings.split(yaml, "\n")

	toml_assignments: [dynamic]TomlAssignment

	for line in lines {
		splits := strings.split(line, "=")

		toml_assignment := TomlAssignment {
			name = strings.trim_space(splits[0]),
			value = strings.trim_space(splits[1])
		}

		append(&toml_assignments, toml_assignment)
	}

	fmt.println("{}", toml_assignments[:])
	return toml_assignments[:]
}
