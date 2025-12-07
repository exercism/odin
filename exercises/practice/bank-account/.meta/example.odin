package bank_account

import "core:sync"

TransactionResult :: enum {
	Success,
	Account_Not_Open,
	Account_Already_Open,
	Invalid_Amount,
	Not_Enough_Balance,
}

Account :: struct {
	balance:     u32,
	account_mtx: sync.Mutex,
	is_open:     bool,
}

open :: proc(self: ^Account) -> TransactionResult {
	sync.mutex_lock(&self.account_mtx)
	defer sync.mutex_unlock(&self.account_mtx)
	if self.is_open {
		return .Account_Already_Open
	}
	self.is_open = true
	self.balance = 0
	return .Success
}

close :: proc(self: ^Account) -> TransactionResult {
	sync.mutex_lock(&self.account_mtx)
	defer sync.mutex_unlock(&self.account_mtx)
	if !self.is_open {
		return .Account_Not_Open
	}
	self.is_open = false
	return .Success
}

read_balance :: proc(self: ^Account) -> (u32, TransactionResult) {
	sync.mutex_lock(&self.account_mtx)
	defer sync.mutex_unlock(&self.account_mtx)
	if !self.is_open {
		return 0, .Account_Not_Open
	}
	return self.balance, .Success
}

deposit :: proc(self: ^Account, amount: u32) -> TransactionResult {
	if amount == 0 {
		return .Invalid_Amount
	}
	sync.mutex_lock(&self.account_mtx)
	defer sync.mutex_unlock(&self.account_mtx)
	if !self.is_open {
		return .Account_Not_Open
	}
	self.balance += amount
	return .Success
}

withdraw :: proc(self: ^Account, amount: u32) -> TransactionResult {
	if amount == 0 {
		return .Invalid_Amount
	}
	sync.mutex_lock(&self.account_mtx)
	defer sync.mutex_unlock(&self.account_mtx)
	if !self.is_open {
		return .Account_Not_Open
	}
	if self.balance >= amount {
		self.balance -= amount
		return .Success
	}
	return .Not_Enough_Balance
}
