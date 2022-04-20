import Foundation

func main() {
    _ = read()
    let a = read().asList(ofInt)
    
    var counts = [Int](repeating: 0, count: 500001)
    
    for k in a {
        var i = 1
        while i * i <= k {
            if k.isMultiple(of: i) {
                counts[i] += 1
                if i * i != k {
                    let j = k / i
                    counts[j] += 1
                }
            }
            i += 1
        }
    }
    
    let q = read().asInt()
    for _ in 0 ..< q {
        let x = read().asInt()
        print(counts[x])
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
51 13 26 91 102
5
13
2
17
2
3
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
