import Foundation

struct Seal: Equatable {
    var to: Int
    var num: Int
}

func main() {
    let (_, l) = read().asList(ofInt).asTuple()
    let a = read().asList(ofInt)
    
    // んー？最悪 O(10^10) になってTLEしそう…
    let queue = DoublyLinkedList<Seal>();
    var count = 0
    for (i, ea) in a.enumerated() {
        var left = ea
        var node = queue.head
        while left > 0 && node != nil {
            let s = node!.value
            if i < s.to {
                left -= s.num
            } else {
                queue.popHead()
            }
            node = node!.next
        }
        if left > 0 {
            queue.pushTail(value: Seal(to: i + l, num: left))
            count += left
        }
    }
    print(count)
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
/// 双方向リスト
class DoublyLinkedList<T: Equatable> {
    class Node {
        let value: T
        fileprivate(set) var prev: Node?
        fileprivate(set) var next: Node?
        
        fileprivate init(value: T, prev: Node?, next: Node?) {
            self.value = value
            self.prev = prev
            self.next = next
        }
    }

    private(set) var head: Node? = nil
    private(set) var tail: Node? = nil
    
    /// 先頭に値を挿入する。
    /// - Parameter value: 挿入する値。
    /// - Returns: 挿入したノードを返す。
    @discardableResult
    func pushHead(value: T) -> Node {
        let newNode = Node(value: value, prev: nil, next: head)
        if let h = head {
            h.prev = newNode
        } else {
            tail = newNode
        }
        head = newNode
        return newNode
    }
    
    /// 末尾に値を挿入する。
    /// - Parameter value: 挿入する値。
    /// - Returns: 挿入したノードを返す。
    @discardableResult
    func pushTail(value: T) -> Node {
        let newNode = Node(value: value, prev: tail, next: nil)
        if let t = tail {
            t.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
        return newNode
    }
    
    /// 先頭の値を削除して返す。
    /// - Returns: 先頭にあった値。なければ`nil`。
    @discardableResult
    func popHead() -> T? {
        if let h = head {
            let value = h.value
            if let n = h.next {
                n.prev = nil
                head = n
            } else {
                head = nil
                tail = nil
            }
            return value
        } else {
            return nil
        }
    }
    
    /// 末尾の値を削除して返す。
    /// - Returns: 末尾にあった値。なければ`nil`。
    @discardableResult
    func popTail() -> T? {
        if let t = tail {
            let value = t.value
            if let p = t.prev {
                p.next = nil
                tail = p
            } else {
                head = nil
                tail = nil
            }
            return value
        } else {
            return nil
        }
    }
    
    /// 先頭から末尾に向かう方向に値を探す。
    /// - Parameters:
    ///   - value: 値
    /// - Returns: 見つかったノード。見つからなければ`nil`。
    func searchForward(value: T) -> Node? {
        return searchForwardCore(value: value, node: head)
    }
    
    /// 指定したノードの次から、末尾に向かう方向に値を探す。
    /// - Parameters:
    ///   - value: 値
    ///   - from: このノードの次から探す。
    /// - Returns: 見つかったノード。見つからなければ`nil`。
    func searchForward(value: T, from: Node) -> Node? {
        return searchForwardCore(value: value, node: from.next)
    }
    
    private func searchForwardCore(value: T, node: Node?) -> Node? {
        var node = node
        while let n = node {
            if n.value == value {
                return n
            }
            node = n.next
        }
        return nil
    }
    
    /// 末尾から先頭に向かう方向に値を探す。
    /// - Parameters:
    ///   - value: 値
    /// - Returns: 見つかったノード。見つからなければ`nil`。
    func searchBackward(value: T) -> Node? {
        return searchBackwardCore(value: value, node: tail)
    }
    
    /// 指定したノードの手前から、先頭に向かう方向に値を探す。
    /// - Parameters:
    ///   - value: 値
    ///   - from: このノードの手前から探す。
    /// - Returns: 見つかったノード。見つからなければ`nil`。
    func searchBackward(value: T, from: Node) -> Node? {
        return searchBackwardCore(value: value, node: from.prev)
    }
    
    func searchBackwardCore(value: T, node: Node?)-> Node? {
        var node = node
        while let n = node {
            if n.value == value {
                return n
            }
            node = n.prev
        }
        return nil
    }
    
    /// 指定したノードの次に値を挿入する。
    /// - Parameters:
    ///   - refNode: このノードの次に値を挿入する。
    ///   - value: 挿入する値。
    /// - Returns: 挿入したノードを返す。
    @discardableResult
    func insert(after refNode: Node, value: T) -> Node {
        let newNode = Node(value: value, prev: refNode, next: refNode.next)
        refNode.next = newNode
        if let next = newNode.next {
            next.prev = newNode
        } else {
            tail = newNode
        }
        return newNode
    }
    
    /// 指定したノードの手前に値を挿入する。
    /// - Parameters:
    ///   - refNode: このノードの手前に値を挿入する。
    ///   - value: 挿入する値。
    /// - Returns: 挿入したノードを返す。
    @discardableResult
    func insert(before refNode: Node, value: T) -> Node {
        let newNode = Node(value: value, prev: refNode.prev, next: refNode)
        refNode.prev = newNode
        if let prev = newNode.prev {
            prev.next = newNode
        } else {
            head = newNode
        }
        return newNode
    }
    
    /// 指定したノードを削除する。
    /// - Parameter node: 削除するノード。
    /// - Returns: 削除したノードにあった値。
    @discardableResult
    func remove(node: Node) -> T {
        let value = node.value
        if let prev = node.prev {
            prev.next = node.next
        } else {
            head = node.next
        }
        if let next = node.next {
            next.prev = node.prev
        } else {
            tail = node.prev
        }
        return value
    }
}
// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
7 3
3 1 4 1 5 9 2
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
