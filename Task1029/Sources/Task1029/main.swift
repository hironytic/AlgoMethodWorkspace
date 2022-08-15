import Foundation

func main(read: () -> String) {
    let N = read().asInt()
    let L = read().asList(ofInt).sorted()
    
    func count(lessThanOrEqualTo threshold: Int) -> Int {
        return binarySearchThreshold(low: 0, high: N - 1) { L[$0] > threshold }
    }
    func count(lessThan threshold: Int) -> Int {
        return binarySearchThreshold(low: 0, high: N - 1) { L[$0] >= threshold }
    }
    
    let Q = read().asInt()
    for _ in 0 ..< Q {
        let (a, b) = read().asList(ofInt).asTuple()
        print(count(lessThanOrEqualTo: b) - count(lessThan: a))
    }
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
// ----------------------------------------------------------
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

#if DEVELOPING
validate(main)
#else
main { readLine()! }
#endif
