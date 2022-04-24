import Foundation

func main() {
    _ = read()
    let a = read().asList()
    
    var counts = [String.SubSequence: Int]()
    
    func increment(_ s: String.SubSequence) {
        if let c = counts[s] {
            counts[s] = c + 1
        } else {
            counts[s] = 1
        }
    }
    
    for ea in a {
        increment(ea)
    }
    
    let q = read().asInt()
    for _ in 0 ..< q {
        let (command, param) = read().asList().asTuple()
        switch command {
        case "0":
            increment(param)
        case "1":
            counts[param] = nil
        case "2":
            if let c = counts[param] {
                print(c)
            } else {
                print(0)
            }
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
5
abc pqr abc xyz aaa
6
2 lmn
2 abc
1 bbb
0 abc
1 xyz
2 abc
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
