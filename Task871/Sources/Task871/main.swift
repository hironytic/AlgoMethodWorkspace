import Foundation

func main() {
    let (n, q) = read().asList(ofInt).asTuple()
    
    var follower = [Set<Int>](repeating: .init(), count: n)
    
    for _ in 0 ..< q {
        let query = read().asList(ofInt)
        switch query[0] {
        case 0:
            follower[query[2]].insert(query[1])
        case 1:
            follower[query[2]].remove(query[1])
        case 2:
            let z = query[1]
            let zFollower = follower[z]
            print(follower.enumerated().filter { $0.offset != z && $0.element == zFollower }.count)
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
5 7
0 2 4
0 3 2
0 3 0
1 3 2
0 3 4
0 3 2
2 0
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
