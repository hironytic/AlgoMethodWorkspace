import Foundation

// 例：
//         0
//       ／
//      3
//   ／ │
//  7    4
//    ／│＼
//   1   2   6
//        ／│＼
//       5   8   9
//
// 親と子をつなぐ辺を結果の辺集合に入れると、親もカバーされるので、
// さらにその親との辺は辺集合に入れる必要はない。
// 例えば 6 を見ると、6-5、6-8、6-9 のどれかの辺を辺集合に入れれば
// 6 はカバーされるので、親との 4-6 は（6側としては）必ずしも辺集合に入れなくてもいい。
//
// これを一般化して、深さ優先探索で、
// 親と子を結んでくれと要求する子が1つでもあれば（dfs(from: n) が true を返す子があれば）
// さらに親に対しては結んでくれは要求しない（dfs(from: v) が false を返す）。
// 逆に、結んでくれと要求する子が1つもいなければ、親に結んでくれと要求する。
// また、子が要求した場合はその辺は結果に採用するしかないので、子が要求する際にカウントを
// 1つ増やす。（つまり、 isTarget == true のときに答えを 1 つだけ増やす）
// なお、この考え方で行くと、根の子がすべて要求してこなかった場合に、根はその親に
// 結んでくれと返すことになるが、根なので親はいない。ただ、その場合でも、子とのどれか1つの
// 辺を結果に入れればいいので、要求する際にカウントを1つ増やすという戦略はそのままでOK。
//
// ↓ ( ) 付きの頂点が、dfs が true を返すもの（その頂点までの辺を結果に入れてほしい子）
//    また、dfs(from:) が true を返す子との辺を [ ] で表した。
//
//        (0)
//      [／]   ← 根の 0 がつないでほしいので採用した辺
//      3
//  [／]│
// (7)   4
// [／][│]＼
// (1)  (2)  6
//      [／][│][＼]
//     (5)  (8)  (9)
//
// [ ] の辺の数が答えなので、この例なら 7

func main() {
    let N = read().asInt()
    var G = [[Int]](repeating: [], count: N)
    for _ in 0 ..< N - 1 {
        let (a, b) = read().asList(ofInt).asTuple()
        G[a].append(b)
        G[b].append(a)
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
