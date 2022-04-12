import Foundation

func main() {
    let _ = read()
    let a = read().asList(ofInt)

    var freq = Dictionary<Int, Int>()
    for i in a {
        if let value = freq[i] {
            freq[i] = value + 1
        } else {
            freq[i] = 1
        }
    }

    var ans = Int.max
    var maxCount = 0
    for (i, v) in freq {
        if maxCount < v {
            ans = i
            maxCount = v
        } else if maxCount == v && ans > i {
            ans = i
        }
    }
    print(ans)
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
1
10
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
