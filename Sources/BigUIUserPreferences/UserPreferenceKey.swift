import SwiftUI

/// A key for accessing user default values in the environment.
///
/// First declare a new preference key type and specify a value for the
/// required ``defaultValue`` property:
///
/// ```swift
/// private struct MyPreferenceKey: UserPreferenceKey {
///     static let defaultValue: Bool = false
/// }
/// ```
///
/// You then access the value using the ``UserPreference`` property
/// wrapper:
///
/// ```swift
/// @UserPreference(MyPreferenceKey.self) private var myPreference
/// ```
///
/// The Swift compiler automatically infers the associated ``Value`` type as the
/// type you specify for the default value.
///
public protocol UserPreferenceKey {
    
    /// The associated type representing the type of the preference key's  value.
    associatedtype Value
    
    /// The default value for the preference key.
    static var defaultValue: Value { get }
    
}

/// A key for accessing user default values with an explicit key name.
///
/// By default `UserPreferenceKey` uses an auto-generated key name to lookup values
/// inside the store. If you wish to use an explicit key name instead (say, to support
/// pre-existing values) adopt `ExplicitlyNamedUserPreferenceKey` and return a ``name``:
///
/// ```swift
/// struct MyExplicitPreferenceKey: ExplicitlyNamedUserPreferenceKey {
///     static let defaultValue: Bool = false
///     // The name of the value inside the store
///     static let name: String = "my_explicit_key"
/// }
/// ```
public protocol ExplicitlyNamedUserPreferenceKey: UserPreferenceKey {
    
    /// The key name in the user defaults store.
    static var name: String { get }
    
}

// MARK: - Key Name Lookup

extension UserPreferenceKey {
    
    static var lookupName: String {
        if let explicit = self as? any ExplicitlyNamedUserPreferenceKey.Type {
            return explicit.name
        }
        if let mangled = _mangledTypeName(type(of: self)) {
            return mangled
        }
        fatalError("Unable to resolve key name for \(Self.self)")
    }
}

