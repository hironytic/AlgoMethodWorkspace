import Foundation

let MOD = 998244353

func add(_ a: Int, _ b: Int) -> Int {
    return (a + b) % MOD
}

func mul(_ a: Int, _ b: Int) -> Int {
    return (a * b) % MOD
}

func main() {
    let N = read().asInt()
    var G = [[Int]](repeating: [], count: N)
    for _ in 0 ..< N - 1 {
        let (a, b) = read().asList(ofInt).asTuple()
        G[a].append(b)
        G[b].append(a)
    }

    var seen = [Bool](repeating: false, count: N)
    func dfs(from v: Int) -> (target: Int, nonTarget: Int) {    // v を含める場合の場合の数、 v を含めない場合の場合の数
        seen[v] = true
        var target = 1
        var nonTarget = 1
        for n in G[v] {
            if !seen[n] {
                let (t, n) = dfs(from: n)
                target = mul(target, n)
                nonTarget = mul(nonTarget, add(t, n))
            }
        }
        return (target: target, nonTarget: nonTarget)
    }
    let (t, n) = dfs(from: 0)
    print(add(t, n))
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
