package food_chain

import "core:strings"

Animal :: struct {
	name:      string,
	name_long: Maybe(string),
	phrase:    string,
	next:      Maybe(^Animal),
}

fly := Animal {
	name   = "fly",
	phrase = "I don't know why she swallowed the fly. Perhaps she'll die.",
}
spider := Animal {
	name      = "spider",
	name_long = "spider that wriggled and jiggled and tickled inside her",
	phrase    = "It wriggled and jiggled and tickled inside her.",
	next      = &fly,
}
bird := Animal {
	name   = "bird",
	phrase = "How absurd to swallow a bird!",
	next   = &spider,
}
cat := Animal {
	name   = "cat",
	phrase = "Imagine that, to swallow a cat!",
	next   = &bird,
}
dog := Animal {
	name   = "dog",
	phrase = "What a hog, to swallow a dog!",
	next   = &cat,
}
goat := Animal {
	name   = "goat",
	phrase = "Just opened her throat and swallowed a goat!",
	next   = &dog,
}
cow := Animal {
	name   = "cow",
	phrase = "I don't know how she swallowed a cow!",
	next   = &goat,
}
horse := Animal {
	name   = "horse",
	phrase = "She's dead, of course!",
}

verses := [8]Animal{fly, spider, bird, cat, dog, goat, cow, horse}

generate_verse :: proc(builder: ^strings.Builder, i: int) {
	animal: Maybe(^Animal) = &verses[i]
	node, ok := animal.?
	if !ok {
		return
	}
	strings.write_string(builder, "I know an old lady who swallowed a ")
	strings.write_string(builder, node.name)
	strings.write_string(builder, ".\n")
	if node.next != nil {
		strings.write_string(builder, node.phrase)
		strings.write_rune(builder, '\n')
	}
	for {
		node = animal.? or_break
		if node.next == nil {
			strings.write_string(builder, node.phrase)
			strings.write_rune(builder, '\n')
		} else {
			next := node.next.?
			strings.write_string(builder, "She swallowed the ")
			strings.write_string(builder, node.name)
			strings.write_string(builder, " to catch the ")
			name := next.name_long.? or_else next.name
			strings.write_string(builder, name)
			strings.write_string(builder, ".\n")
		}
		animal = node.next
	}
}

recite :: proc(start, end: int) -> string {
	builder := strings.builder_make()
	for i in start - 1 ..< end {
		generate_verse(&builder, i)
		strings.write_rune(&builder, '\n')
	}
	return strings.trim_right_space(strings.to_string(builder))
}
