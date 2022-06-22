import Foundation

func main() {
    let (N, M) = read().asList(ofInt).asTuple()
    var G = [[Int]](repeating: [], count: N)
    for _ in 0 ..< M {
        let (a, b) = read().asList(ofInt).asTuple()
        G[a].append(b)
    }
    
    var seen = [Bool](repeating: false, count: N)
    var finished = [Bool](repeating: false, count: N)
    func rec(_ v: Int) -> Bool {
        seen[v] = true
        for v2 in G[v] {
            if seen[v2] {
                if !finished[v2] {
                    return true
                }
            } else {
                if rec(v2) {
                    return true
                }
            }
        }
        finished[v] = true
        return false
    }
    
    for v in 0 ..< N {
        if !seen[v] {
            if rec(v) {
                print("Yes")
                return
            }
        }
    }
    print("No")
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
