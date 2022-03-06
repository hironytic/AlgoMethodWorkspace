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

// k番目とk+1番目のマスが異なる色なら X_k = 1、同じ色なら X_k = 0という確率変数 X_i を考える
// シマシマ度は (X_0 + X_1 + ... + X_N-1) + 1
// E[X] = E[X_1] + E[X_2] + ... + E[X_N-1] + 1
// ここで E[X_i] は i によらず 1/2 （∵ 白黒=1、黒白=1、白白=0、黒黒=0）
// E[X] = (n - 1) / 2 + 1

func main() {
    let n = read().asInt()
    print(Double(n - 1) / 2.0 + 1.0)
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
5
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
