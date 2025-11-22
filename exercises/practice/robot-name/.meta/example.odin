package robotname

import "core:math/rand"

RobotStorage :: struct {
	names: map[string]bool,
}

Robot :: struct {
	name: string,
}

Error :: enum {
	CouldNotCreateName,
}

make_storage :: proc() -> RobotStorage {
	return RobotStorage{make(map[string]bool)}
}
delete_storage :: proc(storage: ^RobotStorage) {
	for k in storage.names {
		delete(k)
	}
	delete(storage.names)
}

new_robot :: proc(storage: ^RobotStorage) -> (Robot, Error) {
	name, e := create_name(storage)
	return Robot{name}, e
}

reset :: proc(storage: ^RobotStorage, r: ^Robot) {
	delete_key(&storage.names, r.name)
	name, err := create_name(storage)
	if err != nil {
		return
	}
	delete_string(r.name)
	r.name = name
}

letters := "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
numbers := "0123456789"
random_name :: proc() -> string {
	ret := make([]u8, 5)
	for i in 0 ..< 2 {
		k := rand.int_max(len(letters))
		ret[i] = letters[k]
	}
	for i in 2 ..< 5 {
		k := rand.int_max(len(numbers))
		ret[i] = numbers[k]
	}
	return string(ret)
}

create_name :: proc(storage: ^RobotStorage) -> (string, Error) {
	max_tries := 100
	for _ in 0 ..< max_tries {
		key := random_name()
		if key in storage.names {
			delete(key)
			continue
		}
		storage.names[key] = true
		return key, nil
	}
	return "", Error.CouldNotCreateName
}
