package circular_buffer

import "core:crypto/legacy/keccak"
import "core:testing"

@(test)
test_reading_empty_buffer_should_fail :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	rd_value, rd_error := read(&buffer)
	testing.expect_value(t, rd_error, Error.BufferEmpty)
}

@(test)
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
test_each_item_may_only_be_read_once :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	wr_error := write(&buffer, 1)
	testing.expect_value(t, wr_error, Error.None)

	rd_value1, rd_error1 := read(&buffer)
	testing.expect_value(t, rd_error1, Error.None)
	testing.expect_value(t, rd_value1, 1)

	rd_value2, rd_error2 := read(&buffer)
	testing.expect_value(t, rd_error2, Error.BufferEmpty)
}

@(test)
test_items_are_read_in_the_order_they_are_written :: proc(t: ^testing.T) {

	buffer := new_buffer(2)
	defer destroy_buffer(&buffer)

	wr_error1 := write(&buffer, 1)
	testing.expect_value(t, wr_error1, Error.None)

	wr_error2 := write(&buffer, 2)
	testing.expect_value(t, wr_error2, Error.None)

	rd_value1, rd_error1 := read(&buffer)
	testing.expect_value(t, rd_error1, Error.None)
	testing.expect_value(t, rd_value1, 1)

	rd_value2, rd_error2 := read(&buffer)
	testing.expect_value(t, rd_error2, Error.None)
	testing.expect_value(t, rd_value2, 2)
}

@(test)
test_full_buffer_cant_be_written_to :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	wr_error1 := write(&buffer, 1)
	testing.expect_value(t, wr_error1, Error.None)

	wr_error2 := write(&buffer, 2)
	testing.expect_value(t, wr_error2, Error.BufferFull)
}

@(test)
test_a_read_frees_up_capacity_for_another_write :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	wr_error1 := write(&buffer, 1)
	testing.expect_value(t, wr_error1, Error.None)

	rd_value1, rd_error1 := read(&buffer)
	testing.expect_value(t, rd_error1, Error.None)
	testing.expect_value(t, rd_value1, 1)

	wr_error2 := write(&buffer, 2)
	testing.expect_value(t, wr_error2, Error.None)

	rd_value2, rd_error2 := read(&buffer)
	testing.expect_value(t, rd_error2, Error.None)
	testing.expect_value(t, rd_value2, 2)
}

@(test)
test_read_position_is_maintained_even_across_multiple_writes :: proc(
	t: ^testing.T,
) {

	buffer := new_buffer(3)
	defer destroy_buffer(&buffer)

	wr_error1 := write(&buffer, 1)
	testing.expect_value(t, wr_error1, Error.None)

	wr_error2 := write(&buffer, 2)
	testing.expect_value(t, wr_error2, Error.None)

	rd_value1, rd_error1 := read(&buffer)
	testing.expect_value(t, rd_error1, Error.None)
	testing.expect_value(t, rd_value1, 1)

	wr_error3 := write(&buffer, 3)
	testing.expect_value(t, wr_error3, Error.None)

	rd_value2, rd_error2 := read(&buffer)
	testing.expect_value(t, rd_error2, Error.None)
	testing.expect_value(t, rd_value2, 2)

	rd_value3, rd_error3 := read(&buffer)
	testing.expect_value(t, rd_error3, Error.None)
	testing.expect_value(t, rd_value3, 3)
}

@(test)
test_items_cleared_out_of_buffer_cant_be_read :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	wr_error1 := write(&buffer, 1)
	testing.expect_value(t, wr_error1, Error.None)

	clear(&buffer)

	rd_value1, rd_error1 := read(&buffer)
	testing.expect_value(t, rd_error1, Error.BufferEmpty)
}

@(test)
test_clear_frees_up_capacity_for_another_write :: proc(t: ^testing.T) {

	buffer := new_buffer(1)
	defer destroy_buffer(&buffer)

	wr_error1 := write(&buffer, 1)
	testing.expect_value(t, wr_error1, Error.None)

	clear(&buffer)

	wr_error2 := write(&buffer, 2)
	testing.expect_value(t, wr_error2, Error.None)

	rd_value1, rd_error1 := read(&buffer)
	testing.expect_value(t, rd_error1, Error.None)
	testing.expect_value(t, rd_value1, 2)
}

