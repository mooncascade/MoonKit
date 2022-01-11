import UIKit

public extension NSLayoutConstraint {

    enum Edge: CaseIterable {
        case top
        case left
        case bottom
        case right
    }

    enum Dimension {
        case width
        case height
    }
}

public extension Array where Element == NSLayoutConstraint.Edge {

    static var all: [NSLayoutConstraint.Edge] { NSLayoutConstraint.Edge.allCases }

    static func all(except edge: NSLayoutConstraint.Edge) -> [NSLayoutConstraint.Edge] {
        all.filter { $0 != edge }
    }
}
