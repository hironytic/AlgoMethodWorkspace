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

    func traverse(_ x: Int) -> Int {
        var descendants = 0
        for ci in c[x] {
            descendants += traverse(ci)
        }
        ans[x] = descendants
        return descendants + 1 // 自分を追加して返す
    }

    _ = traverse(0)

    for a in ans {
        print(a)
    }
}

// ----------------------------------------------------------
// CodeTemplateのread()をこっちに差し替えれば
// 標準入力の代わりにコードで入力を与えられる。
let testData = TestData("""
7
0 1 0 0 1 4
""")
func read() -> String {
    return testData.read()
}

main()
