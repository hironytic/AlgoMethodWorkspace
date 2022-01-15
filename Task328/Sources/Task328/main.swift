import Foundation

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

func main() {
    let n = 100
    
    var flags = [Bool](repeating: true, count: n + 1)
    flags[0] = false

    var count5 = 0
    for i in 2 ... n {
        if flags[i] && i < n {
            for j in i + 1 ... n {
                if flags[j] && j.isMultiple(of: i) {
                    flags[j] = false
                }
            }
        }
        if i == 5 {
            count5 = flags.lazy.filter { $0 }.count
        }
    }
    let countN = flags.lazy.filter { $0 }.count
    
    print(count5 - countN)
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
