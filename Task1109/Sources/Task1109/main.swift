import Foundation

// 解説どおり実装してみた

func main(read: () -> String) {
    let (N, K) = read().asList(ofInt).asTuple()
    let A = read().asList(ofInt)
    
    // dp[i][k]
    // index=i（iは0〜）の消し方がkの場合の、A[i]までの総和の最大値
    // ここで、消し方kは、
    // k: 0 → 消さない
    // k: 1 → iは消す範囲の左端
    // k: 2 → iは消す範囲の左から2番目
    //  ...
    // k: K → iは消す範囲の右端
    var dp = [[Int]](repeating: .init(repeating: Int.min, count: K + 1), count: N)
    dp[0][0] = A[0]
    dp[0][1] = 0

    for i in 1 ..< N {
        // 消さない場合
        // 「i - 1も消さない場合」か、「i - 1が消す範囲の右端」のどちらかしかあり得ないので
        // そのどちらかの大きい方に、A[i]を足したものが総和
        dp[i][0] = max(dp[i - 1][0], dp[i - 1][K]) + A[i]
        
        // 消す場合
        for k in 1 ... K {
            // iが消す範囲のk番目に来るのは、i-1がk-1番目に来る場合と同じ
            dp[i][k] = dp[i - 1][k - 1]

            if k == K { // TODO: どうしてこのときだけなのか？あとで考える
                dp[i][k] = max(dp[i][k], dp[i - 1][k])
            }
        }
    }
    
    let ans = max(dp[N - 1][0], dp[N - 1][K])
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
