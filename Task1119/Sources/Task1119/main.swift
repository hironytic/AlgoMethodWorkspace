import Foundation

func main(read: () -> String) {
    let (N, x) = read().asList(ofInt).asTuple()
    let A = read().asList(ofInt)
    
    // 累積和
    var sums: [Int] = [0]
    for a in A {
        sums.append(sums.last! + a)
    }
    // i in from ..< to についての、A[i]の総和
    func sum(from: Int, to: Int) -> Int {
        return sums[to] - sums[from]
    }
    
    // dp[i]
    // A[0] から A[i-1] を条件を満たすように分割したときの分割数の最大
    var dp: [Int] = .init(repeating: 0, count: N + 1)
    
    func update(_ i: Int, value: Int) {
        dp[i] = max(dp[i], value)
    }
    
    dp[0] = 0
    
    for i in 0 ..< N {
        for j in 0 ... i {
            // j ... i が最後の分割区間になる場合を考えると、
            // この最後の区間が条件を満たす（x以上になる）なら、
            // dp[j] がその手前までの区間の最大分割数なので、それに +1 したものが最大分割数になる
            
            // jが0の場合（つまり手前の区間はそもそもない場合）以外で、
            // A[0]からA[j-1]が条件を満たすように分割可能でなければこのパターンはスキップ
            guard j == 0 || dp[j] > 0 else { continue }
            
            if sum(from: j, to: i + 1) >= x {
                update(i + 1, value: dp[j] + 1)
            }
        }
    }
    
    let ans = dp[N]
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
