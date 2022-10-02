import Foundation

func main(read: () -> String) {
    let (N, M) = read().asList(ofInt).asTuple()
    let W = read().asList(ofInt)
    
    // dp[i][j] … ボールを先頭からi個目まで、選ぶか選ばないかしたときに、
    //             重さがjになるものがあればそのときの選んだボールの個数。
    //             -1なら重さjになるパターンはない。
    var dp = [[Int]](repeating: .init(repeating: -1, count: M), count: N + 1)
    dp[0][0] = 0
    for i in 1 ... N {
        for j in 0 ..< M where dp[i - 1][j] >= 0 {
            let ballCount = dp[i - 1][j]
            
            // 選ばない場合
            dp[i][j] = ballCount
            
            // 選ぶ場合
            let newBallCount = ballCount + 1
            let weight = j + W[i - 1]
            if weight == M {
                if newBallCount % 2 == 1 {
                    print("Yes")
                    return
                }
            } else if weight < M {
                dp[i][weight] = newBallCount
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
