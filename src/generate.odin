package exercism

import "core:fmt"
import "core:strings"
import "core:os"

import c "shared:common"

main :: proc() {
	home := os.get_env("HOME")
	pwd := os.get_current_directory()
	configlet_cache := fmt.aprintf(
		"{}/.cache/exercism/configlet/problem-specifications/exercises",
		home,
	)

	// exercises_dir := "exercises"
	// practice_exercises_dir := fmt.aprintf("{}/practice", exercises_dir)

	fmt.println(home)
	fmt.println(pwd)
	fmt.println(configlet_cache)

	// TODO: Run configlet binary via: https://pkg.odin-lang.org/core/c/libc/#system

	/*
        https://pkg.odin-lang.org/core/os/#read_dir
        https://pkg.odin-lang.org/core/os/#read_entire_file_from_filename
        https://pkg.odin-lang.org/core/path/filepath/#join
    */

	for i, arg in os.args {
		fmt.printf("Argument %d: %s\n", i, arg)
	}

	args := []c.Argument{
		c.Argument{name = "abc", type = "int", value = 10},
		c.Argument{name = "xyz", type = "string", value = "foo"},
	}

	function := c.Function {
		name = "bob",
		args = args,
		ret = c.Argument{name = "www", type = "string", value = "123"},
	}

	test := c.Test {
		name     = "should_do_the_thing",
		function = function,
		expected = "123",
	}

	indent_level := 0

	sb := strings.builder_make()
	c.write_to_sb(&sb, indent_level, true, `// main.odin`)
	c.generate_function(&sb, indent_level, function)
	c.write_to_sb(&sb, indent_level, true, ``)
	c.write_to_sb(&sb, indent_level, true, `// test.odin`)
	c.generate_test(&sb, indent_level, test)
	c.write_to_sb(&sb, indent_level, true, ``)

	fmt.printf("{}", strings.to_string(sb))
}
