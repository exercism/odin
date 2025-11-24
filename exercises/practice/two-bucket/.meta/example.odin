package two_bucket

import "core:math"

Bucket :: struct {
	name:   string,
	size:   int,
	amount: int,
}

Result :: struct {
	moves:        int,
	goal_bucket:  string,
	other_bucket: int,
}

measure :: proc(
	bucket_one: int,
	bucket_two: int,
	goal: int,
	start_bucket: string,
) -> (
	result: Result,
	valid: bool,
) {
	if !isValid(bucket_one, bucket_two, goal) {
		valid = false
		return
	}
	valid = true

	b1 := Bucket{"one", bucket_one, 0}
	b2 := Bucket{"two", bucket_two, 0}

	if start_bucket == "one" {
		result = go_measure(&b1, &b2, goal)
	} else {
		result = go_measure(&b2, &b1, goal)
	}
	return
}

isValid :: proc(bucket_one: int, bucket_two: int, goal: int) -> bool {
	if goal > max(bucket_one, bucket_two) {
		return false
	}

	gcd := math.gcd(bucket_one, bucket_two)

	if gcd > 1 && goal % gcd != 0 {
		return false
	}

	return true
}

go_measure :: proc(start: ^Bucket, other: ^Bucket, goal: int) -> (result: Result) {
	moves := 0

	fill(start)
	moves += 1

	if other.size == goal && start.size != goal {
		fill(other)
		moves += 1
	}

	for {
		if start.amount == goal {
			result = Result{moves, start.name, other.amount}
			return
		}
		if other.amount == goal {
			result = Result{moves, other.name, start.amount}
			return
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
	return
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
