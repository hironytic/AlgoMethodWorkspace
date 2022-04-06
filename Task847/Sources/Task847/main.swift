import Foundation

class Node {
    let value: String
    var prev: Node?
    var next: Node?
    
    init(value: String, prev: Node?, next: Node?) {
        self.value = value
        self.prev = prev
        self.next = next
    }
}

func main() {
    var head: Node? = nil
    var tail: Node? = nil
    
    let q = read().asInt()
    for _ in 0 ..< q {
        let query = read().asList()
        switch query[0] {
        case "0":
            let newNode = Node(value: String(query[1]), prev: nil, next: head)
            if let h = head {
                h.prev = newNode
            } else {
                tail = newNode
            }
            head = newNode
        case "1":
            let newNode = Node(value: String(query[1]), prev: tail, next: nil)
            if let t = tail {
                t.next = newNode
            } else {
                head = newNode
            }
            tail = newNode
        case "2":
            if let h = head {
                print(h.value)
                if let n = h.next {
                    n.prev = nil
                    head = n
                } else {
                    head = nil
                    tail = nil
                }
            } else {
                print("Error")
            }
        case "3":
            if let t = tail {
                print(t.value)
                if let p = t.prev {
                    p.next = nil
                    tail = p
                } else {
                    head = nil
                    tail = nil
                }
            } else {
                print("Error")
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
#if DEVELOPING
let testData = TestData("""
8
0 red
2
3
0 red
1 blue
0 orange
2
3
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
