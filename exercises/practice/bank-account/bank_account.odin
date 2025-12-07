package bank_account

TransactionResult :: enum {
	Success,
	Account_Not_Open,
	Account_Already_Open,
	Invalid_Amount,
	Not_Enough_Balance,
}

Account :: struct {
} // Implement this struct

open :: proc(self: ^Account) -> TransactionResult {
	// Implement this procedure.
	return .Success
}

close :: proc(self: ^Account) -> TransactionResult {
	// Implement this procedure.
	return .Success
}

read_balance :: proc(self: ^Account) -> (u32, TransactionResult) {
	// Implement this procedure.
	return 0, .Success
}

deposit :: proc(self: ^Account, amount: u32) -> TransactionResult {
	// Implement this procedure.
	return .Success
}

withdraw :: proc(self: ^Account, amount: u32) -> TransactionResult {
	// Implement this procedure.
	return .Success
}
