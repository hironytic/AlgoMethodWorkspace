import Foundation

func main(read: () -> String) {
    let (N, A, B) = read().asList(ofInt).asTuple()
    let P = read().asList(ofInt)
    let Q = read().asList(ofInt)
    let R = read().asList(ofInt)
    let price = [P, Q, R]
    
    // dp[i][j]
    // i日目にjの店で買った場合のi日目までの水草の価格の総和の最小値
    // ここで
    // j=0: Xで買った場合（2日以上続けて買った場合を除く）
    // J=1: Yで買った場合（2日以上続けて買った場合を除く）
    // j=2: Zで買った場合（2日以上続けて買った場合を除く）
    // j=3: Xで買った場合（2日以上続けて買った場合）
    // j=4: Yで買った場合（2日以上続けて買った場合）
    // j=5: Zで買った場合（2日以上続けて買った場合）
    var dp: [[Int]] = .init(repeating: .init(repeating: Int.max, count: 6), count: N)
    
    dp[0][0] = price[0][0]
    dp[0][1] = price[1][0]
    dp[0][2] = price[2][0]
    
    func update(_ i: Int, _ j: Int, value: Int) {
        dp[i][j] = min(dp[i][j], value)
    }
    
    for i in 1 ..< N {
        for j in 0 ... 5 where dp[i - 1][j] != Int.max { // 前日に買ったお店
            for k in 0 ... 2 { // 当日買ったお店
                var p = price[k][i]
                if j % 3 == k {
                    if j >= 3 {
                        p -= B
                    } else {
                        p -= A
                    }
                    update(i, k + 3, value: dp[i - 1][j] + p)
                } else {
                    update(i, k, value: dp[i - 1][j] + p)
                }
            }
        }
    }
    
    let ans = dp[N - 1].min()!
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
validate(main)
#else
main { readLine()! }
#endif