@(test)
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
test_overwrite_acts_like_write_on_non_full_buffer :: proc(t: ^testing.T) {

	buffer := new_buffer(2)
	defer destroy_buffer(&buffer)

	wr_error1 := write(&buffer, 1)
	testing.expect_value(t, wr_error1, Error.None)

	overwrite(&buffer, 2)

	rd_value1, rd_error1 := read(&buffer)
	testing.expect_value(t, rd_error1, Error.None)
	testing.expect_value(t, rd_value1, 1)

	rd_value2, rd_error2 := read(&buffer)
	testing.expect_value(t, rd_error2, Error.None)
	testing.expect_value(t, rd_value2, 2)
}

@(test)
test_overwrite_replaces_the_oldest_item_on_full_buffer :: proc(t: ^testing.T) {

	buffer := new_buffer(2)
	defer destroy_buffer(&buffer)

	wr_error1 := write(&buffer, 1)
	testing.expect_value(t, wr_error1, Error.None)

	wr_error2 := write(&buffer, 2)
	testing.expect_value(t, wr_error2, Error.None)

	overwrite(&buffer, 3)

	rd_value1, rd_error1 := read(&buffer)
	testing.expect_value(t, rd_error1, Error.None)
	testing.expect_value(t, rd_value1, 2)

	rd_value2, rd_error2 := read(&buffer)
	testing.expect_value(t, rd_error2, Error.None)
	testing.expect_value(t, rd_value2, 3)
}

@(test)
test_overwrite_replaces_the_oldest_item_remaining_in_buffer_following_a_read :: proc(
	t: ^testing.T,
) {

	buffer := new_buffer(3)
	defer destroy_buffer(&buffer)

	wr_error1 := write(&buffer, 1)
	testing.expect_value(t, wr_error1, Error.None)

	wr_error2 := write(&buffer, 2)
	testing.expect_value(t, wr_error2, Error.None)

	wr_error3 := write(&buffer, 3)
	testing.expect_value(t, wr_error3, Error.None)

	rd_value1, rd_error1 := read(&buffer)
	testing.expect_value(t, rd_error1, Error.None)
	testing.expect_value(t, rd_value1, 1)

	wr_error4 := write(&buffer, 4)
	testing.expect_value(t, wr_error4, Error.None)

	overwrite(&buffer, 5)

	rd_value2, rd_error2 := read(&buffer)
	testing.expect_value(t, rd_error2, Error.None)
	testing.expect_value(t, rd_value2, 3)

	rd_value3, rd_error3 := read(&buffer)
	testing.expect_value(t, rd_error3, Error.None)
	testing.expect_value(t, rd_value3, 4)

	rd_value4, rd_error4 := read(&buffer)
	testing.expect_value(t, rd_error4, Error.None)
	testing.expect_value(t, rd_value4, 5)
}

@(test)
test_initial_clear_does_not_affect_wrapping_around :: proc(t: ^testing.T) {

	buffer := new_buffer(2)
	defer destroy_buffer(&buffer)

	clear(&buffer)

	wr_error1 := write(&buffer, 1)
	testing.expect_value(t, wr_error1, Error.None)

	wr_error2 := write(&buffer, 2)
	testing.expect_value(t, wr_error2, Error.None)

	overwrite(&buffer, 3)

	overwrite(&buffer, 4)

	rd_value1, rd_error1 := read(&buffer)
	testing.expect_value(t, rd_error1, Error.None)
	testing.expect_value(t, rd_value1, 3)

	rd_value2, rd_error2 := read(&buffer)
	testing.expect_value(t, rd_error2, Error.None)
	testing.expect_value(t, rd_value2, 4)

	rd_value3, rd_error3 := read(&buffer)
	testing.expect_value(t, rd_error3, Error.BufferEmpty)
}
