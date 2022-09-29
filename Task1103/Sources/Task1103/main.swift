import Foundation

var x: [Int] = []

struct Section: Comparable {
    var leftIndex: Int
    var rightIndex: Int
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        return x[lhs.rightIndex] - x[lhs.leftIndex] == x[rhs.rightIndex] - x[lhs.rightIndex]
    }
    
    static func < (lhs: Section, rhs: Section) -> Bool {
        return x[lhs.rightIndex] - x[lhs.leftIndex] < x[rhs.rightIndex] - x[lhs.rightIndex]
    }
}

func main(read: () -> String) {
    let (N, K) = read().asList(ofInt).asTuple()
    x = read().asList(ofInt)

    var queue = Heap<Section>(keys: [.init(leftIndex: 0, rightIndex: N - 1)])
    var ans = x[N - 1] - x[0]
    var k = K - 2
    while k > 0 {
        guard let section = queue.popFirst() else { preconditionFailure() }
        let (leftIndex, rightIndex) = (section.leftIndex, section.rightIndex)
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
            queue.push(.init(leftIndex: leftIndex, rightIndex: midIndex))
        }
        if rightIndex - midIndex > 1 {
            queue.push(.init(leftIndex: midIndex, rightIndex: rightIndex))
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
/// ヒープ
struct Heap<Key: Comparable> {
    private var keys: [Key]

    init() {
        self.init(keys: [])
    }
    
    init(keys: [Key]) {
        self.keys = keys
        
        // 条件を満たすように並べ替える
        var px = (self.keys.count - 2) / 2  // 最後の葉の親
        while px >= 0 {
            swapDown(from: px)
            px -= 1
        }
    }
    
    /// キーを追加します。
    /// - Parameter key: キー
    mutating func push(_ key: Key) {
        var ix = keys.count
        keys.append(key)
        while ix > 0 {
            let pix = (ix - 1) / 2
            if keys[pix] >= keys[ix] {
                break
            }
            keys.swapAt(ix, pix)
            ix = pix
        }
    }
    
    /// 一番大きなキーを返します。
    /// - Returns: 一番大きなキー。1つもキーがなければ `nil` 。
    var first: Key? {
        return keys.first
    }
    
    /// 一番大きなキーを取り除きます。
    /// - Returns: 取り除いたキー。1つもキーがなければ `nil` 。
    mutating func popFirst() -> Key? {
        guard let firstKey = keys.first else { return nil }
        guard let key = keys.popLast() else { return nil }
        if !keys.isEmpty {
            keys[0] = key
            swapDown(from: 0)
        }
        return firstKey
    }
    
    /// 指定された頂点のキーがヒープの条件を満たすように子孫とキーを交換していきます。
    /// - Parameter from: 頂点
    private mutating func swapDown(from: Int) {
        let count = keys.count
        let key = keys[from]
        var i = from
        while 2 * i + 1 < count {   // 左の子の頂点 (2 * i + 1) があれば
            var ci = 2 * i + 1      // 左の子の頂点番号
            var ckey = keys[ci]     // 左の子のキー
            if ci + 1 < count {          // 右の子の頂点 (ci + 1  ==  2 * i + 2) があれば
                let ckey2 = keys[ci + 1] // 右の子のキー
                if ckey < ckey2 {        // 右の子のキーの方が大きければそちらで上書き
                    ci += 1
                    ckey = ckey2
                }
            }
            if key >= ckey {
                break
            }

            keys.swapAt(i, ci)
            i = ci
        }
    }
}
extension Heap {
    init<S: Sequence>(keys: S) where S.Element == Key {
        self.init(keys: Array(keys))
    }
}
// ----------------------------------------------------------

#if DEVELOPING
validate(main)
#else
main { readLine()! }
#endif
