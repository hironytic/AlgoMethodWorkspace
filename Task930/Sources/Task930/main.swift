import Foundation

func main() {
    let (h, w) = read().asList(ofInt).asTuple()
    let cell: [[Bool]] = (0 ..< h).map { _ in
        read().map { $0 == "#" }
    }
    
    func bomb(_ x: Int, _ y: Int) -> Int {
        guard x >= 0 && y >= 0 && x < h && y < w else { return 0 }
        return cell[x][y] ? 1 : 0
    }

    let q = read().asInt()
    for _ in 0 ..< q {
        let (x, y) = read().asList(ofInt).asTuple()
        let a =  bomb(x - 1, y) + bomb(x, y - 1) + bomb(x, y + 1) + bomb(x + 1, y)
        print(a)
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
6 1
#
.
.
#
.
#
2
1 0
4 0
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
