import UIKit

public extension UITableView {

    func registerReusableCell<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.cellIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        // swiftlint:disable:next force_cast
        dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexPath) as! T
    }

    func registerReusableHeaderFooter<T: UITableViewHeaderFooterView>(_: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.cellIdentifier)
    }

    func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>() -> T {
        // swiftlint:disable:next force_cast
        dequeueReusableHeaderFooterView(withIdentifier: T.cellIdentifier) as! T
    }
}
