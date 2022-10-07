import Foundation

func main(read: () -> String) {
    let (N, A) = read().asList(ofInt).asTuple()
    let digits: [Int] = { () -> [Int] in
        var result = [Int]()
        var n = N
        while n > 0 {
            result.append(n % 10)
            n /= 10
        }
        return result.reversed()
    }()
    
    // dp[i][j][k]
    // 上からi桁の和をAで割った余りがjになるものがいくつあるか
    // k=0: N未満かどうか未確定のもの
    // k=1: N未満だと確定しているもの
    var dp = [[[Int]]](repeating: .init(repeating: .init(repeating: 0, count: 2), count: A), count: digits.count)
    
    // 一番上の桁で初期化
    for x in 0 ..< digits[0] {
        dp[0][x % A][1] += 1
    }
    dp[0][digits[0] % A][0] += 1
    
    // 次の桁からdpテーブルを埋めていく
    for i in 1 ..< digits.count {
        let d = digits[i]
        for j in 0 ..< A {
            for x in 0 ... 9 {
                if x < d {
                    // 1つ上の桁でN未満と決まっていたものはそのままN未満
                    dp[i][(j + x) % A][1] += dp[i - 1][j][1]
                    // 1つ上の桁でN未満と決まっていなかったものもN未満と決まる
                    dp[i][(j + x) % A][1] += dp[i - 1][j][0]
                } else if x == d {
                    // 1つ上の桁でN未満と決まっていたものはそのままN未満
                    dp[i][(j + x) % A][1] += dp[i - 1][j][1]
                    // 1つ上の桁でN未満と決まっていなかったものは、やはり決まらないまま
                    dp[i][(j + x) % A][0] += dp[i - 1][j][0]
                } else {
                    // 1つ上の桁でN未満と決まっていたものはそのままN未満
                    dp[i][(j + x) % A][1] += dp[i - 1][j][1]
                    // 1つ上の桁でN未満と決まっていなかったものはNを超えることが確定
                }
            }
        }
    }
    
    let ans = dp[digits.count - 1][0][0] // 0以上N未満の数を A で割った余りが 0 のもの
            + dp[digits.count - 1][0][1] // N を A で割った余りが 0 のもの
            - 1                          // 0（Aで割った余りは0）を除く（1以上N未満が欲しいものなので）
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
