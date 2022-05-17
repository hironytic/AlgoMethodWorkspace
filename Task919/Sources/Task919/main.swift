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
    var root: Node? = nil

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
    
    func find(key: Int, in node: Node) -> Node? {
        if key == node.key {
            return node
        } else if key <= node.key {
            if let left = node.left {
                return find(key: key, in: left)
            } else {
                return nil
            }
        } else {
            if let right = node.right {
                return find(key: key, in: right)
            } else {
                return nil
            }
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
            let isFound: Bool
            if let root = root {
                isFound = find(key: param, in: root) != nil
            } else {
                isFound = false
            }
            print(isFound ? "Yes" : "No")
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
10
1 1
0 10
1 11
1 10
0 1000
0 100000
1 100
1 1000
0 10000000
0 1000000000
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
