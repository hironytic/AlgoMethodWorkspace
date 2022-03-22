import Foundation

func main() {
    _ = read()
    var a = read().asList(ofInt)
    let q = read().asInt()
    for _ in 0 ..< q {
        let query = read().asList(ofInt)
        if query[0] == 0 {
            a.append(query[1])
        } else if query[0] == 1 {
            if a.isEmpty {
                print("Error")
            } else {
                print(a.removeLast())
            }
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
2
3 1
7
0 4
1
1
1
1
0 2
1
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
