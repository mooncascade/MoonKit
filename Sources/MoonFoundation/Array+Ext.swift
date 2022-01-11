public extension Array {

    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

public extension Array where Element: Equatable {

    func next(after item: Element) -> Element? {
        if let index = self.firstIndex(of: item) {
            return index + 1 == self.count ? nil : self[index + 1]
        }
        return nil
    }

    func previous(before item: Element) -> Element? {
        if let index = self.firstIndex(of: item) {
            return index == 0 ? nil : self[index - 1]
        }
        return nil
    }

}
