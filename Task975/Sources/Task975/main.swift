import Foundation

func main() {
    let N = read().asInt()
    var G = [[Int]](repeating: [], count: N)
    for _ in 0 ..< N - 1 {
        let (a, b) = read().asList(ofInt).asTuple()
        G[a].append(b)
        G[b].append(a)
    }

    var ans = Int.min
    for i in 0 ..< N {
        var seen = [Bool](repeating: false, count: N)
        func depth(from v: Int) -> Int {
            if seen[v] { return -1 }
            seen[v] = true
            return G[v].reduce(0) { acc, n in max(acc, depth(from: n) + 1) }
        }
        ans = max(ans, depth(from: i))
    }
    print(ans)
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
3 4
0 4
6 1
1 3
4 5
1 2
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
