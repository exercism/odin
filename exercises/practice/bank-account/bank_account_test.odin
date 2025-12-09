package bank_account

import "core:testing"
import "core:thread"

@(test)
/// description = Newly opened account has zero balance
test_newly_opened_account_has_zero_balance :: proc(t: ^testing.T) {
	account: Account
	open(&account)
	amount, _ := read_balance(&account)
	testing.expect_value(t, amount, 0)
}

@(test)
/// description = Single deposit
test_single_deposit :: proc(t: ^testing.T) {
	account: Account
	open(&account)
	deposit(&account, 100)
	amount, _ := read_balance(&account)
	testing.expect_value(t, amount, 100)
}

@(test)
/// description = Multiple deposits
test_multiple_deposits :: proc(t: ^testing.T) {
	account: Account
	open(&account)
	deposit(&account, 100)
	deposit(&account, 50)
	amount, _ := read_balance(&account)
	testing.expect_value(t, amount, 150)
}

@(test)
/// description = Withdraw once
test_withdraw_once :: proc(t: ^testing.T) {
	account: Account
	open(&account)
	deposit(&account, 100)
	withdraw(&account, 75)
	amount, _ := read_balance(&account)
	testing.expect_value(t, amount, 25)
}

@(test)
/// description = Withdraw twice
test_withdraw_twice :: proc(t: ^testing.T) {
	account: Account
	open(&account)
	deposit(&account, 100)
	withdraw(&account, 80)
	withdraw(&account, 20)
	amount, _ := read_balance(&account)
	testing.expect_value(t, amount, 0)
}

@(test)
/// description = Can do multiple operations sequentially
test_can_do_multiple_operations_sequentially :: proc(t: ^testing.T) {
	account: Account
	open(&account)
	deposit(&account, 100)
	deposit(&account, 110)
	withdraw(&account, 200)
	deposit(&account, 60)
	withdraw(&account, 50)
	amount, _ := read_balance(&account)
	testing.expect_value(t, amount, 20)
}

@(test)
/// description = Cannot check balance of closed account
test_cannot_check_balance_of_closed_account :: proc(t: ^testing.T) {
	account: Account
	open(&account)
	close(&account)
	_, result := read_balance(&account)
	testing.expect_value(t, result, TransactionResult.Account_Not_Open)
}

@(test)
/// description = Cannot deposit into closed account
test_cannot_deposit_into_closed_account :: proc(t: ^testing.T) {
	account: Account
	open(&account)
	close(&account)
	result := deposit(&account, 50)
	testing.expect_value(t, result, TransactionResult.Account_Not_Open)
}

@(test)
/// description = Cannot deposit into unopened account
test_cannot_deposit_into_unopened_account :: proc(t: ^testing.T) {
	account: Account
	result := deposit(&account, 50)
	testing.expect_value(t, result, TransactionResult.Account_Not_Open)
}

@(test)
/// description = Cannot withdraw from closed account
test_cannot_withdraw_from_closed_account :: proc(t: ^testing.T) {
	account: Account
	open(&account)
	close(&account)
	result := withdraw(&account, 50)
	testing.expect_value(t, result, TransactionResult.Account_Not_Open)
}

@(test)
/// description = Cannot close an account that was not opened
test_cannot_close_an_account_that_was_not_opened :: proc(t: ^testing.T) {
	account: Account
	result := close(&account)
	testing.expect_value(t, result, TransactionResult.Account_Not_Open)
}

@(test)
/// description = Cannot open an already opened account
test_cannot_open_an_already_opened_account :: proc(t: ^testing.T) {
	account: Account
	open(&account)
	result := open(&account)
	testing.expect_value(t, result, TransactionResult.Account_Already_Open)
}

@(test)
/// description = Reopened account does not retain balance
test_reopened_account_does_not_retain_balance :: proc(t: ^testing.T) {
	account: Account
	open(&account)
	deposit(&account, 50)
	close(&account)
	open(&account)
	amount, _ := read_balance(&account)
	testing.expect_value(t, amount, 0)
}

@(test)
/// description = Cannot withdraw more than deposited
test_cannot_withdraw_more_than_deposited :: proc(t: ^testing.T) {
	account: Account
	open(&account)
	deposit(&account, 25)
	result := withdraw(&account, 50)
	testing.expect_value(t, result, TransactionResult.Not_Enough_Balance)
}

@(test)
/// description = Cannot withdraw zero
test_cannot_withdraw_zero :: proc(t: ^testing.T) {
	account: Account
	open(&account)
	deposit(&account, 100)
	result := withdraw(&account, 0)
	testing.expect_value(t, result, TransactionResult.Invalid_Amount)
}

@(test)
/// description = Cannot deposit zero
test_cannot_deposit_zero :: proc(t: ^testing.T) {
	account: Account
	open(&account)
	result := deposit(&account, 0)
	testing.expect_value(t, result, TransactionResult.Invalid_Amount)
}

@(test)
/// description = Can handle concurrent transactions
test_can_handle_concurrent_transactions :: proc(t: ^testing.T) {
	account: Account
	open(&account)
	N :: 500
	DEPOSIT_PER_THREAD :: 19
	WITHDRAW_PER_THREAD :: 5
	NET_GAIN :: (DEPOSIT_PER_THREAD - WITHDRAW_PER_THREAD) * N
	deposit_then_withdraw :: proc(t: ^thread.Thread) {
		account := (^Account)(t.data)
		deposit(account, DEPOSIT_PER_THREAD)
		withdraw(account, WITHDRAW_PER_THREAD)
	}
	workers := make([]^thread.Thread, N)
	defer delete(workers)
	for &w in workers {
		w = thread.create(deposit_then_withdraw)
		w.data = &account
	}
	defer for w in workers {
		thread.destroy(w)
	}
	for w in workers {
		thread.start(w)
	}
	thread.join_multiple(..workers)
	amount, _ := read_balance(&account)
	testing.expect_value(t, amount, NET_GAIN)
}
