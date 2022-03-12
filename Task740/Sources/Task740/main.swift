import Foundation

func main() {
    let (n, m) = read().asList(ofInt).asTuple()
    print(permutation(n, m))
}

/// n 個の中から r 個を順に取り出して並べる場合の数を返します。
func permutation(_ n: Int, _ r: Int) -> Int {
    return (n - r + 1 ... n).reduce(1, *)
}

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

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
19 16
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
