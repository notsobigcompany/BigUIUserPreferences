import Foundation

/// A wrapper for storing `Codable` values.
///
/// First create a key that wraps the value you wish to store:
///
/// ```swift
/// struct User: Codable, Equatable {
///     let username: String
///     let login: Date?
/// }
///
/// struct LoggedInUserKey: UserPreferenceKey {
///     static var defaultValue: CodablePreferenceValue<User?> = .init()
/// }
/// ```
///
/// You can then access the underlying value by calling ``wrappedValue``:
///
/// ```swift
/// @UserPreference(LoggedInUserKey.self) private var user
/// 
/// var body: some View {
///     if let user = user.wrappedValue {
///         Text("Hello \(user.username)")
///     }
/// }
/// ```
///
public struct CodablePreferenceValue<Value>: Codable where Value : Codable {
    
    public var wrappedValue: Value?
    
    public init(_ wrappedValue: Value? = nil) {
        self.wrappedValue = wrappedValue
    }
}

extension CodablePreferenceValue: RawRepresentable {
    
    public typealias RawValue = String
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self.wrappedValue),
              let json = String(data: data, encoding: .utf8) else {
            return .init()
        }
        return json
    }
    
    public init?(rawValue: String) {
        let data = Data(rawValue.utf8)
        guard let value = try? JSONDecoder().decode(
            Value.self,
            from: data
        ) else {
            return nil
        }
        self = CodablePreferenceValue(value)
    }
}
