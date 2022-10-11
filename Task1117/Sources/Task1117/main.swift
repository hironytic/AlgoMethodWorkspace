import Foundation

func main(read: () -> String) {
    let (M, N) = read().asList(ofInt).asTuple()
    let A: [[Int]] = (0 ..< M).map { _ in read().asList(ofInt) }

    // 縦に白が隣り合わない塗り方を求めておく
    var masks = [Int]()
    for i in 0 ..< (1 << M) {
        var isOK = true
        for j in 0 ..< M - 1 {
            let m = 0b11 << j
            if ((~i) & m) == m {
                isOK = false
                break
            }
        }
        if isOK {
            masks.append(i)
        }
    }

    func columnSum(_ j: Int, mask: Int) -> Int {
        var result = 0
        for i in 0 ..< M {
            if mask & (1 << i) != 0 {
                result += A[i][j]
            }
        }
        return result
    }
    
    // dp[j][k]
    // j列目まで塗ったときの塗った数字の総和の最小値
    // ただし、j列目はkの各ビットの立っている部分を塗った場合のみ
    var dp: [[Int]] = .init(repeating: .init(repeating: Int.max, count: 1 << M), count: N)
    
    func update(_ j: Int, _ k: Int, value: Int) {
        dp[j][k] = min(dp[j][k], value)
    }
    
    for k in masks {
        update(0, k, value: columnSum(0, mask: k))
    }
    
    for j in 1 ..< N {
        for k in masks {
            let value = dp[j - 1][k]
            guard value != Int.max else { continue }
            
            for nk in masks {
                if k | nk == (1 << M) - 1 {
                    update(j, nk, value: value + columnSum(j, mask: nk))
                }
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
