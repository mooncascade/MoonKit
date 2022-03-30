import UIKit

public extension UIButton {

    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        setBackgroundImage(color.pixelImage(), for: state)
    }
}
