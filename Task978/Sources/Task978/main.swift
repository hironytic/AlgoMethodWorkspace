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
// 木なので、子同士は辺で結ばれない。しかし、親は子と辺で結ばれる。
// 例えば 6 を見ると、子 5, 8, 9 は安定集合だが、そこに 6 を加えるとそうではなくなる。
//
// これを一般化して、深さ優先探索で、
// 結果の安定集合に入れる子（dfs(from: n) が true を返す子）が 1 つでもあれば、
// その親は安定集合に入れない（dfs(from: v) は false を返す）
// 逆に、結果の安定集合に入れる子が 1 つもないなら、親を安定集合に入れる。
// つまり、 isTarget == true のときに安定集合に入れるので、答えの数を 1 つ増やす。
//
// ↓ ( ) 付きの頂点が、dfs(from:) が true を返すもの（結果の安定集合の要素）
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
// ( ) の頂点の数が答えなので、この例なら 7

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
