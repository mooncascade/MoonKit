# MoonKit

The place where we can collect, improve and reuse our best practises and other necessary stuff.
The package contains a set of extensions and additional tools which could be usuful for iOS development.  

## Installation

### Swift Package Manager

Add the following dependency to your **Package.swift** file:

```swift
.package(url: "https://github.com/mooncascade/MoonKit.git", from: "0.0.1")
```

### Minimal Requirements

* iOS 13
* Swift 5.5
* Xcode: 13.2.1

## Usage

The package contains two targets: `MoonFoundation` and `MoonPresentation`.

### MoonFoundation

The target mostly contains a set of usuful extensions of `Foundation`:

```swift
import MoonFoundation

let array = [1, 2, 3]
let currentValue = 2
let nextValue = array.next(after: currentValue) // Optional(3)
let previousValue = array.previous(before: currentValue) // Optional (1)
``` 

### MoonPresentation

The target contains a set of extensions of `UIKit` as well as our laconic syntax wrapper for constrainting layout:

```swift
import MoonPresentation

    // ...
    
    private func layout() {
        [tableView, bottomView].forEach(addSubview)
        tableView.constrain(.all(except: .bottom), to: self)
        tableView.constrain(.bottom, to: bottomView, edge: .top)
        bottomView.constrain(.all(except: .top), to: self)
    }

```

## License

Moonkit is under the [MIT License](LICENSE.md).

## About

`MoonKit` is maintained and funded by Mooncascade OÜ: https://mooncascade.com 
