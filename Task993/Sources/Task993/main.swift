import Foundation

let INF = 1_000_000_000

func main() {
    let (N, M) = read().asList(ofInt).asTuple()
    var G = [[(to: Int, weight: Int)]](repeating: [], count: N)
    for _ in 0 ..< M {
        let (u, v, w) = read().asList(ofInt).asTuple()
        G[u].append((to: v, weight: w))
    }
    var d = [Int](repeating: INF, count: N)
    var f = [Bool](repeating: false, count: N)
    d[0] = 0
    
    while let v = (0 ..< N).lazy.filter({ f[$0] == false }).min(by: { d[$0] < d[$1] }) {
        let dv = d[v]
        for (to, weight) in G[v] {
            let u = dv + weight
            if d[to] > u {
                d[to] = u
            }
        }
        f[v] = true
    }
    for dv in d {
        print(dv)
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
5 10
3 1 46
2 1 48
4 2 21
0 1 26
4 1 50
4 0 87
1 0 57
1 3 42
1 2 52
0 4 10
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
