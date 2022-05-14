import Foundation

func main() {
    let n = read().asInt()
    
    var parent = [Int](repeating: -1, count: n)
    var children = [[Int]](repeating: [], count: n)
    var connected = [[Int]](repeating: [], count: n)
    
    for _ in 0 ..< n - 1 {
        let (a, b) = read().asList(ofInt).asTuple()
        connected[a].append(b)
        connected[b].append(a)
    }

    func appendChildren(_ v: Int, _ p: Int) {
        for n in connected[v] {
            if n != p {
                parent[n] = v
                children[v].append(n)
                appendChildren(n, v)
            }
        }
    }
    appendChildren(0, -1)
    
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
