import Foundation

// ----------------------------------------------------------
func ofInt<S: StringProtocol>(_ string: S) -> Int { Int(string)! }
func ofDouble<S: StringProtocol>(_ string: S) -> Double { Double(string)! }
extension StringProtocol {
    func asInt() -> Int { ofInt(self) }
    func asDouble() -> Double { ofDouble(self) }
    func asList() -> [SubSequence] { split(separator: " ") }
    func asList<T>(_ transform: (SubSequence) -> T) -> [T] { asList().map(transform) }
}
extension Array {
    func asTuple() -> (Element, Element) { (self[0], self[1]) }
    func asTuple() -> (Element, Element, Element) { (self[0], self[1], self[2]) }
}
// ----------------------------------------------------------

extension Int {
    /// 約数の個数を数えます。
    /// O(√n)
    /// - Returns: 約数の個数
    func countDivisors() -> Int {
        var count = 0
        var i = 1
        while i * i <= self {
            if isMultiple(of: i) {
                count += 1
                if i * i != self {
                    count += 1
                }
            }
            i += 1
        }
        return count
    }
}

func main() {
    let (a, b) = read().asList(ofInt).asTuple()
    
    let n = abs(a - b)
    print(n.countDivisors())
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
987654321 123456789
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
