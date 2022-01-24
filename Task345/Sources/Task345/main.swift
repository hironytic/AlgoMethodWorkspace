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
    let (a, b) = read().asList(ofInt).asTuple()
    
    let n = a - b
    var count = 0
    var i = 1
    while i * i <= n {
        if n.isMultiple(of: i) {
            if i > b {
                count += 1
            }
            if i * i != n && n / i > b {
                count += 1
            }
        }
        i += 1
    }
    print(count)
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
1234567890 57
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
