import Foundation

func main() {
    let n = read().asInt()
    let a = read().asList(ofInt)
    let b = read().asList(ofInt)
    let c = read().asList(ofInt)
    let abc = [a, b, c]

    var dp = [[Int]](repeating: .init(repeating: Int.max, count: 3), count: n)
    dp[0] = [0, 0, 0]
    
    for i in 1 ..< n {
        for j in 0 ..< 3 {
            let sum = dp[i - 1][j]
            let prev = abc[j][i - 1]
            for k in 0 ..< 3 {
                let next = abc[k][i]
                let nextSum = sum + abs(prev - next)
                dp[i][k] = min(dp[i][k], nextSum)
            }
        }
    }
    
//    print("---")
//    for e in dp {
//        print(e)
//    }
//    print("---")

    print(dp[n - 1].min()!)
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
6
3 1 4 1 5 9
2 6 5 3 5 8
9 7 9 3 2 3
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
