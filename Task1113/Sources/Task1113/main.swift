import Foundation

func main(read: () -> String) {
    let (N, A, B) = read().asList(ofInt).asTuple()
    let digits = { () -> [Int] in
        var result = [Int]()
        var n = N
        while n > 0 {
            result.append(n % 10)
            n /= 10
        }
        return result.reversed()
    }()
    let D = digits.count
    
    // dp[i][ma][mb][k]
    // 上からi桁の数字の和をAで割った余りがmaのもののうち、
    // 上からi桁の数字をBで割った余りがmbであるものの個数
    // k=0: そのうちの全体の数字がNより小さいかどうかまだわからないもの
    // k=1: そのうちの全体の数字がNより小さいとわかっているもの
    var dp: [[[[Int]]]] = .init(
        repeating: .init(
            repeating: .init(
                repeating: .init(
                    repeating: 0,
                    count: 2),
                count: B),
            count: A),
        count: digits.count)
    
    // i=0
    for j in 0 ... 9 {
        let ma = j % A
        let mb = j % B
        if j < digits[0] {
            dp[0][ma][mb][1] += 1
        } else if j == digits[0] {
            dp[0][ma][mb][0] += 1
        }
    }
    
    // i>0
    for i in 1 ..< D {
        for a in 0 ..< A {
            for b in 0 ..< B {
                for j in 0 ... 9 {
                    let ma = (a + j) % A
                    let mb = (b * 10 + j) % B
                    if j < digits[i] {
                        // 1つ前でNより小さいと決まっていたものはNより小さい
                        dp[i][ma][mb][1] += dp[i - 1][a][b][1]
                        // 1つ前でNより小さいかわからなかったものもNより小さいと決まる
                        dp[i][ma][mb][1] += dp[i - 1][a][b][0]
                    } else if j == digits[i] {
                        // 1つ前でNより小さいと決まっていたものはNより小さい
                        dp[i][ma][mb][1] += dp[i - 1][a][b][1]
                        // 1つ前でNより小さいかわからなかったものはわからないまま
                        dp[i][ma][mb][0] += dp[i - 1][a][b][0]
                    } else {
                        // 1つ前でNより小さいと決まっていたものはNより小さい
                        dp[i][ma][mb][1] += dp[i - 1][a][b][1]
                        // 1つ前でNより小さいかわからなかったものはNより大きいと決まるのでカウントしない
                    }
                }
            }
        }
    }
    
    var ans = 0
    ans += dp[D - 1][0][0][1] // 0 ..< N のうち、各桁の和がAで割り切れて、数がBで割り切れるものの数
    ans += dp[D - 1][0][0][0] // N のうち、各桁の和がAで割り切れて、数がBで割り切れるものの数
    ans -= 1 // 0の分を除く（0は各桁の和がAで割り切れてBで割り切れるのでカウントに入っている）
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
