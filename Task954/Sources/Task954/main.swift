import Foundation

func main() {
    let (n, m) = read().asList(ofInt).asTuple()
    var g = [[Int]](repeating: [], count: n)
    for _ in 0 ..< m {
        let (a, b) = read().asList(ofInt).asTuple()
        g[a].append(b)
        g[b].append(a)
    }
    
    var visited = Set<Int>()
    func visit(_ v: Int) {
        guard visited.insert(v).inserted else { return }
        for n in g[v] {
            visit(n)
        }
    }
    visit(0)
    print(visited.count == n ? "Yes" : "No")
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
6 8
4 3
0 5
2 5
2 3
4 5
2 1
1 4
2 0
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
