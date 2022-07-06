import Foundation

func main() {
    let N = read().asInt()
    let A = read().asList(ofInt)
    let B = read().asList(ofInt)
    
    var dp = [Int](repeating: Int.max, count: N)
    dp[0] = 0
    for i in 0 ..< N - 1 {
        dp[i + 1] = min(dp[i + 1], dp[i] + A[i])
        if i <= N - 3 {
            dp[i + 2] = min(dp[i + 2], dp[i] + B[i])
        }
    }
    print(dp[N - 1])
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
10
3 1 4 1 5 9 2 6 5
3 5 8 9 7 9 3 2
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
