import Foundation

func main() {
    let n = read().asInt()
    
    var players = Set<String>()
    var losers = Set<String>()
    
    for _ in 0 ..< n - 1 {
        let result = read().asList()
        let (a, b) = (result[1].asInt(), result[3].asInt())
        let (s, t) = (String(result[0]), String(result[4]))
        players.insert(s)
        players.insert(t)
        if a > b {
            losers.insert(t)
        } else {
            losers.insert(s)
        }
    }
    
    players.subtract(losers)
    assert(players.count == 1)
    
    print(players.first!)
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
Bob 2 - 3 Edward
Edward 5 - 1 Alice
Cathy 1 - 4 Danny
Danny 0 - 1 Bob
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
