package bottle_song

import "core:fmt"

recite :: proc(start_bottles, take_down: int) -> []string {

	num_verses := take_down * 4 + (take_down - 1)
	song := make([dynamic]string, 0, num_verses)
	for i := 0; i < take_down; i += 1 {
		n := start_bottles - i
		// Need an empty line to separate paragraphs.
		if i > 0 {
			// This seems redundant, but if we don't have all the strings in the `[]string`
			// dynamically allocated, the `delete()` in the caller is having a hard time
			// figuring out which ones to free and which ones not to, resulting in a `bad free` warning.
			append(&song, fmt.aprintf(""))
		}
		verse1 := fmt.aprintf("%s green bottle%s hanging on the wall,", cap_nums[n], plural(n))
		append(&song, verse1)
		verse2 := fmt.aprintf("%s green bottle%s hanging on the wall,", cap_nums[n], plural(n))
		append(&song, verse2)

		// Same comment as for "" being dynamic above.
		verse3 := fmt.aprintf("And if one green bottle should accidentally fall,")
		append(&song, verse3)

		verse4 := fmt.aprintf(
			"There'll be %s green bottle%s hanging on the wall.",
			nums[n - 1],
			plural(n - 1),
		)
		append(&song, verse4)}
	return song[:]
}

plural :: proc(n: int) -> string {

	// We only use "bottle" (singular) for one (not "no bottles").
	if n == 1 { return "" }
	return "s"
}

nums := [?]string {
	"no",
	"one",
	"two",
	"three",
	"four",
	"five",
	"six",
	"seven",
	"eight",
	"nine",
	"ten",
}

cap_nums := [?]string {
	"No",
	"One",
	"Two",
	"Three",
	"Four",
	"Five",
	"Six",
	"Seven",
	"Eight",
	"Nine",
	"Ten",
}
