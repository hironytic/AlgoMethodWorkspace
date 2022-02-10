import Foundation

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

/// どの素数を何乗したものか。例えば base=3, power=2 なら、3の2乗を表す。
struct Factor: Hashable {
    var base: Int   // 素数
    var power: Int  // 乗数
    
    var number: Int {
        return (0 ..< power).reduce(1) { acc, _ in acc * base }
    }
}

extension Int {
    /// 素因数分解を行います。
    /// - Returns: Factorの配列。これをすべて乗算したものが元の数値です。
    func factorization() -> [Factor] {
        var result = [Factor]()
        var n = self
        var i = 2
        while i * i <= n {
            var power = 0
            while n.isMultiple(of: i) {
                power += 1
                n /= i
            }
            if power > 0 {
                result.append(Factor(base: i, power: power))
            }
            i += 1
        }
        if n > 1 {
            result.append(Factor(base: n, power: 1))
        }
        
        return result
    }
}

func minAPlusB(a: Int, b: Int, factors: ArraySlice<Factor>) -> Int {
    guard !factors.isEmpty else { return a + b }
    
    let f = factors.first!.number
    
    // a の方に入れた場合
    let p = minAPlusB(a: a * f, b: b, factors: factors[factors.index(after: factors.startIndex)...])
    // b の方に入れた場合
    let q = minAPlusB(a: a, b: b * f, factors: factors[factors.index(after: factors.startIndex)...])
    
    return min(p, q)
}

func main() {
    let (g, m) = read().asList(ofInt).asTuple()

    guard m.isMultiple(of: g) else { print(-1); return }
    
    let d = m / g
    let factors = d.factorization()
    let ans = minAPlusB(a: g, b: g, factors: factors[...])
    print(ans)
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
123456789 1234567890
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
