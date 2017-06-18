import XCTest
@testable import Balance

class BalanceTests: XCTestCase {
    
    var account: Account!
    
    override func setUp() {
        account = BalanceTests.buildAccount()
    }
    
    override func tearDown() {
        account = nil
        super.tearDown()
    }
    
    func test_get_balance_for_new_account_is_zero() {
        let balance = account.getBalance()
        XCTAssertEqual(balance, 0)
    }
    
    func test_deposit_0_throws_exeption() {
        try assert(account.deposit(amount: 0), throwsError: AccountOperationError.amountNotPositive)
    }
    
    func test_deposit_negative_amount_throws_exeption() {
        try assert(account.deposit(amount: -100), throwsError: AccountOperationError.amountNotPositive)
    }
    
    func test_deposit_more_than_max_amount_throws_exeption() {
        XCTAssertThrowsError(try account.deposit(amount: 1000))
    }
    
    func test_deposit_100_in_new_account_results_a_balance_of_100() {
        do {
            try account.deposit(amount: 100)
        } catch {
            XCTFail("Deposit 100 in an empty account should not throw")
        }
        let balance = account.getBalance()
        XCTAssertEqual(balance, 100)
    }
    
    func test_deposit_noninteger_amount() {
        do {
            try account.deposit(amount: 100.5)
        } catch {
            XCTFail("Deposit 100 in an empty account should not throw")
        }
        let balance = account.getBalance()
        XCTAssertEqual(balance, 100.5)
    }
    
    func test_deposit_dollars_result_correct_balance_in_ron() {
        do {
            try account.deposit(amount: 1, currency: .usd)
        } catch {
            XCTFail("Deposit 100 in an empty account should not throw")
        }
        let balance = account.getBalance()
        XCTAssertEqual(balance, 4)
    }
    
    // MARK: - Helper Methods
    
    private func assert<T, E: Error>(_ expression: @autoclosure () throws -> T, throwsError expectedError: E) where E: Equatable {
        do {
            _ = try expression()
            XCTFail("Expected error to be thrown")
        } catch let error as E {
            XCTAssertEqual(error, expectedError)
        } catch {
            XCTFail("Unexpected error type: \(type(of: error))")
        }
    }
    
    private static func buildAccount() -> Account {
        return Account()
    }
}

extension BalanceTests {
    static var allTests = [
        ("test_deposit_0_throws_exeption", test_deposit_0_throws_exeption),
        ("test_deposit_negative_amount_throws_exeption", test_deposit_negative_amount_throws_exeption),
        ("test_deposit_more_than_max_amount_throws_exeption", test_deposit_more_than_max_amount_throws_exeption),
        ("test_get_balance_for_new_account_is_zero", test_get_balance_for_new_account_is_zero),
        ("test_deposit_noninteger_amount", test_deposit_noninteger_amount),
        ("test_deposit_dollars_result_correct_balance_in_ron", test_deposit_dollars_result_correct_balance_in_ron),
        ("test_deposit_100_in_new_account_results_a_balance_of_100", test_deposit_100_in_new_account_results_a_balance_of_100),
    ]
}
