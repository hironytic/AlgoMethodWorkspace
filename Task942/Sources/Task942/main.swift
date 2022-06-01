import Foundation

struct Location: Hashable {
    var x: Int
    var y: Int
}

func main() {
    let (h, w, n) = read().asList(ofInt).asTuple()
    
    var piece = Set<Location>()
    for _ in 0 ..< n {
        let (x, y) = read().asList(ofInt).asTuple()
        piece.insert(Location(x: x, y: y))
    }
    
    var ans = 0
    for p in piece {
        if piece.contains(Location(x: h - 1 - p.x, y: w - 1 - p.y)) {
            ans += 1
        }
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
5 5 8
0 2
1 4
3 3
3 0
2 0
0 3
3 1
2 2
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
