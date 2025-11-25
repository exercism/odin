package robotname

import "core:fmt"
import "core:math/rand"

Robot_Storage :: struct { } // Please implement neccessary struct member to support your algorithm

Robot :: struct {
	name: string,
}

Error :: enum {
	Could_Not_Create_Name,
}

make_storage :: proc() -> Robot_Storage {
	#panic("Please implement the `make_storage` procedure.")
}

delete_storage :: proc(storage: ^Robot_Storage) {
	#panic("Please implement the `delete_storage` procedure.")
}

new_robot :: proc(storage: ^Robot_Storage) -> (Robot, Error) {
	#panic("Please implement the `new_robot` procedure.")
}

reset :: proc(storage: ^Robot_Storage, r: ^Robot) {
	#panic("Please implement the `reset` procedure.")
}
