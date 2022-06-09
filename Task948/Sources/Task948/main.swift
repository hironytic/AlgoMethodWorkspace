import Foundation

func main() {
    let n = read().asInt()
    let s = read().map { $0 == "(" ? 1 : -1 }
    let c = read().asList(ofInt)
    
    var dp = [[Int: Int]](repeating: [:], count: n + 1)
    dp[0][0] = 0
//    print("0 → \(dp[0])")

    for i in 0 ..< n {
        for (j, cost) in dp[i] {
            for (jNext, costNext) in [
                (j + s[i], cost),        // 反転しない場合
                (j - s[i], cost + c[i]), // 反転する場合
            ] {
                if jNext < 0 {
                    // マイナスになってしまうものは条件を満たさないのでスキップ
                    continue
                }
                
                let cN = dp[i + 1][jNext, default: Int.max]
                dp[i + 1][jNext] = min(cN, costNext)
            }
        }
        
//        print("\(i + 1) → \(dp[i + 1])")
    }
    if let ans = dp[n][0] {
        print(ans)
    } else {
        print(-1)
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
6
()(())
3 1 4 1 5 9
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
