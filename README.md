# BigUIUserPreferences

A strongly typed Swift and SwiftUI wrapper for UserDefaults. 

This package adds two new interfaces for working with `UserDefaults`:

1. A `@UserPreference` property wrapper for SwiftUI views:

```swift 
@UserPreference(MiniSidebarKey.self) private var enabled
```

2. A subscript interface for `UserDefaults`:

```swift
UserDefaults.standard[MiniSidebarKey.self] = true
```

By tightly coupling key names and default values together with `UserPreferenceKey` 
you eliminate the possibility of key typos, differing defaults, and type mismatches.

## Installation

Add this repository to your Package.swift file:

```swift
.package(url: "https://github.com/notsobigcompany/BigUIUserPreferences.git", from: "1.0.0")
```

If you’re adding to an Xcode project go to File -> Add Packages, then link the 
package to your required target.

## Getting Started

First declare a `UserPreferenceKey` type and specify a default value:

```swift
struct MiniSidebarKey: UserPreferenceKey {
    static let defaultValue: Bool = false
}
```

> [!TIP]
> Both `EnvironmentKey` and `UserPreferenceKey` have the exact same type requirements.

### SwiftUI 

You can then access the value inside of a SwiftUI view with the `@UserPreference` 
property wrapper:

```swift 
struct MiniSidebarToggle: View {
    
    @UserPreference(MiniSidebarKey.self) private var enabled
    
    var body: some View {
        Toggle(isOn: $enabled) {
            Text("Enable Minibar")
        }
    }
}
```

The wrapper always reflects the latest value in the `UserDefaults` and 
invalidates the view on any external changes.

### Subscript  

You can also access the value by using the `subscript` interface directly on 
`UserDefaults` itself:

```swift 
let defaults = UserDefaults.standard 
defaults[MiniSidebarToggle.self] = true 

var isMiniBarEnabled = defaults[MiniSidebarToggle.self]
// true
print(isMiniBarEnabled)
```

## Supported Types 

- `String`
- `Int`
- `Double`
- `Data`
- `Date`
- `URL`
- `RawRepresentable` where `RawValue` is `Int` 
- `RawRepresentable` where `RawValue` is `String` 
- `Codable` when wrapped in `CodablePreferenceValue`

## Codable Values 

You can store small `Codable` values by wrapping the value in
`CodablePreferenceValue`: 

```swift
struct User: Codable, Equatable {
    // ...
}

struct LoggedInUserKey: UserPreferenceKey {
    static var defaultValue: CodablePreferenceValue<User?> = .init()
    static var name = "user_info_key"
}
```

You can then access the underlying value by calling `wrappedValue`:

```swift
@UserPreference(LoggedInUserKey.self) private var user

var body: some View {
    if let user = user.wrappedValue {
        Text("Hello \(user.username)")
    }
}
```

## Explicit Key Names

By default `UserPreferenceKey` uses an auto-generated key name to lookup values 
inside the store. If you wish to use an explicit key name instead (say, to support 
pre-existing values) adopt `ExplicitlyNamedUserPreferenceKey` and return a `name`:

```swift
struct MyExplicitPreferenceKey: ExplicitlyNamedUserPreferenceKey {
    static let defaultValue: Bool = false
    // The name of the value inside the store
    static let name: String = "my_explicit_key"
}
```

## Requirements

- iOS 14.0
- macOS 11.0

## License 

Copyright 2023 NOT SO BIG TECH LIMITED

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
