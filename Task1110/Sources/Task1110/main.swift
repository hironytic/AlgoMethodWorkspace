import Foundation

let D = 1_000_000_007

func main(read: () -> String) {
    let (N, K) = read().asList(ofInt).asTuple()
    let S = read().mapDigit()
    
    // dp[i][j]
    // 先頭からi文字で作れる数値をKで割った余りがjになるのが何通りあるか（を10^9+7で割った余り）
    var dp = [[Int]](repeating: .init(repeating: -1, count: K), count: N + 1)
    dp[0][0] = 1
    
    func add(_ i: Int, _ j: Int,  value: Int) {
        dp[i][j] = (max(dp[i][j], 0) + value) % D
    }
    
    for i in 0 ..< N {
        for j in 0 ..< K where dp[i][j] >= 0 {
            // S[i]を消さない場合
            let d0 = (j * 10 + S[i]) % K
            add(i + 1, d0, value: dp[i][j])
            
            // S[i]を消す場合
            add(i + 1, j, value: dp[i][j])
        }
    }
    let ans = (dp[N][0] + D - 1) % D // 全部消すパターンは余り0になるので、その分を1つ減らす
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
extension StringProtocol {
    /// 数字のみで構成される文字を各桁の数字の配列にします。
    /// 例： `"123"` → `[1, 2, 3]`
    /// - Returns: 数字の桁の配列
    func mapDigit() -> [Int] {
        return map { Int($0.asciiValue! - 48) }
    }
}
// ----------------------------------------------------------

#if DEVELOPING
validate(main)
#else
main { readLine()! }
#endif
