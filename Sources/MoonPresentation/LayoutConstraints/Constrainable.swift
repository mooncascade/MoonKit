import UIKit

public protocol Constrainable: AnyObject {
    func disableAutoresizingMaskIfPossible()
}

public extension Constrainable {
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
        disableAutoresizingMaskIfPossible()
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
        disableAutoresizingMaskIfPossible()
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
        disableAutoresizingMaskIfPossible()
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
