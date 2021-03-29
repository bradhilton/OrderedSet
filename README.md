# OrderedSet

`OrderedSet` is a native Swift ordered set. It has the behavior and features of `Array` and `Set` in one abstract type.
```swift
var names: OrderedSet<String> = ["Brad", "Jake", "Susan"]
names += ["Janice", "Brad"] // ["Jake", "Susan", "Janice", "Brad"]
names.subtractInPlace(["Jake", "Janice"]) // ["Susan", "Brad"]
names.insert("Robert", atIndex: 1) // ["Susan", "Robert", "Brad"]
names.contains("Susan") // true
names.isSupersetOf(["Susan", "Jake"]) // false
```

## Installation

### Swift Package Manager
You can build `OrderedSet` using the [Swift Package Manager](https://github.com/apple/swift-package-manager). Just include `OrderedSet` as a package in your dependencies:
```
.Package(url: "https://github.com/bradhilton/OrderedSet.git", majorVersion: 1)
```
Be sure to import the module at the top of your .swift files:
```swift
import OrderedSet
```

### CocoaPods

`OrderedSet` is available through [CocoaPods](http://cocoapods.org). To install, simply include the following lines in your podfile:
```ruby
use_frameworks!
pod 'SwiftOrderedSet'
```
Be sure to import the module at the top of your .swift files:
```swift
import SwiftOrderedSet
```
### Carthage
`OrderedSet` is available through [Carthage](https://github.com/Carthage/Carthage). Just add the following to your cartfile:
```
github "bradhilton/OrderedSet"
```
Be sure to import the module at the top of your .swift files:
```swift
import OrderedSet
```

## Author

Brad Hilton, brad.hilton.nw@gmail.com

## License

`OrderedSet` is available under the MIT license. See the LICENSE file for more info.
