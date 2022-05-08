import Foundation

func main() {
    let (_, m) = read().asList(ofInt).asTuple()
    let a = read().asList(ofInt)
    
    var ab2 = Set<Int>()
    for x in a {
        for y in a {
            let x2y2 = x * x + y * y
            if x2y2 < m {
                ab2.insert(x2y2)
            }
        }
    }

    for x in ab2 {
        if ab2.contains(m - x) {
            print("Yes")
            return
        }
    }
    print ("No")
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
2 1000000000000
100000 700000
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
