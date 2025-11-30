package pascals_triangle

rows :: proc(count: int) -> (rows: [][]u128) {
	rows = make([][]u128, count)
	for &row, i in rows {
		row = make([]u128, i + 1)
		row[0], row[i] = 1, 1
		if i == 0 {
			continue
		}
		prev := rows[i - 1]
		for j in 1 ..< i {
			row[j] = prev[j] + prev[j - 1]
		}
	}
	return
}

// Extra optimization: build rows inline to have better cache locality
// on AMD Ryzen 9 7900X3D, this code took 3.61s to process 200 times of 2000 rows generation
// unoptimized version took 4.96s to process the same amount of data
rows_fast :: proc(count: int) -> (rows: [][]u128) {
	rows = make([][]u128, count)
	for &row, i in rows {
		row = make([]u128, i + 1)
		row[0], row[i] = 1, 1
		if i == 0 {
			continue
		}
		copy(row[1:], rows[i - 1])
		for j := i; j >= 1; j -= 1 {
			row[j] += row[j - 1]
		}
	}
	return
}
