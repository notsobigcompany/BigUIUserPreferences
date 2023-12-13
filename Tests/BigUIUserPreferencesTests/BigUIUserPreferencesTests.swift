import XCTest
import SwiftUI
import Foundation
@testable import BigUIUserPreferences

// MARK: - Test Keys

struct MyPreferenceKey: UserPreferenceKey {
    static let defaultValue: Bool = false
}

struct MyOptionalPreferenceKey: UserPreferenceKey {
    static var defaultValue: String? = nil
}

struct MyOptionalIntegerPreferenceKey: UserPreferenceKey {
    static var defaultValue: Int? = nil
}

struct MyDatePreferenceKey: UserPreferenceKey {
    static var defaultValue: Date? = Date()
}

enum TestEnum: Int {
    case one
    case two
    case three
}

struct MyEnumPreferenceKey: UserPreferenceKey {
    static var defaultValue: TestEnum = .one
}

struct MyExplicitPreferenceKey: ExplicitlyNamedUserPreferenceKey {
    static let defaultValue: Bool = false
    static let name: String = "my_explicit_key"
}

// MARK: - Codable

struct User: Codable, Equatable {
    let username: String
    let login: Date?
}

struct LoggedInUserKey: UserPreferenceKey {
    static var defaultValue: CodablePreferenceValue<User?> = .init()
}

// MARK: - Tests

@available(iOS 15.0, *)
final class BigUIUserPreferencesTests: XCTestCase {
    
    @UserPreference(MyPreferenceKey.self) private var myPreference
        
    @UserPreference(MyEnumPreferenceKey.self) private var myEnumPreference
    
    @UserPreference(MyDatePreferenceKey.self) private var myDate
    
    @UserPreference(LoggedInUserKey.self) private var user
    
    func testWrapperDefaultValue() {
        XCTAssertEqual(myPreference, false)
    }
    
    func testBool() {
        let defaults = UserDefaults(suiteName: UUID().uuidString)!
        
        // Test default value
        let myDefaultValue = defaults[MyPreferenceKey.self]
        XCTAssertEqual(myDefaultValue, MyPreferenceKey.defaultValue)
        
        // Test set value
        defaults[MyPreferenceKey.self] = true
        let myValue = defaults[MyPreferenceKey.self]
        XCTAssertEqual(myValue, true)
    }
    
    func testOptionalString() {
        let defaults = UserDefaults(suiteName: UUID().uuidString)!
        
        // Test nil value
        let myString = defaults[MyOptionalPreferenceKey.self]
        XCTAssertNil(myString)
        
        // Test set value
        defaults[MyOptionalPreferenceKey.self] = "Hello World"
        let myOptionalString = defaults[MyOptionalPreferenceKey.self]
        XCTAssertEqual(myOptionalString, "Hello World")
    }
    
    func testOptionalIntNotZero() {
        let defaults = UserDefaults(suiteName: UUID().uuidString)!
        
        // Test nil isn't 0 (UserDefaults default)
        let value = defaults[MyOptionalIntegerPreferenceKey.self]
        XCTAssertEqual(value, nil)
        
        // Test we can still use 0
        defaults[MyOptionalIntegerPreferenceKey.self] = 0
        XCTAssertEqual(defaults[MyOptionalIntegerPreferenceKey.self], 0)
    }
    
    func testEnum() {
        // Check default value
        XCTAssertEqual(myEnumPreference, .one)
        
        // Check subscript
        let defaults = UserDefaults(suiteName: UUID().uuidString)!
        defaults[MyEnumPreferenceKey.self] = .three
        XCTAssertEqual(defaults[MyEnumPreferenceKey.self], .three)
    }
    
    func testDate() {
        let defaults = UserDefaults(suiteName: UUID().uuidString)!
        let expected = Date.now
        defaults[MyDatePreferenceKey.self] = expected
        XCTAssertEqual(defaults[MyDatePreferenceKey.self], expected)
    }
    
    func testCodable() {
        let defaults = UserDefaults(suiteName: UUID().uuidString)!
        let expected = User(username: "demo", login: .now)
        defaults[LoggedInUserKey.self] = CodablePreferenceValue(expected)
        let value = defaults[LoggedInUserKey.self]
        XCTAssertEqual(expected, value.wrappedValue)
    }
    
    func testMultipleKeyNames() {
        let defaults = UserDefaults(suiteName: UUID().uuidString)!
        defaults[MyPreferenceKey.self] = true
        defaults[MyOptionalPreferenceKey.self] = "test"
        
        XCTAssertEqual(defaults[MyPreferenceKey.self], true)
        XCTAssertEqual(defaults[MyOptionalPreferenceKey.self], "test")
    }
    
    func testExplicitKeyName() {
        let defaults = UserDefaults(suiteName: UUID().uuidString)!
        defaults[MyExplicitPreferenceKey.self] = true
        XCTAssertEqual(defaults[MyExplicitPreferenceKey.self], true)
        XCTAssertEqual(MyExplicitPreferenceKey.lookupName, "my_explicit_key")
    }
}
