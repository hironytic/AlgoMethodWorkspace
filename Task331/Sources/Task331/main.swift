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
    let n = read().asInt()

    var flags = [Bool](repeating: true, count: n + 1)
    flags[0] = false
    flags[1] = false

    for i in 2 ... n {
        if flags[i] && i + i <= n {
            for j in stride(from: i + i, through: n, by: i) {
                flags[j] = false
            }
        }
    }
    
    var count = 0
    for i in 2 ... n / 2 {
        if flags[i] && flags[n - i] {
            count += 1
        }
    }
    
    print(count)
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
1000000
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
