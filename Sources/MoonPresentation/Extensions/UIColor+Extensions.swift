import UIKit

public extension UIColor {

    func pixelImage() -> UIImage {
        let size = CGSize(width: 1, height: 1)
        let rect = CGRect(origin: .zero, size: size)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image(actions: { context in
            setFill()
            context.fill(rect)
        })
    }

    func lighter(by percentage: CGFloat) -> UIColor? {
        adjust(by: abs(percentage))
    }

    func darker(by percentage: CGFloat) -> UIColor? {
        adjust(by: -1 * abs(percentage))
    }

    private func adjust(by percentage: CGFloat) -> UIColor? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(
                red: min(red + percentage, 1.0),
                green: min(green + percentage, 1.0),
                blue: min(blue + percentage, 1.0),
                alpha: alpha
            )
        } else {
            return nil
        }
    }
}
