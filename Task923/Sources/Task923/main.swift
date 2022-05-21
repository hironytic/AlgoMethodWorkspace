import Foundation

func main() {
    let h = read().asInt()
    var mx = 1
    for _ in 0 ..< h {
        mx *= 2
    }
    mx -= 2 // 子を持つ頂点の最大の番号
    
    let q = read().asInt()
    for _ in 0 ..< q {
        let (t, v) = read().asList(ofInt).asTuple()
        switch t {
        case 0: // 親
            if v > 0 {
                print((v - 1) / 2)
            } else {
                print(-1)
            }
        case 1: // 左の子
            if v <= mx {
                print(2 * v + 1)
            } else {
                print(-1)
            }
        case 2: // 右の子
            if v <= mx {
                print(2 * v + 2)
            } else {
                print(-1)
            }
        default:
            break
        }
    }
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
20
6
0 0
2 91
1 36
2 468970
0 5538
1 1973401
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
