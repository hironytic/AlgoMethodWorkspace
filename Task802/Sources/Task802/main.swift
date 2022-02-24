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

// E[X + Y]
// = (E[X + B1] * Q1 + E[X * B2] * Q2 + ... + E[X * Bm-1] * Qm-1) / 100
// = ((E[X] + B1) * Q1 + (E[X] + B2) * Q2 + ... + (E[X] + Bm-1) * Qm-1) / 100
// = (E[X] * (Q1 + Q2 + ... + Qm-1) / 100) + (B1 * Q1 + B2 * Q2 + ... + Bm-1 * Qm-1) / 100
// = E[X] + E[Y]

func main() {
    let (n, m) = read().asList(ofInt).asTuple()
    let ap: [(Int, Int)] = (0 ..< n).map { _ in
        return read().asList(ofInt).asTuple()
    }
    let bq: [(Int, Int)] = (0 ..< m).map { _ in
        return read().asList(ofInt).asTuple()
    }
    
    let ex = ap.reduce(0.0) { acc, value in acc + Double(value.0) * Double(value.1) } / 100.0
    let ey = bq.reduce(0.0) { acc, value in acc + Double(value.0) * Double(value.1) } / 100.0

    print(ex + ey)
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
4 3
85 73
23 16
41 5
7 6
10 37
98 20
55 43
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
