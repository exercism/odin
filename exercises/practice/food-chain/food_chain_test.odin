package food_chain

import "core:testing"

@(test)
/// description = fly
test_fly :: proc(t: ^testing.T) {
	expected := `I know an old lady who swallowed a fly.
I don't know why she swallowed the fly. Perhaps she'll die.`

	actual := recite(1, 1)
	defer delete(actual)
	testing.expect_value(t, actual, expected)
}
@(test)
/// description = spider
test_spider :: proc(t: ^testing.T) {
	expected := `I know an old lady who swallowed a spider.
It wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.`

	actual := recite(2, 2)
	defer delete(actual)
	testing.expect_value(t, actual, expected)
}
@(test)
/// description = bird
test_bird :: proc(t: ^testing.T) {
	expected := `I know an old lady who swallowed a bird.
How absurd to swallow a bird!
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.`

	actual := recite(3, 3)
	defer delete(actual)
	testing.expect_value(t, actual, expected)
}
@(test)
/// description = cat
test_cat :: proc(t: ^testing.T) {
	expected := `I know an old lady who swallowed a cat.
Imagine that, to swallow a cat!
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.`

	actual := recite(4, 4)
	defer delete(actual)
	testing.expect_value(t, actual, expected)
}
@(test)
/// description = dog
test_dog :: proc(t: ^testing.T) {
	expected := `I know an old lady who swallowed a dog.
What a hog, to swallow a dog!
She swallowed the dog to catch the cat.
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.`

	actual := recite(5, 5)
	defer delete(actual)
	testing.expect_value(t, actual, expected)
}
@(test)
/// description = goat
test_goat :: proc(t: ^testing.T) {
	expected := `I know an old lady who swallowed a goat.
Just opened her throat and swallowed a goat!
She swallowed the goat to catch the dog.
She swallowed the dog to catch the cat.
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.`

	actual := recite(6, 6)
	defer delete(actual)
	testing.expect_value(t, actual, expected)
}
@(test)
/// description = cow
test_cow :: proc(t: ^testing.T) {
	expected := `I know an old lady who swallowed a cow.
I don't know how she swallowed a cow!
She swallowed the cow to catch the goat.
She swallowed the goat to catch the dog.
She swallowed the dog to catch the cat.
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.`

	actual := recite(7, 7)
	defer delete(actual)
	testing.expect_value(t, actual, expected)
}
@(test)
/// description = horse
test_horse :: proc(t: ^testing.T) {
	expected := `I know an old lady who swallowed a horse.
She's dead, of course!`

	actual := recite(8, 8)
	defer delete(actual)
	testing.expect_value(t, actual, expected)
}
@(test)
/// description = multiple verse
test_multiple_verse :: proc(t: ^testing.T) {
	expected := `I know an old lady who swallowed a fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a spider.
It wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a bird.
How absurd to swallow a bird!
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.`

	actual := recite(1, 3)
	defer delete(actual)
	testing.expect_value(t, actual, expected)
}
@(test)
/// description = full song
test_full_song :: proc(t: ^testing.T) {
	expected := `I know an old lady who swallowed a fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a spider.
It wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a bird.
How absurd to swallow a bird!
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a cat.
Imagine that, to swallow a cat!
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a dog.
What a hog, to swallow a dog!
She swallowed the dog to catch the cat.
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a goat.
Just opened her throat and swallowed a goat!
She swallowed the goat to catch the dog.
She swallowed the dog to catch the cat.
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a cow.
I don't know how she swallowed a cow!
She swallowed the cow to catch the goat.
She swallowed the goat to catch the dog.
She swallowed the dog to catch the cat.
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a horse.
She's dead, of course!`

	actual := recite(1, 8)
	defer delete(actual)
	testing.expect_value(t, actual, expected)
}
