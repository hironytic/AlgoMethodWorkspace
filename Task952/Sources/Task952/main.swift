import Foundation

func main() {
    let (n, m) = read().asList(ofInt).asTuple()
    var g = [[Int]](repeating: [], count: n)
    var seen = [Bool](repeating: false, count: n)
    for _ in 0 ..< m {
        let (a, b) = read().asList(ofInt).asTuple()
        g[a].append(b)
    }
    
    var ans = [Int]()
    func rec(_ v: Int) {
        seen[v] = true
        ans.append(v)
        for v2 in g[v].sorted() {
            if seen[v2] {
                continue
            }
            rec(v2)
        }
    }
    rec(0)
    print(ans.joinedString())
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
6 9
4 3
0 5
5 2
2 3
5 4
4 5
2 1
1 4
2 0
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
