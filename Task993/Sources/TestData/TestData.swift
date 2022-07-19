import Foundation

#if DEVELOPING
public class TestData {
    private let name: String
    private let enabled: Bool
    private let data: [String]
    private let expected: [String]
    private var actual: [String] = []
    private var current: Int = 0
    public convenience init(enabled: Bool, name: String, text: String, expected: String? = nil) {
        self.init(
            enabled: enabled,
            name: name,
            data: text.split(separator: "\n").map { String($0) },
            expected: expected?.split(separator: "\n").map { String($0) } ?? []
        )
    }
    public init(enabled: Bool, name: String, data: [String], expected: [String] = []) {
        self.enabled = enabled
        self.name = name
        self.data = data
        self.expected = expected
    }
    private func read() -> String {
        let result = data[current]
        current += 1
        return result
    }
    private func write(items: Any...) {
        let line = items.map { String(describing: $0) }.joined(separator: " ")
        print(line)
        actual.append(line)
    }
    public func execute(_ block: (() -> String, (Any...) -> Void) -> Void) {
        guard enabled else { return }
        print("--- [\(name)] -------------------")
        block(self.read, self.write)
        if !expected.isEmpty {
            if actual == expected {
                print("✅ OK")
            } else {
                print("❌ NG")
            }
        }
    }
}
#endif
