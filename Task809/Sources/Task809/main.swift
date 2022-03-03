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

// 表が出る確率を p、裏が出る確率を q = (1 - p) として
//
// E[X] = (1 * 表の確率) + (2 * 裏→表の確率) + (3 * 裏→裏→表の確率) + ...
//      = (1 * p) + (2 * q * p) + (3 * q^2 * p) + ...
//      = p * (1 + 2 * q + 3 * q^2 + ...)
//
// ここで
//
//     Sn = 1 + 2 * q + 3 * q^2 + ... + n * q^(n-1)   ... (1)
//
// とすると、
//
// E[X] = lim (p * Sn)
//       n→∞
//
// (1) の両辺を q 倍して
//
// q * Sn =  1 * q + 2 * q^2 + ... + (n-1) * q^(n-1) + n * q^n  ... (2)
//
// (1) から (2) を引いて
//
// Sn - q * Sn  = 1 + q + q^2 + ... + q^(n-1) - n * q^n
// (1 - q) * Sn = 1 + q + q^2 + ... + q^(n-1) - n * q^n
//
// 1 - q = p なので
//
// p * Sn =  1 + q + q^2 + ... + q^(n-1) - n * q^n
//          n
//        = Σ q^(k-1)  - n * q^n
//          k=1
//
// q < 1 なので、n → ∞ では、 n * q^n → 0 より、
//
//                     ∞
// E[X] = lim p * Sn = Σ q^(k-1)
//       n→∞         k=1
//
// 無限等比級数の公式を使って、
//
//                   = 1 / (1 - q)
//
// 1 - q = p なので
//
// E[X] = 1 / p

func main() {
    let p = Double(read().asInt()) / 100.0
    print(1 / p)
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
9
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
