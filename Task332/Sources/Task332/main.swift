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

/// nは素数か？（n >= 2 を指定する）
func isPrimeNumber(_ n: Int) -> Bool {
    var result = true
    var i = 2
    while i * i <= n {
        if n.isMultiple(of: i) {
            result = false
            break
        }
        i += 1
    }
    return result
}

func main() {
    let (a, b) = read().asList(ofInt).asTuple()
    
    var flags = [Bool](repeating: true, count: b - a + 1)
    
    for i in 0 ... b - a {
        if flags[i] {
            let n = i + a
            if !isPrimeNumber(n) {
                flags[i] = false
            } else if n + n <= b {
                for j in stride(from: n + n, through: b, by: n) {
                    flags[j] = false
                }
            }
        }
    }

    print(flags.lazy.filter { $0 }.count)
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
999999990000 1000000000000
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
