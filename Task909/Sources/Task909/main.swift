import Foundation

func main() {
    let n = read().asInt()
    let a = read().asList(ofInt)

    var children = [[Int]](repeating: [], count: n)
    for (i, ea) in a.enumerated() {
        children[ea].append(i + 1)
    }

    func count(in v: Int) -> Int {
        var result = 0
        for v2 in children[v] {
            result += 1 + count(in: v2)
        }
        return result
    }

    let v = read().asInt()
    print(count(in: v))
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
6
0 1 2 3 4
3
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
