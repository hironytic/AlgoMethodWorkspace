import Foundation

func main() {
    let n = read().asInt()
    var parent = [Int: Int]()
    for _ in 0 ..< n - 1 {
        let (a, b) = read().asList(ofInt).asTuple()
        parent[b] = a
    }
    let (u, v) = read().asList(ofInt).asTuple()
    
    var step = [Int: Int]()
    var node = u
    var s = 0
    while true {
        step[node] = s
        s += 1
        if node == 0 {
            break
        } else {
            node = parent[node]!
        }
    }
    node = v
    s = 0
    while true {
        if let us = step[node] {
            print(us + s)
            return
        }
        s += 1
        if node == 0 {
            break
        } else {
            node = parent[node]!
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
9
8 7
3 6
6 5
8 1
8 3
6 2
0 8
8 4
7 5
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
