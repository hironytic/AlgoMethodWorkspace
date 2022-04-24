import Foundation

let latinSmallA = Int(Character("a").asciiValue!)
let B = 30
let M = 1000003

func hash<S: StringProtocol>(_ str: S) -> Int {
    let chars = str.map { Int($0.asciiValue!) - latinSmallA + 1 }
    let ns = chars.count
    var h = 0
    var b = 1
    for i in 0 ..< ns {
        h += chars[ns - 1 - i] * b
        b *= B
    }
    return h % M
}

func main() {
    var lists = [SinglyLinkedList<String.SubSequence>?](repeating: nil, count: M + 1)
    
    func list(at hash: Int) -> SinglyLinkedList<String.SubSequence> {
        if let list = lists[hash] {
            return list
        } else {
            let list = SinglyLinkedList<String.SubSequence>()
            lists[hash] = list
            return list
        }
    }
    
    let q = read().asInt()
    for _ in 0 ..< q {
        let (command, param) = read().asList().asTuple()
        let h = hash(param)
        switch command {
        case "0":
            list(at: h).pushHead(value: param)
        case "1":
            let list = list(at: h)
            let (node, prev) = list.search(value: param)
            if node != nil {
                list.remove(nextToOrFromHead: prev)
            }
        case "2":
            if list(at: h).search(value: param).node != nil {
                print("Yes")
            } else {
                print("No")
            }
        default:
            break
        }
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
/// 片方向リスト
class SinglyLinkedList<T: Equatable> {
    class Node {
        let value: T
        fileprivate(set) var next: Node?
        
        fileprivate init(value: T, next: Node?) {
            self.value = value
            self.next = next
        }
    }

    private(set) var head: Node? = nil

    /// 先頭に値を挿入する。
    /// - Parameter value: 挿入する値。
    /// - Returns: 挿入したノードを返す。
    @discardableResult
    func pushHead(value: T) -> Node {
        let newNode = Node(value: value, next: head)
        head = newNode
        return newNode
    }

    /// 先頭の値を削除して返す。
    /// - Returns: 先頭にあった値。なければ`nil`。
    func popHead() -> T? {
        if let h = head {
            let value = h.value
            head = h.next
            return value
        } else {
            return nil
        }
    }

    /// 先頭から末尾に向かう方向に値を探す。
    /// - Parameters:
    ///   - value: 値
    /// - Returns: 見つかれば、見つかったノードと、1つ手前のノードのタプルを返す。
    ///            見つからなければ、`nil`と末尾のノードのタプルを返す。
    func search(value: T) -> (node: Node?, prev: Node?) {
        return searchCore(value: value, node: head, prev: nil)
    }
    
    /// 指定したノードの次から、末尾に向かう方向に値を探す。
    /// - Parameters:
    ///   - value: 値
    ///   - from: このノードの次から探す。
    /// - Returns: 見つかれば、見つかったノードと、1つ手前のノードのタプルを返す。
    ///            見つからなければ、`nil`と末尾のノードのタプルを返す。
    func search(value: T, from: Node) -> (node: Node?, prev: Node?) {
        return searchCore(value: value, node: from.next, prev: from)
    }
    
    private func searchCore(value: T, node: Node?, prev: Node?) -> (node: Node?, prev: Node?) {
        var node = node
        var prev = prev
        while let n = node {
            if n.value == value {
                return (node: n, prev: prev)
            }
            prev = node
            node = n.next
        }
        return (node: nil, prev: prev)
    }

    /// 指定したノードの次に値を挿入する。
    /// - Parameters:
    ///   - refNode: このノードの次に値を挿入する。
    ///   - value: 挿入する値。
    /// - Returns: 挿入したノードを返す。
    @discardableResult
    func insert(after refNode: Node, value: T) -> Node {
        let newNode = Node(value: value, next: refNode.next)
        refNode.next = newNode
        return newNode
    }
    
    /// 指定したノードの次のノードを削除する。
    /// - Parameter prev: 削除するノードの手前のノード。
    /// - Returns: 次のノードにあった値。次のノードがなければ`nil`。
    @discardableResult
    func remove(nextTo prev: Node) -> T? {
        if let next = prev.next {
            prev.next = next.next
            return next.value
        } else {
            return nil
        }
    }
}

extension SinglyLinkedList {
    /// 指定したノードの次か、先頭に値を挿入する。
    /// - Parameters:
    ///   - refNode: このノードの次に値を挿入する。`nil`を指定すれば先頭に値を挿入する。
    ///   - value: 挿入する値。
    /// - Returns: 挿入したノードを返す。
    @discardableResult
    func insert(afterOrToHead refNode: Node?, value: T) -> Node {
        if let refNode = refNode {
            return insert(after: refNode, value: value)
        } else {
            return pushHead(value: value)
        }
    }
    
    /// 指定したノードの次のノードか、先頭のノードを削除する。
    /// - Parameter prev: 削除するノードの手前のノード。`nil`を指定すれば先頭のノードを削除する。
    /// - Returns: 次のノードまたは先頭にあった値。値がなければ`nil`。
    @discardableResult
    func remove(nextToOrFromHead prev: Node?) -> T? {
        if let prev = prev {
            return remove(nextTo: prev)
        } else {
            return popHead()
        }
    }
}
// ----------------------------------------------------------

#if DEVELOPING
let testData = TestData("""
7
2 abc
0 abc
0 dd
2 abc
0 xyz
1 dd
2 stu
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
