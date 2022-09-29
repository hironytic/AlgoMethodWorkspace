import Foundation

func main(read: () -> String) {
    let (N, K) = read().asList(ofInt).asTuple()
    let x = read().asList(ofInt)

    var queue = ArraySlice<(leftIndex: Int, rightIndex: Int)>([(leftIndex: 0, rightIndex: N - 1)])
    var ans = x[N - 1] - x[0]
    var k = K - 2
    while k > 0 {
        guard let (leftIndex, rightIndex) = queue.popFirst() else { preconditionFailure() }
        precondition(rightIndex - leftIndex > 1)
        if rightIndex - leftIndex == 2 {
            // 間に1つだけなのでそこに配置してそれ以上は無理
            let midIndex = leftIndex + 1
            k -= 1
            ans = min(ans, x[midIndex] - x[leftIndex], x[rightIndex] - x[midIndex])
            return
        }
        
        let ideal = (x[leftIndex] + x[rightIndex]) / 2
        let (found, midIndexCandidate) = binarySearch(low: leftIndex, high: rightIndex) { x[$0] - ideal }
        let midIndex: Int
        if found {
            midIndex = midIndexCandidate
        } else {
            if x[midIndexCandidate] - ideal > ideal - x[midIndexCandidate - 1] {
                midIndex = midIndexCandidate - 1
            } else {
                midIndex = midIndexCandidate
            }
        }
        k -= 1
        ans = min(ans, x[midIndex] - x[leftIndex], x[rightIndex] - x[midIndex])

        if midIndex - leftIndex > 1 {
            queue.append((leftIndex: leftIndex, rightIndex: midIndex))
        }
        if rightIndex - midIndex > 1 {
            queue.append((leftIndex: midIndex, rightIndex: rightIndex))
        }
    }
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

#if DEVELOPING
validate(main)
#else
main { readLine()! }
#endif
