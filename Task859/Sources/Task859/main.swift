import Foundation

func main() {
    var counts = [Int](repeating: 0, count: 10001)
    for x in -100 ... 100 {
        for y in -100 ... 100 {
            let p = x * x + y * y
            if p <= 10000 {
                counts[p] += 1
            }
        }
    }
    
    let q = read().asInt()
    for _ in 0 ..< q {
        let p = read().asInt()
        print(counts[p])
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
3
5625
9125
10000
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
