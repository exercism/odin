package robotname

import "core:math/rand"

Robot_Storage :: struct {
	names: map[string]bool,
}

Robot :: struct {
	name: string,
}

Error :: enum {
	Could_Not_Create_Name,
}

make_storage :: proc() -> Robot_Storage {
	return Robot_Storage{make(map[string]bool)}
}

delete_storage :: proc(storage: ^Robot_Storage) {
	for k in storage.names {
		delete(k)
	}
	delete(storage.names)
}

new_robot :: proc(storage: ^Robot_Storage) -> (Robot, Error) {
	name, e := create_name(storage)
	return Robot{name}, e
}

reset :: proc(storage: ^Robot_Storage, r: ^Robot) {
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
	name := make([]u8, 5)
	for i in 0 ..< 2 {
		k := rand.int_max(len(letters))
		name[i] = letters[k]
	}
	for i in 2 ..< 5 {
		k := rand.int_max(len(numbers))
		name[i] = numbers[k]
	}
	return string(name)
}

create_name :: proc(storage: ^Robot_Storage) -> (string, Error) {
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
	return "", Error.Could_Not_Create_Name
}
