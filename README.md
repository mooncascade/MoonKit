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

The package contains targets: `Moonlight`, `MoonFoundation` and `MoonPresentation`.

### Moonlight

`Moonlight` is a unidirectional flow architecture based on and inspired by The Elm Architecture's ideas.

```swift
// MARK: Assembly

import Combine
import Moonlight
import UIKit

// If the Scene isn't supposed to return a value
public enum ParentScene {
    
    public static func create(
        in window: UIWindow,
        dependency1: @escaping () -> AnyPublisher<Int, Never>,
        dependency2: @escaping () -> AnyPublisher<String, Never>
    ) {

        let env = SceneEnvironment(
            dependency1: dependency1,
            dependency2: dependency2
        )
        
        let vc = ViewController()
        
        Moonlight.start(
            initialState: SceneState(),
            environment: env,
            feedback: vc.bind,
            transform: SceneReducer.transform,
            apply: SceneReducer.apply
        ).store(in: &vc.subscriptions)
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}

// If the Scene is supposed to return some value.
public enum ChildScene {
    
    public static func create(
        in window: UIWindow,
        dependency1: @escaping () -> AnyPublisher<Int, Never>,
        dependency2: @escaping () -> AnyPublisher<String, Never>
    ) {

        let env = SceneEnvironment(
            dependency1: dependency1,
            dependency2: dependency2
        )
        
        let vc = ViewController()
        
        return Moonlight.start(
            initialState: SceneState(),
            environment: env,
            feedback: vc.bind,
            transform: SceneReducer.transform,
            apply: SceneReducer.apply,
            store: vc.store
        )
        .compactMap(\.result)
        .handleEvents(receiveOutput: { [vc] _ in vc.dismiss(animated: true) })
        .eraseToAnyPublisher()
    }
}


// MARK: Reducer

enum SceneReducer {
    static func transform(
        state: SceneState,
        event: SceneEvent,
        env: SceneEnvironment
    ) -> AnyPublisher<SceneEffect, Never> {
        switch event {
        case .userDidRequestEvent1:
            return env.dependency1()
                .print("dependency1")
                .map(SceneEffect.numberDidRecieve)
                .eraseToAnyPublisher()
            
        case .userDidRequestEvent2:
            return env.dependency2()
                .print("dependency2")
                .map(SceneEffect.stringDidRecieve)
                .eraseToAnyPublisher()
        }
    }

    static func apply(
        state: SceneState,
        effect: SceneEffect
    ) -> SceneState {
        var history = state.history
        
        switch effect {
        case let .numberDidRecieve(value):
            history.append("Number: \(value)")
            
        case let .stringDidRecieve(value):
            history.append("String: \(value)")
        }
        
        history = history.suffix(10)
        
        return .init(history: history)
    }
}

// MARK: System 

struct SceneEnvironment {
    let dependency1: () -> AnyPublisher<Int, Never>
    let dependency2: () -> AnyPublisher<String, Never>
}

struct SceneState: Equatable {
    var history: [String] = []
}

enum SceneEvent {
    case userDidRequestEvent1
    case userDidRequestEvent2
}

enum SceneEffect {
    case numberDidRecieve(Int)
    case stringDidRecieve(String)
}

// MARK: View Controller

final class ViewController: UIViewController {

    var subscriptions = Set<AnyCancellable>()

    private let label = UILabel()
    private let button1 = UIButton(type: .system)
    private let button2 = UIButton(type: .system)
    
    private let eventSubject = PassthroughSubject<SceneEvent, Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func bind(state: AnyPublisher<SceneState, Never>) -> AnyPublisher<SceneEvent, Never> {
        state
            .print("bind")
            .sink(receiveValue: { [label] in label.text = $0.history.joined(separator: "\n") })
            .store(in: &subscriptions)
        
        return eventSubject.eraseToAnyPublisher()
    }
    
    private func setup() {
        view.backgroundColor = .systemBackground
        
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        
        button1.setTitle("Button 1", for: .normal)
        button1.addTarget(self, action: #selector(button1DidTap), for: .touchUpInside)
        
        button2.setTitle("Button 2", for: .normal)
        button2.addTarget(self, action: #selector(button2DidTap), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [label, button1, button2])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 24
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button1.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc
    private func button1DidTap() {
        eventSubject.send(.userDidRequestEvent1)
    }
    
    @objc
    private func button2DidTap() {
        eventSubject.send(.userDidRequestEvent2)
    }
}
``` 

### Moonlight Unit-testing

The target contains everything needed for Unit-testing in case if you use Moonlight architecture.
```swift
import Combine
import MoonlightTests
import XCTest
@testable import MainScene

final class MainSceneTestCase: XCTestCase, MoonlightTestCase {
    typealias State = SceneState
    typealias Event = SceneEvent
    typealias Effect = SceneEffect
    typealias Environment = SceneEnvironment

    var environment: SceneEnvironment { .init(getRandomNumber: { Just(5).eraseToAnyPublisher() }) }
    var transform: (SceneState, SceneEvent, SceneEnvironment) -> AnyPublisher<SceneEffect, Never> { SceneReducer.transform }
    var apply: (SceneState, SceneEffect) -> SceneState { SceneReducer.apply }
    var cancellables = Set<AnyCancellable>()
    
    func test_userDidRequestIncrease() {
        TestMoonlight(
            event: .userDidRequestIncrease,
            initialState: .init(currentValue: 2, counter: 2),
            expectedState: .init(currentValue: 7, counter: 3)
        )
    }

    func test_userDidRequestDecrease() {
        TestMoonlight(
            event: .userDidRequestDecrease,
            initialState: .init(currentValue: 23, counter: 2),
            expectedState: .init(currentValue: 18, counter: 3)
        )
    }

    func test_userDidRequestIncrease_twice() {
        TestMoonlight(
            events: [.userDidRequestIncrease, .userDidRequestIncrease],
            initialState: .init(currentValue: 2, counter: 2),
            expectedState: .init(currentValue: 12, counter: 4)
        )
    }
}
``` 

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

## Conventions

- Swift files carrying extension methods should be named in the next format `%Entity%+Extensions.swift`, for example `UIView+Extensions.swift`

## License

Moonkit is under the [MIT License](LICENSE.md).

## About

`MoonKit` is maintained and funded by Mooncascade OÜ: https://mooncascade.com 
