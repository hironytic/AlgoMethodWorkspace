import Foundation

func main() {
    let (N, M) = read().asList(ofInt).asTuple()
    var g = [[Int]](repeating: [], count: N)
    for _ in 0 ..< M {
        let (a, b) = read().asList(ofInt).asTuple()
        g[a].append(b)
        g[b].append(a)
    }
    var painted = [Bool?](repeating: nil, count: N)
    
    func paint(from v: Int, value: Bool) -> Bool {
        if let p = painted[v] {
            return p == value
        }
        painted[v] = value
        for nv in g[v] {
            if !paint(from: nv, value: !value) {
                return false
            }
        }
        return true
    }
    
    for i in 0 ..< N {
        guard painted[i] == nil else { continue }
        if !paint(from: i, value: true) {
            print("No")
            return
        }
    }
    print("Yes")
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
9 9
5 3
7 1
5 4
8 7
6 3
5 2
3 0
1 8
0 4
6 2
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
