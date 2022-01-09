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

extension Array where Element == Int {
    func print() {
        Swift.print(map { String($0) }.joined(separator: " "))
    }
}

func main() {
    let (n, m) = read().asList(ofInt).asTuple()
    var g = [[Int]](repeating: [], count: n)
    for _ in 0 ..< m {
        let (a, b) = read().asList(ofInt).asTuple()
        g[a].append(b)
        g[b].append(a)
    }
    
    let (i, _) = g.enumerated().reduce((-1, -1)) { acc, f in
        if acc.1 < f.element.count {
            return (f.offset, f.element.count)
        } else {
            return acc
        }
    }
    
    g[i].sorted().print()
}

// ----------------------------------------------------------
// CodeTemplateのread()をこっちに差し替えれば
// 標準入力の代わりにコードで入力を与えられる。
let testData = TestData("""
5 7
0 2
0 3
1 2
1 4
2 3
2 4
3 4
""")
func read() -> String {
    return testData.read()
}

main()
