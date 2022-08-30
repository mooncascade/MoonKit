import UIKit

extension UIView: Constrainable {
    public func disableAutoresizingMaskIfPossible() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
