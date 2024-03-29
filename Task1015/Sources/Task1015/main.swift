import Foundation

struct Edge {
    var v1: Int
    var v2: Int
    var weight: Int
}

func main(read: () -> String) {
    let (H, W) = read().asList(ofInt).asTuple()
    let A: [[Int]] = (0 ..< H).map { _ in
        return read().asList(ofInt)
    }
    let B: [[Int]] = (0 ..< H - 1).map { _ in
        return read().asList(ofInt)
    }

    let areaCount = (H - 1) * (W - 1) + 1

    // 頂点(i, j)の右下にある領域の番号を (W - 1) * i + j として、それを返す。
    // ただし頂点や領域がHWの外側になる場合は、外側の領域を表す番号 (H - 1) * (W - 1) を返す。
    func area(i: Int, j: Int) -> Int {
        if i < 0 || i >= H - 1 || j < 0 || j >= W - 1 { return areaCount - 1 } // 外側の領域
        return (W - 1) * i + j
    }
    
    // このグリッドグラフとは別のグラフGを次のように定義
    // - Gの頂点はグリッドグラフの領域
    // - Gの頂点間をつなぐ辺は、グリッドグラフの領域を仕切っている辺
    // このGの各辺をedgesに入れる
    var edges = [Edge]()
    for i in 0 ..< H {
        for j in 0 ..< W - 1 {
            let areaN = area(i: i - 1, j: j)
            let areaS = area(i: i, j: j)
            edges.append(Edge(v1: areaN, v2: areaS, weight: A[i][j]))
        }
    }
    for i in 0 ..< H - 1 {
        for j in 0 ..< W {
            let areaW = area(i: i, j: j - 1)
            let areaE = area(i: i, j: j)
            edges.append(Edge(v1: areaW, v2: areaE, weight: B[i][j]))
        }
    }
    edges.sort { lhs, rhs in lhs.weight < rhs.weight }

    // Gの最小全域木の重みの総和が、答えとなる取り除く辺の重みの総和の最小値
    var ans = 0
    let uf = UnionFind(count: areaCount)
    for e in edges {
        if !uf.isSameGroup(e.v1, e.v2) {
            uf.unite(e.v1, e.v2)
            ans += e.weight
        }
    }
    print(ans)
}

class UnionFind {
    private var parents: [Int]   // 親の要素番号
    private var ranks: [Int]     // このグループの高さ（根の要素のもののみ有効）
    private var counts: [Int]    // このグループ内の要素数（根の要素のもののみ有効）
    
    /// 要素数を指定して構築（各要素は別のグループに所属していることになる）
    /// - Parameter count: 要素数
    init(count: Int) {
        parents = .init(repeating: -1, count: count)
        ranks = .init(repeating: 0, count: count)
        counts = .init(repeating: 1, count: count)
    }
    
    /// 指定した要素が所属するグループの根を求める
    /// - Parameter i: 要素
    /// - Returns: 根の要素番号
    private func root(of i: Int) -> Int {
        if parents[i] == -1 {
            return i
        } else {
            let parent = parents[i]
            let root = root(of: parent)
            parents[i] = root
            return root
        }
    }
    
    /// 指定した2つの要素番号の要素が同じグループに所属しているかどうかを調べる
    /// - Parameters:
    ///   - x: 要素x
    ///   - y: 要素y
    /// - Returns: 同じグループに所属していれば `true`、そうでなければ `false`。
    func isSameGroup(_ x: Int, _ y: Int) -> Bool {
        return root(of: x) == root(of: y)
    }
    
    /// 指定した2つの要素番号の要素を含むグループを統合する
    /// - Parameters:
    ///   - x: 要素x
    ///   - y: 要素y
    /// - Returns: 統合すれば `true`、すでに同じグループなら `false`。
    @discardableResult
    func unite(_ x: Int, _ y: Int) -> Bool {
        var rx = root(of: x)
        var ry = root(of: y)
        if rx == ry {
            return false  // すでに同じグループ
        }
        // ryの方がrankが小さくなるようにしておく
        if ranks[rx] < ranks[ry] {
            swap(&rx, &ry)
        }
        parents[ry] = rx
        let rank = max(ranks[rx], ranks[ry] + 1)
        ranks[rx] = rank
        let count = counts[ry]
        counts[rx] += count
        return true
    }
    
    /// 指定した要素番号の要素を含むグループ内の、要素の個数を求めます。
    /// - Parameter x: グループに含まれる要素
    /// - Returns: xを含むグループに含まれる要素の数
    func countInGroup(of x: Int) -> Int {
        return counts[root(of: x)]
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
validate(main)
#else
main { readLine()! }
#endif
