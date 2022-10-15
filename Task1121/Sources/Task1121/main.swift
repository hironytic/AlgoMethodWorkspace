import Foundation

struct ColorSet {
    var bits = [UInt64](repeating: 0, count: 4)
    
    init() {
    }
    
    private func slot(of color: Int) -> (index: Int, mask: UInt64) {
        return (index: color / 64, mask: 1 << (color % 64))
    }
    
    var isEmpty: Bool {
        return !bits.contains { $0 > 0 }
    }
    
    func contains(_ color: Int) -> Bool {
        let (index, mask) = slot(of: color)
        return bits[index] & mask != 0
    }
    
    mutating func insert(_ color: Int) {
        let (index, mask) = slot(of: color)
        bits[index] |= mask
    }
    
    mutating func intersect(with other: ColorSet) {
        for i in 0 ..< 4 {
            bits[i] &= other.bits[i]
        }
    }
}

func main(read: () -> String) {
    let (N, M) = read().asList(ofInt).asTuple()
    let W = read().asList(ofInt)
    let C = read().asList(ofInt)

    // dp[i][j]
    // i-1番目のボールまでを選ぶか選ばないかしたときに、重さがjになるボールの入れ方が
    // 存在するかどうか。
    // 存在しなければnil、存在すればそのパターンなら必ず存在するという色を含むColorSet
    var dp: [[ColorSet?]] = .init(repeating: .init(repeating: nil, count: M), count: N + 1)
    dp[0][0] = ColorSet()
    
    func update(_ i: Int, _ j: Int, value: ColorSet) {
        if var cs = dp[i][j] {
            if cs.isEmpty {
                dp[i][j] = value
            } else {
                cs.intersect(with: value)
                dp[i][j] = cs
            }
        } else {
            dp[i][j] = value
        }
    }
    
    for i in 0 ..< N {
        for j in 0 ..< M {
            guard var cs = dp[i][j] else { continue }
            
            // i番目のボールを選ばない場合
            update(i + 1, j, value: cs)
            
            // i番目のボールを選ぶ場合
            if (!cs.contains(C[i])) { // 同じ色を含んでいたら選べない
                let nj = j + W[i]
                if nj == M {
                    print("Yes")
                    return
                } else if nj < M {
                    cs.insert(C[i])
                    update(i + 1, nj, value: cs)
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
