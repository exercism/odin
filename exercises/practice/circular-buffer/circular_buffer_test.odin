package circular_buffer

import "core:testing"

@(test)
/// description = reading empty buffer should fail
test_reading_empty_buffer_should_fail :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	_, rd_error := read(&buffer)
	testing.expect_value(t, rd_error, Error.BufferEmpty)
}

@(test)
/// description = can read an item just written
test_can_read_an_item_just_written :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	wr_error := write(&buffer, 1)
	testing.expect_value(t, wr_error, Error.None)

	rd_value, rd_error := read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 1)
}

@(test)
/// description = each item may only be read once
test_each_item_may_only_be_read_once :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	wr_error := write(&buffer, 1)
	testing.expect_value(t, wr_error, Error.None)

	rd_value, rd_error := read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 1)

	rd_value, rd_error = read(&buffer)
	testing.expect_value(t, rd_error, Error.BufferEmpty)
}

@(test)
/// description = items are read in the order they are written
test_items_are_read_in_the_order_they_are_written :: proc(t: ^testing.T) {

	buffer := new_buffer(2)
	defer destroy_buffer(&buffer)

	wr_error := write(&buffer, 1)
	testing.expect_value(t, wr_error, Error.None)

	wr_error = write(&buffer, 2)
	testing.expect_value(t, wr_error, Error.None)

	rd_value, rd_error := read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 1)

	rd_value, rd_error = read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 2)
}

@(test)
/// description = full buffer can't be written to
test_full_buffer_cant_be_written_to :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	wr_error := write(&buffer, 1)
	testing.expect_value(t, wr_error, Error.None)

	wr_error = write(&buffer, 2)
	testing.expect_value(t, wr_error, Error.BufferFull)
}

@(test)
/// description = a read frees up capacity for another write
test_a_read_frees_up_capacity_for_another_write :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	wr_error := write(&buffer, 1)
	testing.expect_value(t, wr_error, Error.None)

	rd_value, rd_error := read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 1)

	wr_error = write(&buffer, 2)
	testing.expect_value(t, wr_error, Error.None)

	rd_value, rd_error = read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 2)
}

@(test)
/// description = read position is maintained even across multiple writes
test_read_position_is_maintained_even_across_multiple_writes :: proc(t: ^testing.T) {

	buffer := new_buffer(3)
	defer destroy_buffer(&buffer)

	wr_error := write(&buffer, 1)
	testing.expect_value(t, wr_error, Error.None)

	wr_error = write(&buffer, 2)
	testing.expect_value(t, wr_error, Error.None)

	rd_value, rd_error := read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 1)

	wr_error = write(&buffer, 3)
	testing.expect_value(t, wr_error, Error.None)

	rd_value, rd_error = read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 2)

	rd_value, rd_error = read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 3)
}

@(test)
/// description = items cleared out of buffer can't be read
test_items_cleared_out_of_buffer_cant_be_read :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	wr_error := write(&buffer, 1)
	testing.expect_value(t, wr_error, Error.None)

	clear(&buffer)

	_, rd_error := read(&buffer)
	testing.expect_value(t, rd_error, Error.BufferEmpty)
}

@(test)
/// description = clear frees up capacity for another write
test_clear_frees_up_capacity_for_another_write :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	wr_error := write(&buffer, 1)
	testing.expect_value(t, wr_error, Error.None)

	clear(&buffer)

	wr_error = write(&buffer, 2)
	testing.expect_value(t, wr_error, Error.None)

	rd_value, rd_error := read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 2)
}

@(test)
/// description = clear does nothing on empty buffer
test_clear_does_nothing_on_empty_buffer :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	clear(&buffer)

	wr_error := write(&buffer, 1)
	testing.expect_value(t, wr_error, Error.None)

	rd_value, rd_error := read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 1)
}

@(test)
/// description = overwrite acts like write on non-full buffer
test_overwrite_acts_like_write_on_non_full_buffer :: proc(t: ^testing.T) {

	buffer := new_buffer(2)
	defer destroy_buffer(&buffer)

	wr_error := write(&buffer, 1)
	testing.expect_value(t, wr_error, Error.None)

	overwrite(&buffer, 2)

	rd_value, rd_error := read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 1)

	rd_value, rd_error = read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 2)
}

@(test)
/// description = overwrite replaces the oldest item on full buffer
test_overwrite_replaces_the_oldest_item_on_full_buffer :: proc(t: ^testing.T) {

	buffer := new_buffer(2)
	defer destroy_buffer(&buffer)

	wr_error := write(&buffer, 1)
	testing.expect_value(t, wr_error, Error.None)

	wr_error = write(&buffer, 2)
	testing.expect_value(t, wr_error, Error.None)

	overwrite(&buffer, 3)

	rd_value, rd_error := read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 2)

	rd_value, rd_error = read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 3)
}

@(test)
/// description = overwrite replaces the oldest item remaining in buffer following a read
test_overwrite_replaces_the_oldest_item_remaining_in_buffer_following_a_read :: proc(
	t: ^testing.T,
) {

	buffer := new_buffer(3)
	defer destroy_buffer(&buffer)

	wr_error := write(&buffer, 1)
	testing.expect_value(t, wr_error, Error.None)

	wr_error = write(&buffer, 2)
	testing.expect_value(t, wr_error, Error.None)

	wr_error = write(&buffer, 3)
	testing.expect_value(t, wr_error, Error.None)

	rd_value, rd_error := read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 1)

	wr_error = write(&buffer, 4)
	testing.expect_value(t, wr_error, Error.None)

	overwrite(&buffer, 5)

	rd_value, rd_error = read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 3)

	rd_value, rd_error = read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 4)

	rd_value, rd_error = read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 5)
}

@(test)
/// description = initial clear does not affect wrapping around
test_initial_clear_does_not_affect_wrapping_around :: proc(t: ^testing.T) {

	buffer := new_buffer(2)
	defer destroy_buffer(&buffer)

	clear(&buffer)

	wr_error := write(&buffer, 1)
	testing.expect_value(t, wr_error, Error.None)

	wr_error = write(&buffer, 2)
	testing.expect_value(t, wr_error, Error.None)

	overwrite(&buffer, 3)
	overwrite(&buffer, 4)

	rd_value, rd_error := read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 3)

	rd_value, rd_error = read(&buffer)
	testing.expect_value(t, rd_error, Error.None)
	testing.expect_value(t, rd_value, 4)

	rd_value, rd_error = read(&buffer)
	testing.expect_value(t, rd_error, Error.BufferEmpty)
}
