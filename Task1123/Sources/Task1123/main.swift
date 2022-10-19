import Foundation

func main(read: () -> String) {
    let (M, N, A) = read().asList(ofInt).asTuple()
    let P: [[Int]] = (0 ..< M).map { _ in read().asList(ofInt) }
    
    // dp[d][i]
    // d日目に、店iで購入したときの水草の価格の総和の最小値
    var dp: [[Int]] = .init(repeating: .init(repeating: Int.max, count: M), count: N)
    
    func update(_ d: Int, _ i: Int, value: Int) {
        dp[d][i] = min(dp[d][i], value)
    }
    
    // 0日目
    for i in 0 ..< M {
        update(0, i, value: P[i][0])
    }
    
    // 1日目〜
    for d in 1 ..< N {
        // 前日の時点で一番価格の安いもの
        let lp = dp[d - 1].min()!
        
        for i in 0 ..< M {
            // 前日はそれまでで一番安く済むお店で買い、当日iのお店で買った場合
            update(d, i, value: lp + P[i][d])
            
            // 前日も当日も同じお店iで買った場合
            let pp = dp[d - 1][i]
            if pp != Int.max {
                update(d, i, value: pp + P[i][d] - A)
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
