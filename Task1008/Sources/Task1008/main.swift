import Foundation

struct TDist: Comparable {
    var d: Int
    var v: Int

    static func == (lhs: TDist, rhs: TDist) -> Bool {
        return lhs.d == rhs.d
    }
    static func < (lhs: TDist, rhs: TDist) -> Bool {
        return lhs.d > rhs.d
    }
}

func main(read: () -> String) {
    let (N, M) = read().asList(ofInt).asTuple()
    var G = [[(to: Int, weight: Int)]](repeating: [], count: N)
    for _ in 0 ..< M {
        let (u, v, w) = read().asList(ofInt).asTuple()
        G[u].append((to: v, weight: w))
    }
    
    var d = [Int](repeating: Int.max, count: N)
    var f = [Bool](repeating: false, count: N)
    var heap = Heap<TDist>()
    
    d[0] = 0
    heap.push(TDist(d: 0, v: 0))
    while let td = heap.popFirst() {
        if f[td.v] { continue }
        
        for (t, w) in G[td.v] {
            let dt = d[t]
            let dt2 = td.d + w
            if dt > dt2 {
                d[t] = dt2
                heap.push(TDist(d: dt2, v: t))
            }
        }
        f[td.v] = true
    }
    
    for di in d {
        print(di)
    }
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
