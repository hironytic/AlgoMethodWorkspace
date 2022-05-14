import Foundation

func main() {
    let n = read().asInt()
    let children: [(left: Int, right: Int)] = (0 ..< n).map { _ in
        return read().asList(ofInt).asTuple()
    }
    
    var ans = [Int]()
    func rec(_ v: Int) {
        let (left, right) = children[v]
        if left != -1 {
            rec(left)
        }
        ans.append(v)
        if right != -1 {
            rec(right)
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
6
-1 2
-1 5
4 -1
-1 -1
-1 1
3 -1
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
