import Foundation

func main(read: () -> String) {
    let (N, A, B) = read().asList(ofInt).asTuple()
    let P = read().asList(ofInt)
    let Q = read().asList(ofInt)
    let R = read().asList(ofInt)
    let price = [P, Q, R]
    
    // dp[i][j][k]
    // i日目にjの店で買った場合のi日目までの水草の価格の総和の最小値
    // ここで
    // j=0,1,2: それぞれX,Y,Zで買った場合
    // k=0,1: それぞれ連続購入が0日,1日以上の場合
    var dp: [[[Int]]] = .init(repeating: .init(repeating: .init(repeating: Int.max, count: 2), count: 3), count: N)
    
    dp[0][0][0] = price[0][0]
    dp[0][1][0] = price[1][0]
    dp[0][2][0] = price[2][0]
    
    func update(_ i: Int, _ j: Int, _ k: Int, value: Int) {
        dp[i][j][k] = min(dp[i][j][k], value)
    }
    
    for i in 1 ..< N {
        for j in 0 ... 2 { // 前日に買ったお店
            for k in 0 ... 1 where dp[i - 1][j][k] != Int.max { // 連続購入
                for s in 0 ... 2 { // 当日買ったお店
                    var p = dp[i - 1][j][k] + price[s][i]
                    if j == s {
                        if k == 0 {
                            p -= A
                        } else {
                            p -= B
                        }
                        update(i, s, 1, value: p)
                    } else {
                        update(i, s, 0, value: p)
                    }
                }
            }
        }
    }
    
    let ans = dp[N - 1].reduce(Int.max) { min($0, $1.min()!) }
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
