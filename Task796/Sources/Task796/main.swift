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
    let m = read().asInt()
    let ac: [(Int, Int)] = (0 ..< m).map { _ in
        return read().asList(ofInt).asTuple()
    }
    
    var sum = 0
    var num = 0
    for (a, c) in ac {
        sum += a * c
        num += c
    }
    print(Double(sum) / Double(num))
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
4
31 2
17 6
68 13
9 2
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
