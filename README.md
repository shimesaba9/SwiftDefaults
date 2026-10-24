# SwiftDefaults

## Description

SwiftDefaults provides accessing to NSUserDefaults using property.

```swift
import SwiftDefaults

class MyDefaults: SwiftDefaults {
    dynamic var value: String? = "10"
    dynamic var value2: String = "10"
    dynamic var value3: Int = 1
    dynamic var value4: Person? = nil
}

print(MyDefaults().value2)
MyDefaults().value2 = "2"
print(MyDefaults().value2)

print("Stored person instance: \(MyDefaults().value4)")
let p = Person()
p.firstName = "Elvis"
p.lastName = "Presley"
p.age = 42
MyDefaults().value4 = p
print("Stored person instance: \(MyDefaults().value4)")
MyDefaults().value4 = nil
print("Stored nil person: \(MyDefaults().value4)")
```

## Installation

SwiftDefaults supports Swift Package Manager. CocoaPods support has ended.

In Xcode, select **File > Add Package Dependencies** and enter:

```
https://github.com/shimesaba9/SwiftDefaults.git
```

Select a revision that includes `Package.swift` with the current source layout, then add the `SwiftDefaults` product to your target.

For a Swift package, add the repository to `dependencies` and the `SwiftDefaults` product to your target's dependencies. Use Swift 5.9 or later. Supported platforms are iOS 14 or later and macOS 10.15 or later.

## Development

Open `Package.swift` in Xcode to edit or build the library. To build it from the command line, run:

```sh
swift build
```

To run the iOS example, open `Example/SwiftDefaults.xcodeproj` and select the `SwiftDefaults_Example` scheme. The example references the package in the parent directory, so no dependency installation is required.

## Author

shimesaba9, [@shimesaba43](https://twitter.com/shimesaba43)

## License

SwiftDefaults is available under the MIT license. See the LICENSE file for more info.
