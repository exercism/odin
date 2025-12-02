package mkdoc

import "core:fmt"
import "core:os"
import "core:strings"
import "core:text/regex"

main :: proc() {

	// This program runs once on a single file and exit,
	// there is no point worrying about reclaiming memory
	// right before the OS does.

	if len(os.args) != 5 {
		fmt.eprintln(
			"Usage: mkdoc <source path> <about path> <concept intro path> <exercise intro path>",
		)
		os.exit(1)
	}

	source_path := os.args[1]
	content, ok := os.read_entire_file_from_filename(source_path)
	if !ok {
		fmt.eprintf("Unable to read content of %s\n", source_path)
		os.exit(1)
	}

	about_path := os.args[2]
	cintro_path := os.args[3]
	xintro_path := os.args[4]
	err := split_file(string(content), about_path, cintro_path, xintro_path)
	if err != nil {
		fmt.eprintf("Unable to split %s: %v\n", source_path, err)
		os.exit(1)
	}
}

Error :: union {
	string,
}

Destination :: struct {
	about:                 bool,
	cintro:                bool,
	xintro:                bool,
	in_restricted_section: bool,
}

split_file :: proc(content: string, aboutpath, cintropath, xintropath: string) -> Error {

	// context.allocator = context.temp_allocator

	FILE_FLAGS :: os.O_RDWR | os.O_CREATE | os.O_TRUNC
	about := open_file(aboutpath, FILE_FLAGS) or_return
	defer (os.close(about))
	cintro := open_file(cintropath, FILE_FLAGS) or_return
	defer (os.close(cintro))
	xintro := open_file(xintropath, FILE_FLAGS) or_return
	defer (os.close(xintro))

	start := regex_compile(`\[/restrict/\]: \#\(([a-zA-Z,]*)\)`)
	stop := regex_compile(`\[/all/\]: \#\(([a-zA-Z,]*)\)`)
	capture := regex.preallocate_capture()

	dest := Destination {
		about  = true,
		cintro = true,
		xintro = true,
	}

	lineno := 1
	for line in strings.split(content, "\n") {
		if _, match_start := regex.match(start, line, &capture); match_start {
			restrict_destination(&dest, capture.groups[1], lineno) or_return
		} else if _, match_stop := regex.match(stop, line, &capture); match_stop {
			all_destination(&dest, capture.groups[1], lineno) or_return
		} else {
			if dest.about {
				fmt.fprintln(about, line)
			}
			if dest.cintro {
				fmt.fprintln(cintro, line)
			}
			if dest.xintro {
				fmt.fprintln(xintro, line)
			}
		}
		lineno += 1
	}
	return nil
}

open_file :: proc(filename: string, flags: int) -> (os.Handle, Error) {

	handle, err := os.open(filename, flags, 0o644)
	if err != nil {
		return handle, fmt.aprintf("trying to open %s returns %v", filename, err)
	}
	return handle, nil
}

restrict_destination :: proc(d: ^Destination, args: string, lineno: int) -> Error {

	// Only allows sections listed in the arguments
	d.about = false
	d.cintro = false
	d.xintro = false
	d.in_restricted_section = true
	for arg in strings.split(args, ",") {
		tag := strings.trim(arg, " \t")
		switch tag {
		case "about":
			d.about = true
		case "cintro":
			d.cintro = true
		case "xintro":
			d.xintro = true
		case:
			return fmt.aprintf(
				"Error: [line %d] Unknown option '%s' in '[/restrict/] #(...)' tag",
				lineno,
				tag,
			)
		}
	}
	return nil
}

all_destination :: proc(d: ^Destination, args: string, lineno: int) -> Error {

	if len(args) > 0 {
		return fmt.aprintf("Error: [line %d] Did not expects options in '[/all/] #()' tag", lineno)
	}
	// re-enable all the sections
	d.about = true
	d.cintro = true
	d.xintro = true
	d.in_restricted_section = false
	return nil
}

regex_compile :: proc(pattern: string) -> regex.Regular_Expression {

	re, err := regex.create(pattern)
	ensure(err == nil)
	return re
}
