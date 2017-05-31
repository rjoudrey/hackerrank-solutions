import Foundation

extension Array where Iterator.Element == Int {
    init(string: String) {
        let numbers = string.characters.split(separator: " ").map { Int(String($0))! }
        self.init(numbers)
    }
}
