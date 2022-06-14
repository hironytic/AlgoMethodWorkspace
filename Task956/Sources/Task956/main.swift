import Foundation

func main() {
    let (n, m) = read().asList(ofInt).asTuple()
    var g = [[Int]](repeating: [], count: n)
    var group = [Int](repeating: 0, count: n)
    for _ in 0 ..< m {
        let (a, b) = read().asList(ofInt).asTuple()
        g[a].append(b)
        g[b].append(a)
    }
    
    func visit(_ v: Int, group gr: Int) {
        guard group[v] == 0 else { return }
        group[v] = gr
        for next in g[v] {
            visit(next, group: gr)
        }
    }
    
    var ans = 0
    while true {
        guard let v = group.lazy.enumerated().first(where: { $0.element == 0 })?.offset else { break }
        ans += 1
        visit(v, group: ans)
    }
    print(ans)
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
5 1
3 1
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
