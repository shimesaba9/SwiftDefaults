# SwiftDefaults

[![CI Status](http://img.shields.io/travis/shimesaba9/SwiftDefaults.svg?style=flat)](https://travis-ci.org/shimesaba9/SwiftDefaults)
[![Version](https://img.shields.io/cocoapods/v/SwiftDefaults.svg?style=flat)](http://cocoapods.org/pods/SwiftDefaults)
[![License](https://img.shields.io/cocoapods/l/SwiftDefaults.svg?style=flat)](http://cocoapods.org/pods/SwiftDefaults)
[![Platform](https://img.shields.io/cocoapods/p/SwiftDefaults.svg?style=flat)](http://cocoapods.org/pods/SwiftDefaults)

## Description

SwiftDefaults provides accessing to NSUserDefaults using property.

```swift
import SwiftDefaults

class MyDefaults: SwiftDefaults {
    dynamic var value: String? = "10"
    dynamic var value2: String = "10"
    dynamic var value3: Int = 1
}

print(MyDefaults().value) // "10"
print(MyDefaults().value2) // "10"
MyDefaults().value2 = "2"
print(MyDefaults().value2) // "2"
```

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

SwiftDefaults is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftDefaults"
```

## Author

shimesaba9, [@shimesaba43](https://twitter.com/shimesaba43)

## License

SwiftDefaults is available under the MIT license. See the LICENSE file for more info.
