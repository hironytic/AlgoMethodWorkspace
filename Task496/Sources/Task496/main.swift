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

/// ユークリッドの互除法を用いて最大公約数を求めます。
/// O(log b)
/// - Parameters:
///   - a: 1つ目の整数（正の整数）
///   - b: 2つ目の整数（正の整数）
/// - Returns: a と b の最大公約数
func gcd(_ a: Int, _ b: Int) -> Int {
    guard b != 0 else { return a }
    return gcd(b, a % b)
}

/// 最大公約数を求めます。
/// O(n log x)
/// - Parameter numbers: 正の整数の配列
/// - Returns: 最大公約数
func gcd(_ numbers: [Int]) -> Int {
    return numbers.reduce(0) { acc, x in acc == 0 ? x : gcd(acc, x) }
}

/// どの素数を何乗したものか。例えば base=3, power=2 なら、3の2乗を表す。
struct Factor: Hashable {
    var base: Int   // 素数
    var power: Int  // 乗数
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

func main() {
    _ = read().asInt()
    let a = read().asList(ofInt)
    let g = gcd(a)
    let factors = g.factorization()
    let ans = factors.reduce(1) { acc, f in acc * (f.power + 1) }
    print(ans)
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
3
5848999832880 8144890171920 1951286673546
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
