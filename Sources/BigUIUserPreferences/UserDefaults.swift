import Foundation

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension UserDefaults {
    
    public subscript<K>(key: K.Type) -> K.Value where K : UserPreferenceKey, K.Value == Bool {
        get {
            // UserDefaults will return false if no entry, so check for nil instead
            if object(forKey: K.lookupName) == nil {
                return K.defaultValue
            }
            return bool(forKey: K.lookupName)
        }
        set {
            set(newValue, forKey: K.lookupName)
        }
    }
    
    public subscript<K>(key: K.Type) -> K.Value where K : UserPreferenceKey, K.Value == String {
        get {
            string(forKey: K.lookupName) ?? K.defaultValue
        }
        set {
            set(newValue, forKey: K.lookupName)
        }
    }

    public subscript<K>(key: K.Type) -> K.Value where K : UserPreferenceKey, K.Value == URL {
        get {
            url(forKey: K.lookupName) ?? K.defaultValue
        }
        set {
            set(newValue, forKey: K.lookupName)
        }
    }

    public subscript<K>(key: K.Type) -> K.Value where K : UserPreferenceKey, K.Value == Data {
        get {
            data(forKey: K.lookupName) ?? K.defaultValue
        }
        set {
            set(newValue, forKey: K.lookupName)
        }
    }
    
    public subscript<K>(key: K.Type) -> K.Value where K : UserPreferenceKey, K.Value == Int {
        get {
            // UserDefaults will return 0 if no entry, so check for nil instead
            if object(forKey: K.lookupName) == nil {
                return K.defaultValue
            }
            return integer(forKey: K.lookupName)
        }
        set {
            set(newValue, forKey: K.lookupName)
        }
    }

    public subscript<K>(key: K.Type) -> K.Value where K : UserPreferenceKey, K.Value == Double {
        get {
            if object(forKey: K.lookupName) == nil {
                return K.defaultValue
            }
            return double(forKey: K.lookupName)
        }
        set {
            set(newValue, forKey: K.lookupName)
        }
    }
}

// MARK: - Optionals 

extension UserDefaults {
    
    public subscript<K>(key: K.Type) -> K.Value where K : UserPreferenceKey, K.Value == Bool? {
        get {
            if object(forKey: K.lookupName) == nil {
                return K.defaultValue
            }
            return bool(forKey: K.lookupName)
        }
        set {
            set(newValue, forKey: K.lookupName)
        }
    }
    
    public subscript<K>(key: K.Type) -> K.Value where K : UserPreferenceKey, K.Value == String? {
        get {
            string(forKey: K.lookupName)
        }
        set {
            set(newValue, forKey: K.lookupName)
        }
    }
    
    public subscript<K>(key: K.Type) -> K.Value where K : UserPreferenceKey, K.Value == Data? {
        get {
            data(forKey: K.lookupName)
        }
        set {
            set(newValue, forKey: K.lookupName)
        }
    }
    
    public subscript<K>(key: K.Type) -> K.Value where K : UserPreferenceKey, K.Value == URL? {
        get {
            url(forKey: K.lookupName)
        }
        set {
            set(newValue, forKey: K.lookupName)
        }
    }
    
    public subscript<K>(key: K.Type) -> K.Value where K : UserPreferenceKey, K.Value == Int? {
        get {
            if object(forKey: K.lookupName) == nil {
                return K.defaultValue
            }
            return integer(forKey: K.lookupName)
        }
        set {
            set(newValue, forKey: K.lookupName)
        }
    }
    
    public subscript<K>(key: K.Type) -> K.Value where K : UserPreferenceKey, K.Value == Double? {
        get {
            if object(forKey: K.lookupName) == nil {
                return K.defaultValue
            }
            return double(forKey: K.lookupName)
        }
        set {
            set(newValue, forKey: K.lookupName)
        }
    }
}

// MARK: - RawRepresentable

extension UserDefaults {
    
    public subscript<K>(key: K.Type) -> K.Value where K : UserPreferenceKey, K.Value : RawRepresentable, K.Value.RawValue == Int {
        get {
            guard let rawValue = object(forKey: K.lookupName) as? Int else {
                return K.defaultValue
            }
            return K.Value(rawValue: rawValue) ?? K.defaultValue
        }
        set {
            set(newValue.rawValue, forKey: K.lookupName)
        }
    }
    
    public subscript<K>(key: K.Type) -> K.Value where K : UserPreferenceKey, K.Value : RawRepresentable, K.Value.RawValue == String {
        get {
            guard let rawValue = object(forKey: K.lookupName) as? String else {
                return K.defaultValue
            }
            return K.Value(rawValue: rawValue) ?? K.defaultValue
        }
        set {
            set(newValue.rawValue, forKey: K.lookupName)
        }
    }
}

// MARK: - Date

extension UserDefaults {
    
    public subscript<K>(key: K.Type) -> K.Value where K : UserPreferenceKey, K.Value == Date? {
        get {
            guard let rawValue = object(forKey: K.lookupName) as? String else {
                return K.defaultValue
            }
            return Date(rawValue: rawValue)
        }
        set {
            if let newValue {
                set(newValue.rawValue, forKey: K.lookupName)
            } else {
                removeObject(forKey: K.lookupName)
            }
        }
    }
}
