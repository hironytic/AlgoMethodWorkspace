import Foundation

func main() {
    let (N, M) = read().asList(ofInt).asTuple()
    var G = [[(Int, Int)]](repeating: [], count: N)
    for _ in 0 ..< M {
        let (u, v, w) = read().asList(ofInt).asTuple()
        G[u].append((v, w))
    }
    for i in 0 ..< N {
        if let (v, _) = G[i].min(by: { $0.1 == $1.1 ? $0.0 < $1.0 : $0.1 < $1.1 }) {
            print(v)
        } else {
            print(-1)
        }
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
6 8
5 2 20
0 4 88
4 5 58
2 5 7
4 2 55
5 0 65
1 3 22
3 4 43
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
