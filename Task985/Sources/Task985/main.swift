import Foundation

func main() {
    let (N, M) = read().asList(ofInt).asTuple()
    var G = [[(to: Int, dist: Int)]](repeating: [], count: N)
    for _ in 0 ..< M {
        let (u, v, w) = read().asList(ofInt).asTuple()
        G[u].append((v, w))
    }
    
    var dp = [Int](repeating: Int.max, count: N)
    dp[0] = 0
    for i in 0 ..< N {
        let d = dp[i]
        if d != Int.max {
            for (to, dist) in G[i] {
                dp[to] = min(dp[to], d + dist)
            }
        }
    }
    let ans = dp[N - 1]
    if ans == Int.max {
        print(-1)
    } else {
        print(ans)
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
8 17
5 7 69
0 2 39
2 3 51
0 1 58
5 6 7
3 5 39
1 2 6
4 5 95
3 4 82
3 5 57
0 2 75
5 7 57
6 7 94
3 4 100
6 7 32
5 7 41
4 6 78
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
