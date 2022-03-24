import Foundation

func main() {
    _ = read()
    var a = read().asList(ofInt)
    let q = read().asInt()
    for _ in 0 ..< q {
        let query = read().asList(ofInt)
        if query[0] == 0 {
            a.insert(query[2], at: query[1])
        } else if query[0] == 1 {
            a.remove(at: query[1])
        } else if query[0] == 2 {
            let count = a.reduce(0, { acc, value in
                acc + ((value == query[1]) ? 1 : 0)
            })
            print(count)
        }
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
5
0 1 4 6 8
5
0 5 10
0 1 2
1 2
2 2
2 3
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
