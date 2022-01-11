import Foundation

extension NSDecimalNumber: Comparable {

    public static func == (
        lhs: NSDecimalNumber,
        rhs: NSDecimalNumber
    ) -> Bool {
        lhs.compare(rhs) == .orderedSame
    }

    public static func < (
        lhs: NSDecimalNumber,
        rhs: NSDecimalNumber
    ) -> Bool {
        lhs.compare(rhs) == .orderedAscending
    }
}
