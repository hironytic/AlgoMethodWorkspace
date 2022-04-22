import Foundation

let latinSmallA = Int(Character("a").asciiValue!)
let B = 30
let M = 1000003

func h<S: StringProtocol>(_ str: S) -> Int {
    let chars = str.map { Int($0.asciiValue!) - latinSmallA + 1 }
    let ns = chars.count
    var h = 0
    var b = 1
    for i in 0 ..< ns {
        h += chars[ns - 1 - i] * b
        b *= B
    }
    return h % M
}

func main() {
    _ = read()
    let s = read().asList()
    
    var counts = [Int](repeating: 0, count: M + 1)
    for si in s {
        counts[h(si)] += 1
    }
    
    let mx = counts.reduce(0) { (acc, num) in max(acc, num) }
    print(mx)
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
8
aioeta cucjn gee kqym pannx pausx roput yhpa
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
