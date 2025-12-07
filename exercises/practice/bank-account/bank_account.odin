package bank_account

TransactionResult :: enum {
	Success,
	Account_Not_Open,
	Account_Already_Open,
	Invalid_Amount,
	Not_Enough_Balance,
	Unimplemented,
}

Account :: struct {} // Implement this struct

open :: proc(self: ^Account) -> TransactionResult {
	// Implement this procedure.
	return .Unimplemented
}

close :: proc(self: ^Account) -> TransactionResult {
	// Implement this procedure.
	return .Unimplemented
}

read_balance :: proc(self: ^Account) -> (u32, TransactionResult) {
	// Implement this procedure.
	return 0, .Unimplemented
}

deposit :: proc(self: ^Account, amount: u32) -> TransactionResult {
	// Implement this procedure.
	return .Unimplemented
}

withdraw :: proc(self: ^Account, amount: u32) -> TransactionResult {
	// Implement this procedure.
	return .Unimplemented
}
