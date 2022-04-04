import Foundation

class Node {
    let value: String
    var next: Node?
    
    init(value: String, next: Node?) {
        self.value = value
        self.next = next
    }
}

func main() {
    var list: Node? = nil
    let q = read().asInt()
    for _ in 0 ..< q {
        let query = read().asList()
        switch query[0] {
        case "0":
            let newNode = Node(value: String(query[1]), next: list)
            list = newNode
        case "1":
            if let l = list {
                print(l.value)
                list = l.next
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
6
0 red
1
1
0 orange
0 blue
1
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
