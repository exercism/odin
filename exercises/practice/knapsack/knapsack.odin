package knapsack

Item :: struct {
	weight: u32,
	value:  u32,
}

maximum_value :: proc(maximum_weight: u32, items: []Item) -> u32 {
	#panic("Please implement the `maximum_value` procedure")
}
