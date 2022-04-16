import Foundation

func main() {
    let n = read().asInt()
    let a = read().asList(ofInt)
    
    let nums = a.reduce(into: [Int](repeating: 0, count: 100001)) { partialResult, value in
        partialResult[value] += 1
    }.filter { $0 > 1 }
    
    let top = nums.reduce(0) { partialResult, num in
        return partialResult + combination(num, 2)
    }
    let bottom = combination(n, 2)

    print(Double(top) / Double(bottom))
}

// 組み合わせ nCr
// ----------------------------------------------------------
/// n 個の中から r 個を順番関係なく取り出した場合の数を返します。
func combination(_ n: Int, _ r: Int) -> Int {
    return (n - r + 1 ... n).reduce(1, *) / (1 ... r).reduce(1, *)
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
let testData = TestData("""
10
3 1 4 1 5 9 2 6 5 3
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
