import Foundation

func main() {
    _ = read()
    let a = read().asList(ofInt)
    
    var countMap = [Int: Int]()
    for i in a {
        if let c = countMap[i] {
            countMap[i] = c + 1
        } else {
            countMap[i] = 1
        }
    }
    
    let q = read().asInt()
    for _ in 0 ..< q {
        let (query, v) = read().asList(ofInt).asTuple()
        switch query {
        case 0:
            if let c = countMap[v] {
                countMap[v] = c + 1
            } else {
                countMap[v] = 1
            }
            
        case 1:
            countMap[v] = nil
            
        case 2:
            print(countMap[v] ?? 0)
            
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
6
5 5 3 3 100 3
6
0 100
2 7
1 9
1 3
2 100
2 3
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
