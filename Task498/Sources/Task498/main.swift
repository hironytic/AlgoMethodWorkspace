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

func main() {
    let (a_, b_, k) = read().asList(ofInt).asTuple()
    let a = min(a_, b_)
    let b = max(a_, b_)
    
    let c = b - k
    let ans: Bool
    if c < 0 {
        ans = false
    } else {
        ans = c.isMultiple(of: a) || c.isMultiple(of: b - a)
    }
    print(ans ? "Yes" : "No")
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
4 4 2
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
