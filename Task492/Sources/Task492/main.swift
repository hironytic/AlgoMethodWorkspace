import Foundation

//func read() -> String { readLine()! }
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
    let n = read().asInt()
    let a = read().asList(ofInt)
    
    let sa = (0 ..< n).sorted { a[$0] > a[$1] }

    var ranks = [Int](repeating: -1, count: n)
    var rank = -1
    var prev = -1
    for i in sa {
        if prev != a[i] {
            rank += 1
        }
        prev = a[i]
        ranks[i] = rank
    }
    for r in ranks {
        print(r)
    }
}

// ----------------------------------------------------------
// CodeTemplateのread()をこっちに差し替えれば
// 標準入力の代わりにコードで入力を与えられる。
let testData = TestData("""
1
1000000000
""")
func read() -> String {
    return testData.read()
}

main()
