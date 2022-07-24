import Foundation

#if DEVELOPING
public class TestData {
    private static var currentRun: TestData? = nil
    private let name: String
    private let data: [String]
    private let expected: [String]
    private var actual: [String] = []
    private var current: Int = 0
    public convenience init(name: String, text: String, expected: String? = nil) {
        self.init(
            name: name,
            data: text.split(separator: "\n").map { String($0) },
            expected: expected?.split(separator: "\n").map { String($0) } ?? []
        )
    }
    public init(name: String, data: [String], expected: [String] = []) {
        self.name = name
        self.data = data
        self.expected = expected
    }
    private func read() -> String {
        let result = data[current]
        current += 1
        return result
    }
    private func write(items: [Any]) {
        let line = items.map { String(describing: $0) }.joined(separator: " ")
        print(line)
        actual.append(line)
    }
    public func execute(_ block: (() -> String) -> Void) {
        Self.currentRun = self
        defer { Self.currentRun = nil }
        print("--- [\(name)] -------------------")
        block(self.read)
        if !expected.isEmpty {
            if actual == expected {
                print("✅ OK")
            } else {
                print("❌ NG")
            }
        }
    }
    public static func write(_ items: [Any]) {
        currentRun?.write(items: items)
    }
}
#endif
