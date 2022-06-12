import Foundation

func main() {
    let (n, m) = read().asList(ofInt).asTuple()
    let unionFind = UnionFind(count: n)
    
    var ans = n
    for _ in 0 ..< m {
        let (a, b) = read().asList(ofInt).asTuple()
        if unionFind.unite(a, b) {
            ans -= 1
        }
    }
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
/// Union-Find
class UnionFind {
    private struct Node {
        var parent: Int // 親の要素番号
        var rank: Int   // このグループの高さ（根の要素のもののみ有効）
        var count: Int  // このグループ内の要素数（根の要素のもののみ有効）
    }
    private var nodes: [Node]
    
    /// 要素数を指定して構築（各要素は別のグループに所属していることになる）
    /// - Parameter count: 要素数
    init(count: Int) {
        nodes = .init(repeating: Node(parent: -1, rank: 0, count: 1), count: count)
    }
    
    private func root(of i: Int) -> Int {
        if nodes[i].parent == -1 {
            return i
        } else {
            let root = root(of: nodes[i].parent)
            nodes[i].parent = root
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
    func unite(_ x: Int, _ y: Int) -> Bool {
        var rx = root(of: x)
        var ry = root(of: y)
        if rx == ry {
            return false  // すでに同じグループ
        }
        // ryの方がrankが小さくなるようにしておく
        if nodes[rx].rank < nodes[ry].rank {
            swap(&rx, &ry)
        }
        nodes[ry].parent = rx
        if nodes[rx].rank == nodes[ry].rank {
            nodes[rx].rank += 1
        }
        nodes[rx].count += nodes[ry].count
        return true
    }
    
    func countInGroup(of x: Int) -> Int {
        return nodes[root(of: x)].count
    }
}
#if DEVELOPING
let testData = TestData("""
10000 0
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
