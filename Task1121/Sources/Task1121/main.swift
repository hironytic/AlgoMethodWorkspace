import Foundation

func main(read: () -> String) {
    let (N, M) = read().asList(ofInt).asTuple()
    let W = read().asList(ofInt)
    let C = read().asList(ofInt)

    // cw
    // 色 → その色のボールの重さの配列
    var cw = [[Int]](repeating: [], count: 256)
    for i in 0 ..< N {
        cw[C[i]].append(W[i])
    }
    
    // dp[c][j]
    // c-1番目までの色のボールを選ぶか選ばないかしたときに、
    // 重さがjになるボールの入れ方が存在するかどうか。
    var dp: [[Bool]] = .init(repeating: .init(repeating: false, count: M), count: 256 + 1)
    dp[0][0] = true
    
    for c in 0 ..< 256 {
        for j in 0 ..< M where dp[c][j] {
            // c番目の色のボールを選ばない場合
            dp[c + 1][j] = true
            
            // c番目の色のボールを選ぶ場合
            for w in cw[c] {
                let nj = j + w
                if nj == M {
                    print("Yes")
                    return
                } else if nj < M {
                    dp[c + 1][nj] = true
                }
            }
        }
    }
    print("No")
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
