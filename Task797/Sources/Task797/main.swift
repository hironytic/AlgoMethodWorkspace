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
    let ap: [(Int, Int)] = (0 ..< m).map { _ in
        return read().asList(ofInt).asTuple()
    }
    let sum = ap.reduce(0.0) { acc, ac in
        return acc + Double(ac.0) * Double(ac.1)
    }
    print(sum / 100.0)
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
4
85 73
23 16
41 5
7 6
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
