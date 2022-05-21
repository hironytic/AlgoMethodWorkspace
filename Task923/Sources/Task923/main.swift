import Foundation

func main() {
    let h = read().asInt()
    var pow2 = [Int](repeating: 0, count: h + 1)
    var b = 1
    for i in 0 ... h {
        pow2[i] = b
        b *= 2
    }
    
    func log2(_ n: Int) -> Int {
        var ans = 0
        while ans < pow2.count && n >= pow2[ans] {
            ans += 1
        }
        return ans - 1
    }
    
    let q = read().asInt()
    for _ in 0 ..< q {
        let (t, v) = read().asList(ofInt).asTuple()
        let hv = log2(v + 1)
        let ix = v + 1 - pow2[hv]
        switch t {
        case 0: // 親
            if hv > 0 {
                print(pow2[hv - 1] - 1 + ix / 2)
            } else {
                print(-1)
            }
        case 1: // 左の子
            if hv < h {
                print(pow2[hv + 1] - 1 + ix * 2)
            } else {
                print(-1)
            }
        case 2: // 右の子
            if hv < h {
                print(pow2[hv + 1] - 1 + ix * 2 + 1)
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
