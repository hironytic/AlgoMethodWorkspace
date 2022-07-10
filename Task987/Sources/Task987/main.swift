import Foundation

struct Edge {
    var from: Int
    var to: Int
    var weight: Int
}
func main() {
    let (N, M) = read().asList(ofInt).asTuple()
    let E: [Edge] = (0 ..< M).map { _ in
        let (u, v, w) = read().asList(ofInt).asTuple()
        return Edge(from: u, to: v, weight: w)
    }
    var d = [Int](repeating: 1_000_000_000, count: N)
    d[0] = 0
    for e in E {
        d[e.to] = min(d[e.to], d[e.from] + e.weight)
    }
    for di in d {
        print(di)
    }
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
#if DEVELOPING
let testData = TestData("""
8 19
5 3 -61
3 0 -60
4 5 -98
6 2 -97
0 4 25
5 4 -34
4 2 -29
2 7 12
6 0 -26
3 1 48
5 7 68
1 7 65
1 6 8
0 1 -15
0 5 23
2 6 -64
2 5 -25
7 0 -53
5 6 64
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
