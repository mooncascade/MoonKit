import UIKit

public extension UILabel {

    func setMulticolorText(_ textWithColor: (String, UIColor)...) {
        attributedText = textWithColor
            .map { NSMutableAttributedString(string: $0, attributes: [NSAttributedString.Key.foregroundColor: $1]) }
            .reduce(NSMutableAttributedString(string: "")) { result, nextString in
                result.append(nextString)
                return result
            }
    }
}
