// swiftlint:disable:this file_name
import UIKit

internal extension NSLayoutConstraint.Edge {
    var asAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .top:
            return .top

        case .left:
            return .leading

        case .right:
            return .trailing

        case .bottom:
            return .bottom
        }
    }
}

internal extension NSLayoutConstraint.Dimension {
    var asAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .height:
            return .height

        case .width:
            return .width
        }
    }
}

internal extension NSLayoutConstraint.Axis {
    var asAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .horizontal:
            return .centerX

        case .vertical:
            return .centerY

        @unknown default:
            fatalError("Unknown NSLayoutConstraint.Attribute")
        }
    }
}

internal extension CGFloat {
    func adapt(for edge: NSLayoutConstraint.Edge) -> CGFloat {
        switch edge {
        case .top, .left:
            return self

        case .right, .bottom:
            return -self
        }
    }
}

internal extension UIEdgeInsets {
    func adapt(for edge: NSLayoutConstraint.Edge) -> CGFloat {
        switch edge {
        case .top:
            return top

        case .left:
            return left

        case .right:
            return -right

        case .bottom:
            return -bottom
        }
    }
}
