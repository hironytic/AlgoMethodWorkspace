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
    func asTuple() -> (Element, Element, Element, Element) { (self[0], self[1], self[2], self[3]) }
}
// ----------------------------------------------------------

func main() {
    let (h, w) = read().asList(ofInt).asTuple()
    let (x0, y0, x1, y1) = read().asList(ofInt).asTuple() // 縦がX、横がYかよ！
    
    // s[i][j] が true なら白（移動できる）、 false なら黒（移動できない）
    let s: [[Bool]] = (0 ..< h).map { _ in
        return read().map { c in c == "W" }
    }

    // g[i][j] ... (i, j)に何会の移動で辿り着けるか（未探索は -1）
    var g = [[Int]](repeating: [Int](repeating: -1, count: w), count: h)

    // 答えをエラーにするな。ひどいコードだ。
    struct AnswerError: Error {
        var answer: Int
    }
    
    g[x0][y0] = 0
    var queue: [(Int, Int)] = [(x0, y0)]
    do {
        while !queue.isEmpty {
            let (x, y) = queue.removeFirst()
            let count = g[x][y] + 1

            func move(_ x: Int, _ y: Int) throws {
                guard x >= 0 && x <= h - 1
                        && y >= 0 && y <= w - 1
                        && s[x][y]
                        && g[x][y] == -1 else { return }
                
                g[x][y] = count
                if x == x1 && y == y1 {
                    throw AnswerError(answer: count)
                }
                queue.append((x, y))
            }

            try move(x - 1, y) // 上
            try move(x + 1, y) // 下
            try move(x, y - 1) // 左
            try move(x, y + 1) // 右
        }
    } catch let e {
        print((e as! AnswerError).answer)
    }
}

// ----------------------------------------------------------
// CodeTemplateのread()をこっちに差し替えれば
// 標準入力の代わりにコードで入力を与えられる。
let testData = TestData("""
5 5
2 2 0 0
WWWWW
BBBBW
WWWBW
WBBBW
WWWWW
""")
func read() -> String {
    return testData.read()
}

main()
