import Foundation

#if DEVELOPING
public class TestData {
    private let name: String
    private let enabled: Bool
    private let data: [String]
    private var current: Int = 0
    public convenience init(enabled: Bool, name: String, text: String) {
        self.init(enabled: enabled, name: name, data: text.split(separator: "\n").map { String($0) })
    }
    public init(enabled: Bool, name: String, data: [String]) {
        self.enabled = enabled
        self.name = name
        self.data = data
    }
    private func read() -> String {
        let result = data[current]
        current += 1
        return result
    }
    public func execute(_ block: (() -> String) -> Void) {
        guard enabled else { return }
        print("--- [\(name)] -------------------")
        block(self.read)
    }
}
#endif
