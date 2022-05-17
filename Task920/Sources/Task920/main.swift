import Foundation

class Node {
    var key: Int
    var left: Node? = nil
    var right: Node? = nil
    
    init(key: Int) {
        self.key = key
    }
}

func main() {
    var root: Node? = nil

    func insert(key: Int) {
        if let root = root {
            insert(key: key, into: root)
        } else {
            root = Node(key: key)
        }
    }
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
    
    func find(key: Int) -> (node: Node, parent: Node?)? {
        if let root = root {
            return find(key: key, node: root, parent: nil)
        } else {
            return nil
        }
    }
    func find(key: Int, node: Node, parent: Node?) -> (node: Node, parent: Node?)? {
        if key == node.key {
            return (node: node, parent: parent)
        } else if key <= node.key {
            if let left = node.left {
                return find(key: key, node: left, parent: node)
            } else {
                return nil
            }
        } else {
            if let right = node.right {
                return find(key: key, node: right, parent: node)
            } else {
                return nil
            }
        }
    }
    
    func delete(key: Int) -> Bool {
        guard let root = root else { return false }
        
        let findResult = find(key: key, node: root, parent: nil)
        guard let (node, parent) = findResult else {
            return false
        }
        
        delete(node: node, parent: parent)
        return true
    }
    
    func delete(node: Node, parent: Node?) {
        switch (node.left, node.right) {
        case (nil, nil): // 子頂点を持たない
            if let parent = parent {
                if node === parent.left {
                    parent.left = nil
                } else {
                    parent.right = nil
                }
            } else {
                root = nil
            }
        case (let .some(child), nil), (nil, let .some(child)): // 1つ子を持つ
            if let parent = parent {
                if node === parent.left {
                    parent.left = child
                } else {
                    parent.right = child
                }
            } else {
                root = child
            }
        case (.some(_), let .some(right)): // 2つ子を持つ
            var nexParent = node
            var nex = right
            while let nexLeft = nex.left {
                nexParent = nex
                nex = nexLeft
            }
            node.key = nex.key
            delete(node: nex, parent: nexParent)
        }
    }

    let q = read().asInt()
    for _ in 0 ..< q {
        let (command, param) = read().asList(ofInt).asTuple()
        switch command {
        case 0:
            if let root = root {
                insert(key: param, into: root)
            } else {
                root = Node(key: param)
            }
        case 1:
            let isFound = find(key: param) != nil
            print(isFound ? "Yes" : "No")
        case 2:
            let result = delete(key: param)
            print(result ? "Complete" : "Error")
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
#if DEVELOPING
let testData = TestData("""
11
1 11
2 10
0 1
0 10
0 100
0 1000
2 10000
2 10
0 111
1 100
1 10
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
