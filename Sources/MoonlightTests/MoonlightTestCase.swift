import Combine
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
        let completed = expectation(description: String(describing: Self.self))
        
        transform(initialState, event, environment)
            .map { [unowned self] in self.apply(initialState, $0) }
            .sink(receiveValue: { newState in
                completed.fulfill()
                XCTAssertEqual(newState, expectedState)
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1)
    }
    
    func TestMoonlight(
        events: [Event],
        initialState: State,
        expectedState: State
    ) {
        let completed = expectation(description: String(describing: Self.self))

        events.reduce(Just(initialState).eraseToAnyPublisher()) { newState, newEvent in
            newState
                .flatMap { [unowned self] state in
                    self.transform(state, newEvent, self.environment)
                        .map { self.apply(state, $0) }
                }
                .eraseToAnyPublisher()
            }
            .sink(receiveValue: { newState in
                completed.fulfill()
                XCTAssertEqual(newState, expectedState)
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1)
    }
}
