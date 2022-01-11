import UIKit

public extension UICollectionView {

    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.cellIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        // swiftlint:disable:next force_cast
        dequeueReusableCell(withReuseIdentifier: T.cellIdentifier, for: indexPath) as! T
    }
}
