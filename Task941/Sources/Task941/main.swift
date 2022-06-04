import Foundation

func main() {
    let (h, w) = read().asList(ofInt).asTuple()
    var cell: [[Bool]] = (0 ..< h).map { _ in
        return read().map { $0 == "#" }
    }
    
    var yoko = [Int](repeating: 0, count: h)
    var tate = [Int](repeating: 0, count: w)
    for i in 0 ..< h {
        for j in 0 ..< w {
            if (cell[i][j]) {
                yoko[i] += 1
                tate[j] += 1
            }
        }
    }
    
    let targets: [(dp: Int, dq: Int)] = [(dp: -1, dq: 0), (dp: 0, dq: -1), (dp: 0, dq: 0), (dp: 0, dq: 1), (dp: 1, dq: 0)]
    
    let q = read().asInt()
    for _ in 0 ..< q {
        let (command, p, q) = read().asList(ofInt).asTuple()
        switch command {
        case 0:
            for t in targets {
                let cp = p + t.dp
                let cq = q + t.dq
                if cp >= 0 && cp < h && cq >= 0 && cq < w {
                    cell[cp][cq].toggle()
                    let d = cell[cp][cq] ? 1 : -1   // 白 → 黒は +1 、黒 → 白は -1
                    yoko[cp] += d
                    tate[cq] += d
                }
            }
        case 1:
            print(yoko[p] + tate[q] - (cell[p][q] ? 1 : 0))
            
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
3 2
..
..
..
5
1 1 0
0 0 1
0 1 1
0 2 1
1 1 0
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
