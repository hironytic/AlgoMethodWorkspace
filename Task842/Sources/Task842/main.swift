import Foundation

func main() {
    let (h, w) = read().asList(ofInt).asTuple()
    var column = [Int](repeating: 0, count: w)
    var row = [Int](repeating: 0, count: h)
    var cell = [[Bool]](repeating: [Bool](repeating: false, count: w), count: h)
    
    for r in 0 ..< h {
        let line = read()
        var index = line.startIndex
        for c in 0 ..< w {
            let x = line[index]
            index = line.index(after: index)
            if x != "." {
                cell[r][c] = true
                row[r] += 1
                column[c] += 1
            }
        }
    }
    
    let qc = read().asInt()
    for _ in 0 ..< qc {
        let (p, q) = read().asList(ofInt).asTuple()
        print(row[p] + column[q] + (cell[p][q] ? -1 : 0))
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
3 3
##.
##.
...
3
0 2
2 2
1 1
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
