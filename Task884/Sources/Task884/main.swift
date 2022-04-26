import Foundation

func main() {
    let (n, q) = read().asList(ofInt).asTuple()
    
    var a = [Int](repeating: -1, count: n)
    var head = 0
    var tail = 0
    
    for _ in 0 ..< q {
        let query = read().asList(ofInt)
        switch query[0] {
        case 0:
            a[tail] = query[1]
            tail += 1
            if tail == n {
                tail = 0
            }
        case 1:
            a[head] = -1
            head += 1
            if head == n {
                head = 0
            }
        default:
            break
        }
    }
    
    for ea in a {
        print(ea)
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
5 8
0 10
0 20
0 30
0 40
1
1
0 50
1
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
