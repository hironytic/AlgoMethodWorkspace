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
    
    var scores = [Int](repeating: 0, count: n)
    for i in a {
        scores[i] += 1
    }
    
    let nums = (0 ..< n).sorted { l, r in
        if scores[l] > scores[r] {
            return true
        } else if scores[l] < scores[r] {
            return false
        } else {
            return l < r
        }
    }
    
    for n in nums {
        print(n, scores[n])
    }
}

// ----------------------------------------------------------
// CodeTemplateのread()をこっちに差し替えれば
// 標準入力の代わりにコードで入力を与えられる。
let testData = TestData("""
1
0
""")
func read() -> String {
    return testData.read()
}

main()
