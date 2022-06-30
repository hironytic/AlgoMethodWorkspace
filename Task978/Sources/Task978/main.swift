import Foundation

func main() {
    let N = read().asInt()
    var G = [[Int]](repeating: [], count: N)
    for _ in 0 ..< N - 1 {
        let (a, b) = read().asList(ofInt).asTuple()
        G[a].append(b)
        G[b].append(a)
    }

    if N == 1 {
        print(1)
        return
    }
    if N == 2 {
        print(0)
        return
    }

    var ans = 0
    var seen = [Bool](repeating: false, count: N)
    func dfs(from v: Int) -> Bool {
        seen[v] = true
        var isTarget = true
        for n in G[v] {
            if !seen[n] {
                if dfs(from: n) {
                    isTarget = false
                }
            }
        }
        if isTarget {
            ans += 1
        }
        return isTarget
    }
    _ = dfs(from: 0)
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
10
4 6
3 1
2 4
5 6
6 9
0 4
7 3
6 8
4 3
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
