import Foundation

func main(read: () -> String) {
    let N = read().asInt()
    let A = read().asList(ofInt)
    let B = read().asList(ofInt)
    
    // dp[i][j] … 左からi列まで進んだときにi列目がj（0:上(A)の列を塗る、1:下(B)の列を塗る、2:両方の列を塗る)のときの、全体の塗った総和の最小値
    var dp = [[Int]](repeating: .init(repeating: Int.max, count: 3), count: N)
    dp[0][0] = A[0]
    dp[0][1] = B[0]
    dp[0][2] = A[0] + B[0]
    func update(_ i: Int, _ j: Int, _ value: Int) {
        dp[i][j] = min(dp[i][j], value)
    }
    for i in 1 ..< N {
        for j in 0 ..< 3 where dp[i - 1][j] != Int.max {
            let p = dp[i - 1][j]
            switch j {
            case 0, 1: // 1つ手前が片方の列だけ塗った場合
                // そのまま同じ列を塗る場合
                update(i, j, p + ((j == 0) ? A[i] : B[i]))
                // 両方の列を塗る場合
                update(i, 2, p + A[i] + B[i])
                
            case 2: // 1つ手前が両方の列を塗った場合
                // 上の列だけ塗る場合
                update(i, 0, p + A[i])
                // 下の列だけ塗る場合
                update(i, 1, p + B[i])
                // 両方塗る場合
                update(i, 2, p + A[i] + B[i])
                
            default:
                break
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
