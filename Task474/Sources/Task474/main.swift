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
    func asTuple() -> (Element, Element, Element, Element) { (self[0], self[1], self[2], self[3]) }
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

func main() {
    let (a, b, c, d) = read().asList(ofInt).asTuple()
    let w = abs(c - a)
    let h = abs(d - b)
    let ans: Int
    if w == 0 {
        ans = h - 1
    } else if h == 0 {
        ans = w - 1
    } else {
        let g = gcd(w, h)
        ans = g - 1
    }
    print(ans)
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
21 89 987654321 123456789
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
