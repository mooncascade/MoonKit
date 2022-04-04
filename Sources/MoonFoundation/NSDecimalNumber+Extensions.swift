import Foundation

public extension NSDecimalNumber {

    static func + (
        lhs: NSDecimalNumber,
        rhs: NSDecimalNumber
    ) -> NSDecimalNumber {
        lhs.adding(rhs)
    }

    static func - (
        lhs: NSDecimalNumber,
        rhs: NSDecimalNumber
    ) -> NSDecimalNumber {
        lhs.subtracting(rhs)
    }

    static func * (
        lhs: NSDecimalNumber,
        rhs: NSDecimalNumber
    ) -> NSDecimalNumber {
        lhs.multiplying(by: rhs)
    }

    static func / (
        lhs: NSDecimalNumber,
        rhs: NSDecimalNumber
    ) -> NSDecimalNumber {
        lhs.dividing(by: rhs)
    }

    static func ^ (
        lhs: NSDecimalNumber,
        rhs: Int
    ) -> NSDecimalNumber {
        lhs.raising(toPower: rhs)
    }
}

extension NSDecimalNumber {

    /// Multiply NSDecimalNumber by -1
    /// - Parameter value: NSDecimalNumber of interest.
    /// - Returns: NSDecimalNumber multiplied by -1
    static prefix func - (
        value: NSDecimalNumber
    ) -> NSDecimalNumber {
        value * -1
    }
}
