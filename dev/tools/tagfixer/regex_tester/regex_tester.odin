package regex_tester

import "core:bufio"
import "core:fmt"
import "core:os"
import "core:text/regex"
import "core:text/regex/common"

main :: proc() {

	stdin_stream := os.stream_from_handle(os.stdin)
	scanner: bufio.Scanner
	bufio.scanner_init(&scanner, stdin_stream)

	fmt.println("Odin regex tester:")
	fmt.println("Enter a regex:")

	if !bufio.scanner_scan(&scanner) {
		fmt.eprintln("Unable to read the regex.")
		os.exit(1)
	}

	pattern := bufio.scanner_text(&scanner)
	fmt.printf("regex:'%s'\n", pattern)
	re, err := regex.create(pattern)
	if err != nil {
		fmt.eprintf("Can't create regex '%s': %v\n", pattern, err)
		os.exit(1)
	}

	fmt.println("Enter expressions to parse (blank line to quit):")
	for {

		fmt.print(">")
		if !bufio.scanner_scan(&scanner) {
			fmt.eprintln("Unable to read the regex.")
			os.exit(1)
		}
		input := bufio.scanner_text(&scanner)
		if len(input) == 0 { break }
		capture, success := regex.match(re, input)
		if !success {
			fmt.println("No match!")
		}
		fmt.println("Capture:")
		fmt.printf("%#v\n", capture)
	}
}
