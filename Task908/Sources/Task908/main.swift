import Foundation

func main() {
    let n = read().asInt()
    
    var parent = [Int](repeating: -1, count: n)
    var children = [[Int]](repeating: [], count: n)
    parent[0] = -2 // ちょっと特別な値にしておく
    
    var queue = ArraySlice<(Int, Int)>()
    
    // a, b どっちが親かわからないけど親子関係を結ぶ
    func connect(_ a: Int, _ b: Int) {
        precondition(parent[a] == -1 || parent[b] == -1)    // どちらかの親はまだ決まってないはず
        if parent[a] != -1 {
            // aの親はもういるので、bがaの子になる
            parent[b] = a
            children[a].append(b)
        } else if parent[b] != -1 {
            // bの親はもういるので、aがbの子になる
            parent[a] = b
            children[b].append(a)
        } else {
            // どっちが親かわからないので後回し
            queue.append((a, b))
        }
    }
    
    for _ in 0 ..< n - 1 {
        let (a, b) = read().asList(ofInt).asTuple()
        connect(a, b)
    }
    
    while !queue.isEmpty {
        let (a, b) = queue.removeFirst()
        connect(a, b)
    }
    
    // 兄弟をソート
    children = children.map { $0.sorted() }
    
    // ここからクエリを処理
    let q = read().asInt()
    for _ in 0 ..< q {
        let v = read().asInt()
        print(children[parent[v]].joinedString())
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
extension Array where Element: LosslessStringConvertible {
    /// 配列の内容を連結して1つの文字列にします。
    /// - Parameter separator: セパレータ
    /// - Returns: 連結した文字列
    func joinedString(separator: String = " ") -> String {
        return map { String($0) }.joined(separator: separator)
    }
}
// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
6
2 1
5 0
4 3
5 3
2 4
4
3
1
4
1
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
