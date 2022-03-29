import Foundation

func main() {
    let (n, q) = read().asList(ofInt).asTuple()
    
    var followers = [Set<Int>](repeating: Set(), count: n)
    
    for _ in 0 ..< q {
        let query = read().asList(ofInt)
        switch query[0] {
        case 0:
            followers[query[2]].insert(query[1])
        case 1:
            let f = followers[query[1]]
            if f.isEmpty {
                print("No")
            } else {
                print(f.sorted(by: <).joinedString())
            }
        default:
            break
        }
    }
}

extension Array where Element: LosslessStringConvertible {
    func joinedString(separator: String = " ") -> String {
        return map { String($0) }.joined(separator: separator)
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
3 4
0 2 1
1 1
0 0 1
1 1
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
