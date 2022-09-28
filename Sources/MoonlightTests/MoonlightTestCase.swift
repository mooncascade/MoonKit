import Combine
import Moonlight
import XCTest

public protocol MoonlightTestCase: XCTestCase where State: Equatable  {

    associatedtype State
    associatedtype Event
    associatedtype Effect
    associatedtype Environment
    
    var environment: Environment { get }

    var transform: (State, Event, Environment) -> AnyPublisher<Effect, Never> { get }
    
    var apply: (State, Effect) -> State { get }
    
    var cancellables: Set<AnyCancellable> { get set }
}

public extension MoonlightTestCase {
    func TestMoonlight(
        event: Event,
        initialState: State,
        expectedState: State
    ) {
        TestMoonlight(
            events: [event],
            initialState: initialState,
            expectedState: expectedState
        )
    }
    
    func TestMoonlight(
        events: [Event],
        initialState: State,
        expectedState: State
    ) {
        let completed = expectation(description: String(describing: Self.self))

        Moonlight.start(
            initialState: initialState,
            environment: environment,
            feedback: { _ in events.publisher.eraseToAnyPublisher() },
            transform: transform,
            apply: apply,
            store: { cancellables.update(with: $0) }
        )
            .first()
            .sink(receiveValue: { newState in
                completed.fulfill()
                XCTAssertEqual(newState, expectedState)
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)
    }
}
