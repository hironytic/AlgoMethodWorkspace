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
extension Array where Element: LosslessStringConvertible {
    func joinedString(separator: String = " ") -> String {
        return map { String($0) }.joined(separator: separator)
    }
}

func main() {
    struct Vertex {
        var phase = -1
        var next = [Int]()
    }
    
    let (n, m) = read().asList(ofInt).asTuple()
    var g = [Vertex](repeating: .init(), count: n)
    for _ in 0 ..< m {
        let (a, b) = read().asList(ofInt).asTuple()
        g[a].next.append(b)
        g[b].next.append(a)
    }

    var ans = [[Int]](repeating: [], count: n)
    
    g[0].phase = 0
    var queue = [0] // 次に探索する頂点
    while !queue.isEmpty {
        let v = queue.removeFirst()
        let phase = g[v].phase
        ans[phase].append(v)
        for n in g[v].next {
            if g[n].phase == -1 { // 未探索なら
                g[n].phase = phase + 1
                queue.append(n)
            }
        }
    }
    
    for a in ans {
        print(a.sorted().joinedString())
    }
}

// ----------------------------------------------------------
// CodeTemplateのread()をこっちに差し替えれば
// 標準入力の代わりにコードで入力を与えられる。
let testData = TestData("""
3 1
0 1
""")
func read() -> String {
    return testData.read()
}

main()
