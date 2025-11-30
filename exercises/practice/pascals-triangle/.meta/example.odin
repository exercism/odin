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
