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

extension Array where Element: LosslessStringConvertible {
    func joinedString(separator: String = " ") -> String {
        return map { String($0) }.joined(separator: separator)
    }
}

func main() {
    var n = read().asInt()
    
    var ans = [Int]()
    var i = 2
    while i * i <= n {
        while n.isMultiple(of: i) {
            ans.append(i)
            n /= i
        }
        i += 1
    }
    if n > 1 {
        ans.append(n)
    }
    
    print(ans.joinedString())
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
9316358251200
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
