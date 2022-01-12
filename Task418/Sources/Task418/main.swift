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
    var g = [[Int]](repeating: [], count: n)
    for _ in 0 ..< m {
        let (a, b) = read().asList(ofInt).asTuple()
        g[a].append(b)
        g[b].append(a)
    }

    var d = [Int](repeating: Int.max, count: n)

    var ans = -1
    var queue = [0]
    d[0] = 0

    while !queue.isEmpty {
        let e = queue.removeFirst()
        let count = d[e] + 1
        
        for i in g[e] {
            // すでにもっと短く辿れることがわかっているならスキップ
            // というか一度辿っていたら（Int.maxじゃなかったら）それが最短のはずだけど。
            if d[i] < count { continue }
            
            d[i] = count
            ans = max(ans, count)
            queue.append(i)
        }
    }
    
    print(ans)
}

// ----------------------------------------------------------
// CodeTemplateのread()をこっちに差し替えれば
// 標準入力の代わりにコードで入力を与えられる。
let testData = TestData("""
5 4
0 1
0 2
0 3
0 4
""")
func read() -> String {
    return testData.read()
}

main()
