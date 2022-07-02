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
// 親の頂点を結果の頂点集合に入れると、親と子をつなぐ辺はすべてカバーすることができる。
// また親とそのさらに親への辺もカバーできる。
// 例えば 6 を見ると、6 から 子 5, 8, 9 への辺をカバーできるし、
// 親 4 への辺もカバーする（逆に言えば、4から見れば 4-6 の辺はカバーする必要がない）。
//
// これを一般化して、深さ優先探索で、
// 親と子を結ぶ辺をカバーする必要があれば（dfs(from: n) が true を返す子があれば）
// 親の頂点を結果の頂点集合に入れ、さらに親に対してはカバーする必要がないと伝える。
// （dfs(from: v) が false を返す）。
// つまり、 isTarget == false のときに、答えの数を 1 つだけ増やす。
//
// ↓ ( ) 付きの頂点が、dfs が true を返すもの（その頂点までの辺を親にカバーしてほしい子）
//    逆に言えば ( ) が付かない頂点のみ選択すればすべての辺をカバーできる。
//
//        (0)
//       ／
//      3
//   ／ │
// (7)   4
//    ／│＼
//  (1) (2)  6
//        ／│＼
//      (5) (8) (9)
//
// ( ) に囲まれない頂点の数が答えなので、この例なら 3

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
        if !isTarget {
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
