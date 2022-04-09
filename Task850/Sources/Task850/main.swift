import Foundation

class Node {
    var prev: Int = -1
    var next: Int = -1
    
    init() {
        
    }
}

func main() {
    let n = read().asInt()

    let nodes = (0 ..< n).map { _ in Node() }
    for i in 0 ..< n {
        nodes[i].next = i + 1
        nodes[i].prev = i - 1
    }
    nodes[0].prev = n - 1
    nodes[n - 1].next = 0
    
    var cur = 0
    while (nodes[cur].next != cur) {
        nodes[nodes[cur].prev].next = nodes[cur].next
        nodes[nodes[cur].next].prev = nodes[cur].prev
        cur = nodes[nodes[cur].next].next
    }
    print(cur + 1)
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
2
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
