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
        return result
    }()
    
    // dp[i][j][k]
    // k=0: 下i桁の和をAで割った余りがjになるものがいくつあるか
    // k=1: dp[i][j][0]のうち、i桁目がdigits[i]より小さい場合のものがいくつか
    var dp = [[[Int]]](repeating: .init(repeating: .init(repeating: 0, count: 2), count: A), count: digits.count + 1)
    dp[0][0][0] = 1
    dp[0][0][1] = 1

    // dpテーブルを埋めてゆく
    // この結果、すべてのi, jに対するdp[i][j][1]が求まる
    for i in 0 ..< digits.count {
        for j in 0 ..< A where dp[i][j][0] > 0 {
            let dpij0 = dp[i][j][0]
            for x in 0 ... 9 {
                let mod = (j + x) % A
                dp[i + 1][mod][0] += dpij0
                if x < digits[i] {
                    dp[i + 1][mod][1] += dpij0
                }
            }
        }
    }

    // 上の桁から足していく
    // 例えば、 N = 357 の場合、 digits は [ 7, 5, 3 ]
    // ループの1回目(i=3)で ans に足すのは、各桁が 0, 0...2, 0...9, 0...9 の数（  0 <= x <= 299）のうち、桁の和がAで割り切れる数の個数
    // ループの2回目(i=2)で ans に足すのは、各桁が 0,     3, 0...4, 0...9 の数（300 <= x <= 349）のうち、桁の和がAで割り切れる数の個数
    // ループの3回目(i=1)で ans に足すのは、各桁が 0,     3,     5, 0...6 の数（350 <= x <= 356）のうち、桁の和がAで割り切れる数の個数
    // ループを抜けたあとに ans に足すのは、各桁が 0,     3,     5,     7 の数（x == 357）       のうち、桁の和がAで割り切れる数の個数
    var ans = 0
    var sum = 0
    for i in (1 ... digits.count).reversed() {
        ans += dp[i][(A - sum) % A][1]
        sum = (sum + digits[i - 1]) % A
    }
    ans += dp[0][(A - sum) % A][1]
    
    // 求めたいのは1以上N以下の数なので、0（必ずAで割り切れる）の分を除く
    ans -= 1
    
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
