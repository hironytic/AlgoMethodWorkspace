import Foundation

func main() {
    let (N, M, s, t) = read().asList(ofInt).asTuple()
    var G = [[Int]](repeating: [], count: N)
    for _ in 0 ..< M {
        let (a, b) = read().asList(ofInt).asTuple()
        G[a].append(b)
    }
    
    var ans = [Int]()
    var seen = [Bool](repeating: false, count: N)
    func dfs(_ v: Int) -> Bool {
        if v == t {
            return true
        }
        
        for n in G[v] where !seen[n] {
            seen[n] = true
            if dfs(n) {
                ans.append(n)
                return true
            }
        }
        return false
    }
    _ = dfs(s)
    ans.append(s)
    
    print(ans.count)
    print(ans.lazy.reversed().map { String($0) }.joined(separator: " "))
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
    func asTuple() -> (Element, Element, Element, Element) { (self[0], self[1], self[2], self[3]) }
}
// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
4 6 3 0
0 1
3 1
3 2
1 2
2 0
1 3
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
