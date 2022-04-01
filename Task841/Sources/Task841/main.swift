import Foundation

func main() {
    let (h, w) = read().asList(ofInt).asTuple()
    var cell = (0 ..< h).map { _ in
        read().map { $0 != "." }
    }
    
    func toggle(_ p: Int, _ q: Int) {
        if (0 ..< h).contains(p) {
            if (0 ..< w).contains(q) {
                cell[p][q].toggle()
            }
        }
    }
    
    // 黒なら1、それ以外なら0を返す
    func isBlack(_ p: Int, _ q: Int) -> Int {
        if (0 ..< h).contains(p) {
            if (0 ..< w).contains(q) {
                return cell[p][q] ? 1 : 0
            }
        }
        return 0
    }
    
    let q = read().asInt()
    for _ in 0 ..<  q {
        let (command, p, q) = read().asList(ofInt).asTuple()
        switch command {
        case 0:
            toggle(p - 1, q)
            toggle(p, q - 1)
            toggle(p, q)
            toggle(p, q + 1)
            toggle(p + 1, q)
            
        case 1:
            print(
                isBlack(p - 1, q) +
                isBlack(p, q - 1) +
                isBlack(p, q) +
                isBlack(p, q + 1) +
                isBlack(p + 1, q)
            )
            
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
