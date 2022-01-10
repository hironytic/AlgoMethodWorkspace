import Foundation

class TestData {
    let data: [String]
    var current: Int = 0
    convenience init(_ text: String) {
        self.init(text.split(separator: "\n").map { String($0) })
    }
    init(_ data: [String]) {
        self.data = data
    }
    func read() -> String {
        let result = data[current]
        current += 1
        return result
    }
}
