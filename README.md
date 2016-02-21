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

`OrderedSet` is available through [CocoaPods](http://cocoapods.org). To install, simply include the following lines in your podfile:
```ruby
use_frameworks!
pod 'OrderedSet'
```
Be sure to import the module at the top of your .swift files:
```swift
import OrderedSet
```
Alternatively, clone this repo or download it as a zip and include the classes in your project.

## Author

Brad Hilton, brad@skyvive.com

## License

`OrderedSet` is available under the MIT license. See the LICENSE file for more info.
