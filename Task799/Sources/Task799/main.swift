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
    let n = read().asInt()
    let a = read().asList(ofInt)
    let b = read().asList(ofInt)
    
    var sum = 0
    var num = 0
    for i in 0 ..< n {
        sum += a[i] * b[i]
        num += b[i]
    }
    print(Double(sum) / Double(num))
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
4
500 100 30 3
1 40 100 1000
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
