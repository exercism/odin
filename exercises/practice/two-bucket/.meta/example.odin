package two_bucket

import "core:math"

Bucket :: struct {
	name:   string,
	size:   int,
	amount: int,
}

Result :: struct {
	moves:       int,
	goalBucket:  string,
	otherBucket: int,
}

measure :: proc(
	bucketOne: int,
	bucketTwo: int,
	goal: int,
	startBucket: string,
) -> (
	result: Result,
	valid: bool,
) {
	if !isValid(bucketOne, bucketTwo, goal) {
		valid = false
		return
	}
	valid = true

	b1 := Bucket{"one", bucketOne, 0}
	b2 := Bucket{"two", bucketTwo, 0}

	if startBucket == "one" {
		result = go_measure(&b1, &b2, goal)
	} else {
		result = go_measure(&b2, &b1, goal)
	}
	return
}

isValid :: proc(bucketOne: int, bucketTwo: int, goal: int) -> bool {
	if goal > max(bucketOne, bucketTwo) {
		return false
	}

	g := math.gcd(bucketOne, bucketTwo)

	if g > 1 && goal % g != 0 {
		return false
	}

	return true
}

go_measure :: proc(
	start: ^Bucket,
	other: ^Bucket,
	goal: int,
) -> (
	result: Result,
) {
	moves := 0

	fill(start)
	moves += 1

	if other.size == goal && start.size != goal {
		fill(other)
		moves += 1
	}

	for true {
		if start.amount == goal {
			result = Result{moves, start.name, other.amount}
			break
		}
		if other.amount == goal {
			result = Result{moves, other.name, start.amount}
			break
		}

		if isEmpty(start) {
			fill(start)
		} else if isFull(other) {
			empty(other)
		} else {
			pour(from = start, into = other)
		}
		moves += 1
	}
	return result
}

isFull :: proc(bucket: ^Bucket) -> bool {
	return bucket.amount == bucket.size
}

isEmpty :: proc(bucket: ^Bucket) -> bool {
	return bucket.amount == 0
}

fill :: proc(bucket: ^Bucket) {
	bucket.amount = bucket.size
}

empty :: proc(bucket: ^Bucket) {
	bucket.amount = 0
}

pour :: proc(from: ^Bucket, into: ^Bucket) {
	quantity := min(from.amount, into.size - into.amount)
	from.amount -= quantity
	into.amount += quantity
}
