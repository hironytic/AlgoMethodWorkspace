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
    let (n, m, x) = read().asList(ofInt).asTuple()
    var g = [Set<Int>](repeating: .init(), count: n)
    for _ in 0 ..< m {
        let (a, b) = read().asList(ofInt).asTuple()
        g[a].insert(b)
        g[b].insert(a)
    }

    var ans = Set<Int>()
    
    // f0: アルルの友達
    for f0 in g[x] {
        // f1: f0 の友達
        for f1 in g[f0] {
            // f1 がアルル自身ではなく、f1 がアルルの友達でもないなら追加
            if f1 != x && !g[f1].contains(x) {
                ans.insert(f1)
            }
        }
    }
    
    print(ans.count)
}

// ----------------------------------------------------------
// CodeTemplateのread()をこっちに差し替えれば
// 標準入力の代わりにコードで入力を与えられる。
let testData = TestData("""
6 7 0
0 1
0 5
1 3
1 5
2 3
3 4
4 5
""")
func read() -> String {
    return testData.read()
}

main()
