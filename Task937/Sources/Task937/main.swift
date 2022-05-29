import Foundation

func main() {
    let (h, w) = read().asList(ofInt).asTuple()
    let cell: [[Bool]] = (0 ..< h).map { _ in
        return read().map { $0 == "#" }
    }
    
    // 左上が黒になる場合に、(i, j) が黒かどうか
    func shouldBeBlack(_ i: Int, _ j: Int) -> Bool {
        let left = i % 2
        return j % 2 + left != 1
    }
        
    var ltb = 0 // 左上を黒にする場合
    var ltw = 0 // 左上を白にする場合
    for i in 0 ..< h {
        for j in 0 ..< w {
            let actual = cell[i][j]
            let expected = shouldBeBlack(i, j)
            if actual != expected {
                ltb += 1
            } else {
                ltw += 1
            }
        }
    }
    print(min(ltb, ltw))
}

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
#if DEVELOPING
let testData = TestData("""
6 2
##
#.
..
.#
##
#.
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
