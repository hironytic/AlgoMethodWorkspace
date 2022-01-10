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
    let p = [-1] + read().asList(ofInt)

    // 各頂点の子のリストを作成
    var c = [[Int]](repeating: [], count: n)
    for (i, pi) in p.enumerated() {
        if i != 0 {
            c[pi].append(i)
        }
    }

    var ans = [Int](repeating: -1, count: n)

    func traverse(_ x: Int, depth: Int) {
        ans[x] = depth
        for ci in c[x] {
            traverse(ci, depth: depth + 1)
        }
    }

    traverse(0, depth: 0)
    
    for depth in ans {
        print(depth)
    }
}

// ----------------------------------------------------------
// CodeTemplateのread()をこっちに差し替えれば
// 標準入力の代わりにコードで入力を与えられる。
let testData = TestData("""
7
0 1 0 0 1 5
""")
func read() -> String {
    return testData.read()
}

main()
