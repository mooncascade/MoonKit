import UIKit

public extension UICollectionView {

    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.cellIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        // swiftlint:disable:next force_cast
        dequeueReusableCell(withReuseIdentifier: T.cellIdentifier, for: indexPath) as! T
    }

    func registerReusableView<T: UICollectionReusableView>(_: T.Type) {
        register(
            T.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.reuseIdentifier
        )
    }

    func dequeueReusableView<T: UICollectionReusableView>(ofKind: String, for indexPath: IndexPath) -> T {
        dequeueReusableSupplementaryView(
            ofKind: ofKind,
            withReuseIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as! T // swiftlint:disable:this force_cast
    }
}
