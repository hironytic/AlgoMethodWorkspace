import Foundation

func main() {
    let (N, M) = read().asList(ofInt).asTuple()
    var G = [[Int]](repeating: [], count: N)
    var deg = [Int](repeating: 0, count: N)
    for _ in 0 ..< M {
        let (a, b) = read().asList(ofInt).asTuple()
        G[b].append(a)
        deg[a] += 1
    }
    
    var order = [Int]()
    var queue = ArraySlice<Int>()
    for v in 0 ..< N {
        if deg[v] == 0 {
            queue.append(v)
        }
    }
    
    while let v = queue.popFirst() {
        order.append(v)
        for v2 in G[v] {
            deg[v2] -= 1
            if deg[v2] == 0 {
                queue.append(v2)
            }
        }
    }
    
    if order.count < N {
        print("Yes")
    } else {
        print("No")
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
7 6
3 2
4 1
2 5
4 0
3 6
0 1
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
