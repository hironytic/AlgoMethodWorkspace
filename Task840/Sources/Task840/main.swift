import Foundation

func main() {
    let (h, w) = read().asList(ofInt).asTuple()
    let cell = (0 ..< h).map { _ in
        read().map { $0 != "." }
    }
    let (p, q) = read().asList(ofInt).asTuple()
    
    var count = 0
    for i in 0 ..< w {
        if cell[p][i] {
            count += 1
        }
    }
    for i in 0 ..< h {
        if cell[i][q] {
            count += 1
        }
    }
    if cell[p][q] {
        count -= 1
    }
    print(count)
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
3 3
##.
##.
...
2 2
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
