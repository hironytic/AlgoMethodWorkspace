import Foundation

func main(read: () -> String) {
    let N = read().asInt()
    let A: [[Int]] = (0 ..< 2).map { _ in read().asList(ofInt) }
    
    // dp[j][k]
    // j列目まで塗ったときの塗った数字の総和の最小値
    // ただし、kによってj列目をどこに塗ったかが決まる
    // k=0: 0行目を塗った
    // k=1: 1行目を塗った
    // k=2: 0行目も1行目も塗った
    var dp: [[Int]] = .init(repeating: .init(repeating: Int.max, count: 3), count: N)
    
    func update(_ j: Int, _ k: Int, value: Int) {
        dp[j][k] = min(dp[j][k], value)
    }
    
    dp[0][0] = A[0][0]
    dp[0][1] = A[1][0]
    dp[0][2] = A[0][0] + A[1][0]
    
    for j in 1 ..< N {
        for k in 0 ..< 3 {
            let value = dp[j - 1][k]
            guard value != Int.max else { continue }
            
            // 0行目だけを塗る場合
            // k==0のときはj-1列目の1行目が白なので、
            // 0行目だけを塗ると（=1行目は塗らないと）白が連続してしまうので
            // この選択はない
            if k != 0 {
                update(j, 0, value: value + A[0][j])
            }
            
            // 1行目だけを塗る場合
            // k==1のときはj-1列目の0行目が白なので、
            // 1行目だけを塗ると（=0行目は塗らないと）白が連続してしまうので
            // この選択はない
            if k != 1 {
                update(j, 1, value: value + A[1][j])
            }
            
            // 0行目も1行目も塗る場合
            update(j, 2, value: value + A[0][j] + A[1][j])
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
