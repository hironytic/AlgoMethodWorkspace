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
// 安定集合にするためには、親を採用するなら、子は1つも採用できない。
// 逆に親を採用しないなら、子は採用してもいいししなくてもいい。
// 例えば 6 を見ると、6を採用するのなら、5 や 8 や 9 は採用できない。
// 6 を採用しないのなら 5 や 8 や 9 は採用してもしなくてもよい。
// そこで 6 を採用する場合に重みの最大値がいくつになるか、
// 逆に 6 を採用しない場合に重みの最大値がいくつになるかを
// それぞれ計算するようにする。
//
// つまり、深さ優先探索で、
// 親を採用する場合の最大の値と、親を採用しない場合の最大値の両方を計算した結果を `dfs(from:)` が返すようにする。
// 親を採用する場合は、親の重みと、再帰で呼び出したそれぞれの子が返す、採用しない場合の最大値を足していったものが最大。
// 親を採用しない場合は、再帰で呼び出したそれぞれの子が返す2つの値の大きい方を足していったものが最大。

func main() {
    let N = read().asInt()
    var G = [[Int]](repeating: [], count: N)
    for _ in 0 ..< N - 1 {
        let (a, b) = read().asList(ofInt).asTuple()
        G[a].append(b)
        G[b].append(a)
    }
    let w = read().asList(ofInt)

    var seen = [Bool](repeating: false, count: N)
    func dfs(from v: Int) -> (target: Int, nonTarget: Int) {    // v を含める場合の最大の重み総和と、 v を含めない場合の最大の重み総和
        seen[v] = true
        var target = w[v]
        var nonTarget = 0
        for n in G[v] {
            if !seen[n] {
                let (t, n) = dfs(from: n)
                target += n
                nonTarget += max(t, n)
            }
        }
        return (target: target, nonTarget: nonTarget)
    }
    let (t, n) = dfs(from: 0)
    print(max(t, n))
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
1 2 3 4 5 6 7 8 9 10
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
