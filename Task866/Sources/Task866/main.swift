import Foundation

func main() {
    _ = read()
    let sl = read().asList()
    
    var counts = [Int](repeating: 0, count: 810000)
    
    func hash<S: StringProtocol>(_ str: S) -> Int {
        let cl = str.map { Int($0.asciiValue!) - 97 + 1 } + [Int](repeating: 0, count: 3)
        return cl[0] * 30*30*30 + cl[1] * 30*30 + cl[2] * 30 + cl[3]
    }
    
    for s in sl {
        counts[hash(s)] += 1
    }
    
    let q = read().asInt()
    for _ in 0 ..< q {
        let t = read()
        print(counts[hash(t)])
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
5
aaa aa aaaa a aaa
4
aa
abba
aaa
aaa
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
