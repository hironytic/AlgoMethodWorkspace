import Foundation

func main(read: () -> String) {
    let (N, M) = read().asList(ofInt).asTuple()
    let W = read().asList(ofInt)
    
    // dp[i][j][k]
    // ボールを先頭からi個目まで、選ぶか選ばないかしたときに、
    // 重さがjになり、そのときのボールの数が奇数（k: 1）か偶数（k: 0）になるような
    // パターンが存在するならtrue
    var dp = [[[Bool]]](repeating: .init(repeating: .init(repeating: false, count: 2), count: M), count: N + 1)
    dp[0][0][0] = true
    for i in 1 ... N {
        for j in 0 ..< M {
            for k in 0 ..< 2 where dp[i - 1][j][k] {
                // 選ばない場合
                dp[i][j][k] = true
                
                // 選ぶ場合
                let newK = (k + 1) % 2
                let weight = j + W[i - 1]
                if weight == M {
                    if newK == 1 {
                        print("Yes")
                        return
                    }
                } else if weight < M {
                    dp[i][weight][newK] = true
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
