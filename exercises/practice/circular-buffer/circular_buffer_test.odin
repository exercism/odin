package circular_buffer

import "core:testing"

// This helper function performs a read and check the result.
expect_read :: proc(
	t: ^testing.T,
	buffer: ^Buffer,
	exp_value: int,
	exp_error: Error,
	caller_loc := #caller_location,
) {

	rd_value, rd_error := read(buffer)
	testing.expect_value(t, rd_error, exp_error, loc = caller_loc)
	// We only need to test the value if there was no error.
	if rd_error == .None {
		testing.expect_value(t, rd_value, exp_value, loc = caller_loc)
	}
}

// This helper function performes a write and check the result.
expect_write :: proc(
	t: ^testing.T,
	buffer: ^Buffer,
	wr_value: int,
	exp_error: Error,
	caller_loc := #caller_location,
) {

	wr_error := write(buffer, wr_value)
	testing.expect_value(t, wr_error, exp_error, loc = caller_loc)
}

@(test)
test_reading_empty_buffer_should_fail :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	expect_read(t, &buffer, 0, .BufferEmpty)
}

@(test)
test_can_read_an_item_just_written :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	expect_write(t, &buffer, 1, .None)
	expect_read(t, &buffer, 1, .None)
}

@(test)
test_each_item_may_only_be_read_once :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	expect_write(t, &buffer, 1, .None)
	expect_read(t, &buffer, 1, .None)
	expect_read(t, &buffer, 0, .BufferEmpty)
}

@(test)
test_items_are_read_in_the_order_they_are_written :: proc(t: ^testing.T) {

	buffer := new_buffer(2)
	defer destroy_buffer(&buffer)

	expect_write(t, &buffer, 1, .None)
	expect_write(t, &buffer, 2, .None)
	expect_read(t, &buffer, 1, .None)
	expect_read(t, &buffer, 2, .None)
}

@(test)
test_full_buffer_cant_be_written_to :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	expect_write(t, &buffer, 1, .None)
	expect_write(t, &buffer, 2, .BufferFull)
}

@(test)
test_a_read_frees_up_capacity_for_another_write :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	expect_write(t, &buffer, 1, .None)
	expect_read(t, &buffer, 1, .None)
	expect_write(t, &buffer, 2, .None)
	expect_read(t, &buffer, 2, .None)
}

@(test)
test_read_position_is_maintained_even_across_multiple_writes :: proc(
	t: ^testing.T,
) {

	buffer := new_buffer(3)
	defer destroy_buffer(&buffer)

	expect_write(t, &buffer, 1, .None)
	expect_write(t, &buffer, 2, .None)
	expect_read(t, &buffer, 1, .None)
	expect_write(t, &buffer, 3, .None)
	expect_read(t, &buffer, 2, .None)
	expect_read(t, &buffer, 3, .None)
}

@(test)
test_items_cleared_out_of_buffer_cant_be_read :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	expect_write(t, &buffer, 1, .None)
	clear(&buffer)
	expect_read(t, &buffer, 0, .BufferEmpty)
}

@(test)
test_clear_frees_up_capacity_for_another_write :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	expect_write(t, &buffer, 1, .None)
	clear(&buffer)
	expect_write(t, &buffer, 2, .None)
	expect_read(t, &buffer, 2, .None)
}

@(test)
test_clear_does_nothing_on_empty_buffer :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	clear(&buffer)
	expect_write(t, &buffer, 1, .None)
	expect_read(t, &buffer, 1, .None)
}

@(test)
test_overwrite_acts_like_write_on_non_full_buffer :: proc(t: ^testing.T) {

	buffer := new_buffer(2)
	defer destroy_buffer(&buffer)

	expect_write(t, &buffer, 1, .None)
	overwrite(&buffer, 2)
	expect_read(t, &buffer, 1, .None)
	expect_read(t, &buffer, 2, .None)
}

@(test)
test_overwrite_replaces_the_oldest_item_on_full_buffer :: proc(t: ^testing.T) {

	buffer := new_buffer(2)
	defer destroy_buffer(&buffer)

	expect_write(t, &buffer, 1, .None)
	expect_write(t, &buffer, 2, .None)
	overwrite(&buffer, 3)
	expect_read(t, &buffer, 2, .None)
	expect_read(t, &buffer, 3, .None)
}

@(test)
test_overwrite_replaces_the_oldest_item_remaining_in_buffer_following_a_read :: proc(
	t: ^testing.T,
) {

	buffer := new_buffer(3)
	defer destroy_buffer(&buffer)

	expect_write(t, &buffer, 1, .None)
	expect_write(t, &buffer, 2, .None)
	expect_write(t, &buffer, 3, .None)
	expect_read(t, &buffer, 1, .None)
	expect_write(t, &buffer, 4, .None)
	overwrite(&buffer, 5)
	expect_read(t, &buffer, 3, .None)
	expect_read(t, &buffer, 4, .None)
	expect_read(t, &buffer, 5, .None)
}

@(test)
test_initial_clear_does_not_affect_wrapping_around :: proc(t: ^testing.T) {

	buffer := new_buffer(2)
	defer destroy_buffer(&buffer)

	clear(&buffer)
	expect_write(t, &buffer, 1, .None)
	expect_write(t, &buffer, 2, .None)
	overwrite(&buffer, 3)
	overwrite(&buffer, 4)
	expect_read(t, &buffer, 3, .None)
	expect_read(t, &buffer, 4, .None)
	expect_read(t, &buffer, 0, .BufferEmpty)
}
