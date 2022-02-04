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

/// ユークリッドの互除法を用いて最小公倍数を求めます。
/// O(log b)
/// - Parameters:
///   - a: 1つ目の整数
///   - b: 2つ目の整数
/// - Returns: a と b の最小公倍数
func lcm(_ a: Int, _ b: Int) -> Int {
    return a / gcd(a, b) * b
}

/// 最小公倍数を求めます。
/// O(n log x)
/// - Parameter numbers: 正の整数を指定する
/// - Returns: 最小公倍数
func lcm(_ numbers: Int...) -> Int {
    return numbers.reduce(0) { acc, x in acc == 0 ? x : lcm(acc, x) }
}

func main() {
    print(lcm(1, 2, 3, 4, 5, 6, 7, 8, 9, 10))
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
input
1
2 3
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
