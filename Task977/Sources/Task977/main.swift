import Foundation

func main() {
    let N = read().asInt()
    var G = [[Int]](repeating: [], count: N)
    for _ in 0 ..< N - 1 {
        let (a, b) = read().asList(ofInt).asTuple()
        G[a].append(b)
        G[b].append(a)
    }

    func farthest(from v: Int) -> (Int, Int) {
        var seen = [Bool](repeating: false, count: N)
        func dfs(from v: Int) -> (Int, Int) {
            if seen[v] { return (v, Int.min) }
            seen[v] = true
            var maxDistance = -1
            var maxV = v
            for n in G[v] {
                let (v, d) = dfs(from: n)
                if maxDistance < d {
                    maxDistance = d
                    maxV = v
                }
            }
            return (maxV, maxDistance + 1)
        }
        return dfs(from: v)
    }
    let v = farthest(from: 0).0
    let distance = farthest(from: v).1
    print((distance - 1) / 2 + 1)
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
7
6 1
1 4
3 2
3 5
6 2
2 0
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
