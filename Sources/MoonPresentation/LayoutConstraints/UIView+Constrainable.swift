import UIKit

public extension UIView {

    @discardableResult
    func constrain(
        _ edges: [NSLayoutConstraint.Edge],
        _ relate: NSLayoutConstraint.Relation = .equal,
        to item: Constrainable,
        constant: CGFloat = 0
    ) -> [NSLayoutConstraint] {
        edges.map { constrain($0, relate, to: item, constant: constant.adapt(for: $0)) }
    }

    @discardableResult
    func constrain(
        _ edge: NSLayoutConstraint.Edge,
        _ relate: NSLayoutConstraint.Relation = .equal,
        to item: Constrainable,
        edge other: NSLayoutConstraint.Edge? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let layoutConstraint = NSLayoutConstraint(
            item: self,
            attribute: edge.asAttribute,
            relatedBy: relate,
            toItem: item,
            attribute: (other ?? edge).asAttribute,
            multiplier: multiplier,
            constant: constant
        )
        layoutConstraint.isActive = true
        return layoutConstraint
    }

    @discardableResult
    func constrain(
        _ dimension: NSLayoutConstraint.Dimension,
        _ relate: NSLayoutConstraint.Relation = .equal,
        to item: Constrainable? = nil,
        dimension another: NSLayoutConstraint.Dimension? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let layoutConstraint = NSLayoutConstraint(
            item: self,
            attribute: dimension.asAttribute,
            relatedBy: relate,
            toItem: item,
            attribute: item == nil ? .notAnAttribute : (another?.asAttribute ?? dimension.asAttribute),
            multiplier: multiplier,
            constant: constant
        )
        layoutConstraint.isActive = true
        return layoutConstraint
    }

    @discardableResult
    func constrain(size: CGSize) -> [NSLayoutConstraint] {
        [
            constrain(.width, constant: size.width),
            constrain(.height, constant: size.height)
        ]
    }

    @discardableResult
    func constrain(
        _ axis: NSLayoutConstraint.Axis,
        to item: Constrainable,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: axis.asAttribute,
            relatedBy: .equal,
            toItem: item,
            attribute: axis.asAttribute,
            multiplier: multiplier,
            constant: constant
        )
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func constrain(
        _ edges: [NSLayoutConstraint.Edge],
        to item: Constrainable,
        with insets: UIEdgeInsets
    ) -> [NSLayoutConstraint] {
        edges.map { constrain($0, to: item, constant: insets.adapt(for: $0)) }
    }
    
    @discardableResult
    func constrain(centerTo item: Constrainable) -> [NSLayoutConstraint] {
        [
            constrain(.horizontal, to: item),
            constrain(.vertical, to: item)
        ]
    }
}

private extension NSLayoutConstraint.Edge {

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

private extension NSLayoutConstraint.Dimension {

    var asAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .height:
            return .height
        case .width:
            return .width
        }
    }
}

private extension NSLayoutConstraint.Axis {

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

private extension CGFloat {

    func adapt(for edge: NSLayoutConstraint.Edge) -> CGFloat {
        switch edge {
        case .top, .left:
            return self
        case .right, .bottom:
            return -self
        }
    }
}

private extension UIEdgeInsets {

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
