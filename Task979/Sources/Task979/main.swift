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
// 親から子への辺は、同じ親の頂点から出ているので、それらを同じ辺集合に含めてしまうと
// マッチングにはならない。また、親からさらに親への辺も同じ頂点を端点に持つので、
// これも同じ同じ辺集合に含めてしまうとマッチングにはならない。
// 例えば 6 を見ると、子 5, 8, 9 への辺はすべて 6 を端点に持つ。
// また、 6 から親 4 への辺も 6 を端点に持つ。
// つまり、6-5、6-8、6-9、6-4 の辺は同じ辺集合に含めるとマッチングにならない。
// 6-5、6-8、6-9のいずれかの辺1つだけを採用し、6-4 は採用しないことでマッチングを保てる。
//
// これを一般化して、深さ優先探索で、
// 親と子を結ぶ辺を結果の辺集合に入れられる可能性があれば（dfs(from: n) が true を返す子があれば）
// 可能性のある子との辺のうちのどれか 1 つだけを、結果の辺集合に入れる。
// また、親とそのさらに親を結ぶ辺は結果の辺集合に入れない（dfs(from: v) は false を返す）。
// つまり、 isTarget == false のときに、答えの数を 1 つだけ増やす。
//
// ↓ ( ) 付きの頂点が、dfs(from:) が true を返すもの（親と結ぶ辺を結果の辺集合に入れる可能性のあるもの）
//    また、dfs(from:) が true を返す子との辺のうちどれか1つを選んだものを [ ] で表した。
//
//        (0)
//       ／
//      3
//  [／]│
// (7)   4
//   ／[│]＼
//  (1) (2)  6
//        ／│[＼]
//      (5) (8) (9)
//
// [ ] の辺の数が答えなので、この例なら 3

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
