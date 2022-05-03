import Combine

public extension Publisher {
    func sinkValue(_ receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable {
        sink(
            receiveCompletion: { _ in },
            receiveValue: receiveValue
        )
    }

    func mapTo() -> Publishers.Map<Self, Void> {
        map { _ in () }
    }

    func mapTo<T>(_ value: T) -> Publishers.Map<Self, T> {
        map { _ in value }
    }
}

public extension Subscribers.Completion {
    var error: Failure? {
        if case let .failure(error) = self {
            return error
        }
        return nil
    }
}
