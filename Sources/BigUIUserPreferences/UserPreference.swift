import SwiftUI

/// A property wrapper type that reflects a value from `UserDefaults` and
/// invalidates a view on a change in value in that user default.
///
/// First declare a ``UserPreferenceKey`` type and specify a value for the
/// required ``UserPreferenceKey/defaultValue`` property:
///
/// ```swift
/// private struct MyPreferenceKey: UserPreferenceKey {
///     static let defaultValue: Bool = false
/// }
/// ```
///
/// You then access the value using the property wrapper:
///
/// ```swift
/// @UserPreference(MyPreferenceKey.self) private var myPreference
/// ```
///
/// The Swift compiler automatically infers the associated ``UserPreferenceKey/Value`` type as the
/// type you specify for the default value.
///
/// If the value changes, SwiftUI updates any parts of your view that depend on
/// the value. 
///
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
@frozen @propertyWrapper public struct UserPreference<Key> : DynamicProperty where Key : UserPreferenceKey {
    
    @AppStorage private var value: Key.Value

    public var wrappedValue: Key.Value {
        get {
            value
        }
        nonmutating set {
            value = newValue
        }
    }

    public var projectedValue: Binding<Key.Value> {
        .init {
            wrappedValue
        } set: { newValue in
            wrappedValue = newValue
        }
    }
}

// MARK: - Initialisers

extension UserPreference {
    
    /// Creates a property that can read and write to a boolean user default.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    ///
    public init(_ key: Key.Type, store: UserDefaults? = nil) where Key.Value == Bool {
        self._value = AppStorage(wrappedValue: Key.defaultValue, Key.lookupName, store: store)
    }

    /// Creates a property that can read and write to a string user default.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    ///
    public init(_ key: Key.Type, store: UserDefaults? = nil) where Key.Value == String {
        self._value = AppStorage(wrappedValue: Key.defaultValue, Key.lookupName, store: store)
    }
    
    /// Creates a property that can read and write to a double user default.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    ///
    public init(_ key: Key.Type, store: UserDefaults? = nil) where Key.Value == Double {
        self._value = AppStorage(wrappedValue: Key.defaultValue, Key.lookupName, store: store)
    }
    
    /// Creates a property that can read and write to a integer user default.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    ///
    public init(_ key: Key.Type, store: UserDefaults? = nil) where Key.Value == Int {
        self._value = AppStorage(wrappedValue: Key.defaultValue, Key.lookupName, store: store)
    }
    
    /// Creates a property that can read and write to a url user default.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    ///
    public init(_ key: Key.Type, store: UserDefaults? = nil) where Key.Value == URL {
        self._value = AppStorage(wrappedValue: Key.defaultValue, Key.lookupName, store: store)
    }
    
    /// Creates a property that can read and write to a user default as data.
    ///
    /// Avoid storing large data blobs in user defaults, such as image data,
    /// as it can negatively affect performance of your app. On tvOS, a
    /// `NSUserDefaultsSizeLimitExceededNotification` notification is posted
    /// if the total user default size reaches 512kB.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    ///
    public init(_ key: Key.Type, store: UserDefaults? = nil) where Key.Value == Data {
        self._value = AppStorage(wrappedValue: Key.defaultValue, Key.lookupName, store: store)
    }
    
    /// Creates a property that can read and write to an integer user default,
    /// transforming that to `RawRepresentable` data type.
    ///
    /// A common usage is with enumerations:
    ///
    ///    enum MyEnum: Int {
    ///        case a
    ///        case b
    ///        case c
    ///    }
    ///    struct MyView: View {
    ///        @UserPreference(MyKey.self) private var value
    ///        var body: some View { ... }
    ///    }
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    ///
    public init(_ key: Key.Type, store: UserDefaults? = nil) where Key.Value : RawRepresentable, Key.Value.RawValue == Int {
        self._value = AppStorage(wrappedValue: Key.defaultValue, Key.lookupName, store: store)
    }
    
    /// Creates a property that can read and write to a string user default,
    /// transforming that to `RawRepresentable` data type.
    ///
    /// A common usage is with enumerations:
    ///
    ///    enum MyEnum: String {
    ///        case a
    ///        case b
    ///        case c
    ///    }
    ///    struct MyView: View {
    ///        @UserPreference(MyKey.self) private var value
    ///        var body: some View { ... }
    ///    }
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    ///
    public init(_ key: Key.Type, store: UserDefaults? = nil) where Key.Value : RawRepresentable, Key.Value.RawValue == String {
        self._value = AppStorage(wrappedValue: Key.defaultValue, Key.lookupName, store: store)
    }
}

// MARK: - Optional Initialisers

extension UserPreference where Key.Value : ExpressibleByNilLiteral {
    
    public init(_ key: Key.Type, store: UserDefaults? = nil) where Key.Value == Bool? {
        self._value = AppStorage(Key.lookupName, store: store)
    }

    public init(_ key: Key.Type, store: UserDefaults? = nil) where Key.Value == String? {
        self._value = AppStorage(Key.lookupName, store: store)
    }
    
    public init(_ key: Key.Type, store: UserDefaults? = nil) where Key.Value == Double? {
        self._value = AppStorage(Key.lookupName, store: store)
    }
    
    public init(_ key: Key.Type, store: UserDefaults? = nil) where Key.Value == Int? {
        self._value = AppStorage(Key.lookupName, store: store)
    }
    
    public init(_ key: Key.Type, store: UserDefaults? = nil) where Key.Value == URL? {
        self._value = AppStorage(Key.lookupName, store: store)
    }
    
    public init(_ key: Key.Type, store: UserDefaults? = nil) where Key.Value == Data? {
        self._value = AppStorage(Key.lookupName, store: store)
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension UserPreference {
    
    public init<R>(_ key: Key.Type, store: UserDefaults? = nil) where Key.Value == R?, R : RawRepresentable, R.RawValue == String {
        self._value = AppStorage(Key.lookupName, store: store)
    }
    
    public init<R>(_ key: Key.Type, store: UserDefaults? = nil) where Key.Value == R?, R : RawRepresentable, R.RawValue == Int {
        self._value = AppStorage(Key.lookupName, store: store)
    }
}
