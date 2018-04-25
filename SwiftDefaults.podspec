#
# Be sure to run `pod lib lint SwiftDefaults.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SwiftDefaults"
  s.version          = "0.1.6"
  s.summary          = "SwiftDefaults provides accessing to NSUserDefaults using property."
  s.description      = <<-DESC
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
                       DESC
  s.homepage         = "https://github.com/shimesaba9/SwiftDefaults"
  s.license          = 'MIT'
  s.author           = { "shimesaba9" => "hshs012@gmail.com" }
  s.source           = { :git => "https://github.com/shimesaba9/SwiftDefaults.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/shimesaba43'
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.swift_version = '4.1'
  s.source_files = 'Pod/Classes/**/*'
end
