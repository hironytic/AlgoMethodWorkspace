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

// E[X] = (A1 * P1 + A2 * P2 + ... + Am-1 * Pm-1) / 100
// E[Y] = ((A1 + K) * P1 + (A2 + K) * P2 + ... + (Am-1 + K) * Pm-1) / 100
//      = (A1 * P1 + A2 * P2 + ... + Am-1 * Pm-1 + K * P1 + K * P2 + ... + K * Pm-1) / 100
//      = (E[X] + K * (P1 + P2 + ... + Pm-1)) / 100
//
// E[Y] - E[X]
// = K * (P1 + P2 + ... + Pm-1) / 100
// = K

func main() {
    let (m, k) = read().asList(ofInt).asTuple()
    for _ in 0 ..< m {
        _ = read()
    }
    print(k)
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
2 3
4 50
8 50
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
