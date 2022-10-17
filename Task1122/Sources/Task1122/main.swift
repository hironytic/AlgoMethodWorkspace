import Foundation

func main(read: () -> String) {
    let N = read().asInt()
    let T = read().asList(ofInt)
    let F = read().asList(ofInt)

    // 各問題の開始期限
    let S = F.lazy.enumerated().map { $0.element - T[$0.offset] }

    // 開始期限の早い順に並べかえたときの、各問題の番号
    let PIndex = S.lazy.enumerated().sorted(by: { $0.element < $1.element }).map { $0.offset }
    
    // dp[i][j]
    // PIndexのi-1番目までを解くかスキップするかしたときに
    // 時刻がjになっているときの、解けた問題数の最大
    var dp: [[Int]] = .init(repeating: .init(repeating: Int.min, count: 10001), count: N + 1)
    dp[0][0] = 0

    func update(_ i: Int, _ j: Int, value: Int) {
        dp[i][j] = max(dp[i][j], value)
    }
    
    for i in 0 ..< N {
        let p = PIndex[i]
        for j in 0 ..< 10000 {
            let solved = dp[i][j]
            guard solved != Int.min else { continue }
            
            // 問題pをスキップする場合
            update(i + 1, j, value: solved)
            
            // 問題pをスキップしない場合
            // ただし、その問題の開始期限を過ぎていない場合に限る
            if j <= S[p] {
                update(i + 1, j + T[p], value: solved + 1)
            }
        }
    }
    
    let ans = dp[N].max()!
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
