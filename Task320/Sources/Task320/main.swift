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

/// nは素数か？（n >= 2 を指定する）
func isPrimeNumber(_ n: Int) -> Bool {
    var result = true
    var i = 2
    while i * i <= n {
        if n.isMultiple(of: i) {
            result = false
            break
        }
        i += 1
    }
    return result
}

func main() {
    let n = read().asInt()
    
    for i in (2 ... n).reversed() {
        if isPrimeNumber(i) {
            print(i)
            break
        }
    }
}

// ----------------------------------------------------------
// CodeTemplateのread()をこっちに差し替えれば
// 標準入力の代わりにコードで入力を与えられる。
let testData = TestData("""
998244356
""")
func read() -> String {
    return testData.read()
}

main()
