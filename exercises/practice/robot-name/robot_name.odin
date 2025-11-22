package robotname

import "core:fmt"
import "core:math/rand"

RobotStorage :: struct { } // Please implement neccessary struct member to support your algorithm

Robot :: struct {
	name: string,
}

Error :: enum {
	CouldNotCreateName,
}

make_storage :: proc() -> RobotStorage {
	#panic("Please implement the `make_storage` procedure.")
}

delete_storage :: proc(storage: ^RobotStorage) {
	#panic("Please implement the `delete_storage` procedure.")
}

new_robot :: proc(storage: ^RobotStorage) -> (Robot, Error) {
	#panic("Please implement the `new_robot` procedure.")
}

reset :: proc(storage: ^RobotStorage, r: ^Robot) {
	#panic("Please implement the `reset` procedure.")
}
