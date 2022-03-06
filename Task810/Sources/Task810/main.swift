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

// すでにi種類揃っているときに、もう1つ揃える（新しい数字を出す）確率を考える。
// k回目で新しい数字を出せると考えると、k-1回すでに出た数字を出して、k回目で新しいのを出すことになるので
// k回目で新しい数字を出せる確率は
//
//   ┌  i  ┐^(k-1)    n-i
//   │ --- │       * -----
//   └  n  ┘           n
//
// すでにi種類揃っているときに、もう1つ揃えるのにかかる回数の期待値 E_i[X] は
//
//            ∞      ┌  i  ┐^(k-1)    n-i
//   E_i[X] = Σ  k * │ --- │       * -----
//            k=1     └  n  ┘           n
//
//             n-i    ∞     ┌  i  ┐^(k-1)
//          = ----- * Σ k * │ --- │
//              n     k=1    └  n  ┘
//
// 無限級数の公式を使って
//
//             n-i           1
//   E_i[X] = ----- * ---------------
//              n     ( 1 - (i/n) )^2
//
//             n-i           1
//          = ----- * ---------------
//              n     ( (n-i) / n )^2
//
//          = n / (n - i)
//
// 最終的に求めたい E[X] は
// 0種類揃っている状態からもう1つ揃える（1種類揃っている状態になる）のにかかる回数の期待値 E_0[X] と、
// 1種類揃っている状態からもう1つ揃える（2種類揃っている状態になる）のにかかる回数の期待値 E_1[X] と、
// ...、
// n-1種類揃っている状態からもう1つ揃える（n種類揃っている状態になる）のにかかる回数の期待値 E_n-1[X]
// の和になる
//
//   E[X] = E_0[X] + E_1[X] + ... + E_n-1[X]

func main() {
    let n = read().asInt()

    var ans = 0.0
    for i in 0 ... n - 1 {
        ans += (Double(n) / (Double)(n - i))
    }
    print(ans)
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
2
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
