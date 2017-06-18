enum AccountOperationError: Error {
    case amountNotPositive
    case amountTooMuch
}

enum AccountCurrency {
    case usd
    case ron
}

class Account {
    
    var balance: Double = 0
    
    func getBalance() -> Double {
        return balance
    }
    
    func deposit(amount: Double, currency: AccountCurrency = .ron) throws {
        guard amount > 0 else {
            throw AccountOperationError.amountNotPositive
        }
        
        guard amount < 1000.0 else {
            throw AccountOperationError.amountTooMuch
        }
        
        switch currency {
        case .usd:
            balance += amount * 4
        case .ron:
            balance += amount
        }
    }
}
