import Foundation

func main() {
    let x = read().asInt()
    let q = read().asInt()
    
    var finishedCount = 0
    var queue = ArraySlice<Int>()

    for _ in 0 ..< q {
        let (command, param) = read().asList(ofInt).asTuple()
        switch command {
        case 0:
            queue.append(param + x)
        case 1:
            while let first = queue.first, first <= param {
                _ = queue.popFirst()
                finishedCount += 1
            }
            print(finishedCount)
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
10
7
0 8
0 12
0 13
0 17
1 20
1 23
1 25
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
