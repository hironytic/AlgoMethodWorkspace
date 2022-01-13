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
    let (n, m) = read().asList(ofInt).asTuple()
    var blocking = [Int](repeating: 0, count: n) // 各課題の依存数
    var depended = [[Int]](repeating: [], count: n) // ある課題に依存している他の課題のリスト
    for _ in 0 ..< m {
        let (f, s) = read().asList(ofInt).asTuple()
        blocking[s] += 1
        depended[f].append(s)
    }
    
    // 依存数が 0 の課題の番号から始める
    var queue = blocking.lazy.enumerated().filter { $0.element == 0}.map { $0.offset }
    
    while !queue.isEmpty {
        let t = queue.removeFirst()
        for s in depended[t] {
            blocking[s] -= 1
            if blocking[s] == 0 {
                queue.append(s)
            }
        }
    }
    
    let ans = !blocking.contains { $0 > 0 }
    print(ans ? "Yes" : "No")
}

// ----------------------------------------------------------
// CodeTemplateのread()をこっちに差し替えれば
// 標準入力の代わりにコードで入力を与えられる。
let testData = TestData("""
3 3
0 2
1 0
2 1
""")
func read() -> String {
    return testData.read()
}

main()
