import Foundation

func main() {
    let (_, l) = read().asList(ofInt).asTuple()
    let a = read().asList(ofInt)

    var queue = ArraySlice<Int>();
    var total = 0
    var count = 0
    for ea in a {
        let plus = max(ea - total, 0)
        total += plus
        queue.append(plus)
        if queue.count >= l {
            let minus = queue.popFirst()!
            total -= minus
            count += minus
        }
    }
    print(count + total)
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
7 3
3 1 4 1 5 9 2
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
