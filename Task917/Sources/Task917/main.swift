import Foundation

class Node {
    let key: Int
    var left: Node? = nil
    var right: Node? = nil
    
    init(key: Int) {
        self.key = key
    }
}

func main() {
    let root: Node = Node(key: 5)
    
    func insert(key: Int, into node: Node) {
        if key <= node.key {
            if let left = node.left {
                insert(key: key, into: left)
            } else {
                node.left = Node(key: key)
            }
        } else {
            if let right = node.right {
                insert(key: key, into: right)
            } else {
                node.right = Node(key: key)
            }
        }
    }
    
    for k in [2, 3, 7, 9, 4, 1, 6, 8] {
        insert(key: k, into: root)
    }
    
    var ans = [Int]()
    func visit(_ node: Node) {
        ans.append(node.key)
        if let left = node.left {
            visit(left)
        }
        if let right = node.right {
            visit(right)
        }
    }
    visit(root)
    
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
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
