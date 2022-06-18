import Foundation

func main() {
    let (N, M, s, t) = read().asList(ofInt).asTuple()
    var g = [[Int]](repeating: [], count: N)
    for _ in 0 ..< M {
        let (a, b) = read().asList(ofInt).asTuple()
        g[a].append(b)
    }
    var seen = [Bool](repeating: false, count: N)
    func travel(from s: Int, to t: Int) -> Bool {
        if s == t { return true }
        if seen[s] { return false }
        seen[s] = true
        
        for next in g[s] {
            if travel(from: next, to: t) {
                return true
            }
        }
        return false
    }
    if travel(from: s, to: t) {
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
    func asTuple() -> (Element, Element, Element, Element) { (self[0], self[1], self[2], self[3]) }
}
// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
4 3 3 0
1 2
2 3
3 1
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
