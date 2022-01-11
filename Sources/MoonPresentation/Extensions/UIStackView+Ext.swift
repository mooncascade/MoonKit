import UIKit

public extension UIStackView {

    func replaceArrangedSubviews(_ views: [UIView]) {
        subviews.forEach { subview in
            removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        addArrangedSubviews(views)
    }

    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach(addArrangedSubview(_:))
    }

    func removeAllArrangedSubviews() {
        replaceArrangedSubviews([])
    }
}
