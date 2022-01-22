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

extension Int {
    /// 約数の配列を返します。
    /// 配列はソートされていたりはしないので必要なら戻り値をソートしてください
    /// - Returns: 約数を入れた配列
    func divisors() -> [Int] {
        var result = [Int]()
        var i = 1
        while i * i <= self {
            if isMultiple(of: i) {
                result.append(i)
                if i * i != self {
                    result.append(self / i)
                }
            }
            i += 1
        }
        return result
    }
}

func main() {
    let n = read().asInt()
    let divisors = n.divisors()
    let ans = divisors.reduce(0, +) - n == n
    print(ans ? "Yes" : "No")
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
33550336
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
