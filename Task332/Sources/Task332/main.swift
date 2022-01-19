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

func main() {
    let (a, b) = read().asList(ofInt).asTuple()
    
    let sqrtB = Int(sqrt(Double(b)))
    var flagsToSqrtB = [Bool](repeating: true, count: sqrtB + 1)  // 0 ... sqrt(b) が素数か？（※index=2以降のみ使う）
    var flagsAtoB = [Bool](repeating: true, count: b - a + 1) // a ... b が素数か？
    
    if (2 <= sqrtB) {
        for i in 2 ... sqrtB {
            if flagsToSqrtB[i] {
                // flagsToSqrtB の方の i の合成数を落とす
                if i + i <= sqrtB {
                    for j in stride(from: i + i, through: sqrtB, by: i) {
                        flagsToSqrtB[j] = false
                    }
                }

                // flagsAtoB の方の i の合成数を落とす
                let start = ((a + i - 1) / i) * i
                if start <= b {
                    for j in stride(from: start, through: b, by: i) {
                        if j != i { // i 自身は素数なので落としてはいけない
                            flagsAtoB[j - a] = false
                        }
                    }
                }
            }
        }
    }

    print(flagsAtoB.lazy.filter { $0 }.count)
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
999999990000 1000000000000
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
