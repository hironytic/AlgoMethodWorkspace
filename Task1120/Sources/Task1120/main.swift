import Foundation

func main(read: () -> String) {
    let (N, K) = read().asList(ofInt).asTuple()
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

    func isOK(x: Int) -> Bool {
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

        return dp[N] >= K
    }
    
    let ans = binarySearchThreshold(low: 0, high: 200001) { x in !isOK(x: x) } - 1
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
/// 二分探索を行います。
/// O(log n)
/// - Parameters:
///   - low: 下限インデックス
///   - high: 上限インデックス
///   - judge: 値を比較するクロージャー。
///            引数に渡されたインデックスの値が期待するものより小さければ負の数、大きければ正の数、同じなら0を返します。
/// - Throws: 引数に渡したクロージャーが投げたエラー
/// - Returns: 結果のタプル。
///            0番目の要素は見つかったかどうか（見つかればtrue）、1番目の要素は見つかったインデックスまたは見つからなかったときは期待する値を挿入するべきインデックス
func binarySearch(low: Int, high: Int, judge: (Int) throws -> Int) rethrows -> (Bool, Int) {
    var low = low
    var high = high

    while low <= high {
        let mid = low + (high - low) / 2
        let compResult = try judge(mid)
        if compResult < 0 {
            low = mid + 1
        } else if compResult > 0 {
            high = mid - 1
        } else {
            // 見つかった
            return (true, mid)
        }
    }
    
    // 見つからなかった
    return (false, low)
}
// ----------------------------------------------------------
/// ある閾値以上になると条件を満たすようになる場合の、その閾値を二分探索で求めます。
/// つまり、条件を満たす最小の値を返します。
/// 上限値（high）でも条件を満たさなければ high + 1 が返ります。
/// - Parameters:
///   - low: 下限値
///   - high: 上限値
///   - judge: 引数に渡された値が条件を満たすかどうかを返すクロージャー
/// - Throws: 引数に渡したクロージャーが投げたエラー
/// - Returns: 条件を満たす最小の値を返します。
func binarySearchThreshold(low: Int, high: Int, judge: (Int) throws -> Bool) rethrows -> Int {
    return try binarySearch(low: low, high: high) { try judge($0) ? 1 : -1 }.1
}
// ----------------------------------------------------------

#if DEVELOPING
validate(main)
#else
main { readLine()! }
#endif
