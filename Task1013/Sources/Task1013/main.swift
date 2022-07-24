import Foundation

struct Edge {
    var v1: Int
    var v2: Int
    var weight: Int
}

func main(read: () -> String) {
    let (N, M) = read().asList(ofInt).asTuple()
    let E: [Edge] = (0 ..< M).map { _ in
        let (u, v, w) = read().asList(ofInt).asTuple()
        return Edge(v1: u, v2: v, weight: w)
    }.sorted { lhs, rhs in lhs.weight < rhs.weight }

    // 辺 except は使わない場合の最小値 W を算出
    // except を使わないことで木が作れなくなる場合は Int.max を返します。
    func calcW(except: Int) -> Int {
        let uf = UnionFind(count: N)
        var w = 0
        for (ix, e) in E.enumerated() where ix != except {
            if !uf.isSameGroup(e.v1, e.v2) {
                uf.unite(e.v1, e.v2)
                w += e.weight
            }
        }
        if uf.countInGroup(of: 0) == N {
            return w
        } else {
            return Int.max
        }
    }
    
    // すべての辺を使って良い場合の最小値（本当の最小値）
    let W = calcW(except: -1)
    
    var ans = 0
    for i in 0 ..< E.count {
        let wi = calcW(except: i)
        if wi > W {
            // i がいないと最小を作れないので絶対必要
            ans += 1
        }
    }
    print(ans)
}

/// Union-Find
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
