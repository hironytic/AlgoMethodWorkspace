import Foundation

func makeSpans(_ a: [Int]) -> [Int] {
    let n = a.count
    var spans = [Int](repeating: -1, count: n)
    for i in 0 ..< n {
        let e = a[i]
        var span = 1

        var j = i - 1
        while true {
            let p = (j >= 0) ? a[j] : 0
            if p < e {
                break
            } else {
                let pspan = spans[j]
                span += pspan
                j -= pspan
            }
        }
        spans[i] = span
    }
    return spans
}

func main() {
    _ = read()
    let a = read().asList(ofInt)

    let lspans: [Int] = makeSpans(a)
    let rspans: [Int] = makeSpans(a.reversed()).reversed()
    
    let ans = a.enumerated()
        .lazy
        .map { i, value in
            return (lspans[i] + rspans[i] - 1) * value
        }
        .max()!
    print(ans)
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
4
2 2 99 2
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
