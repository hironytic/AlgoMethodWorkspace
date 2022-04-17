import Foundation

func main() {
    _ = read()
    let a = read().asList(ofInt)
    let q = read().asInt()
    
    var total = 0
    var counts = [Int](repeating: 0, count: 100001)
    for num in a {
        counts[num] += 1
        total += num
    }
    
    for _ in 0 ..< q {
        let query = read().asList(ofInt)
        switch query[0] {
        case 0:
            let v = query[1]
            counts[v] += 1
            total += v
            
        case 1:
            let (x, y) = (query[1], query[2])
            let xCount = counts[x]
            counts[x] = 0
            counts[y] += xCount
            total = total - x * xCount + y * xCount
            
        case 2:
            print(total)
            
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
4
1 10 100 1000
8
1 1 10
2
0 10000
1 1000 10
2
1 10 100
1 100 10000
2
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
