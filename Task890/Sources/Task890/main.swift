import Foundation

func main() {
    let n = read().asInt()
    let s = read()
    
    var stack = [Int]()
    var counterparts = [Int](repeating: -1, count: n)
    
    for (idx, es) in s.enumerated() {
        switch es {
        case "(":
            stack.append(idx)
        case ")":
            let start = stack.popLast()!
            counterparts[start] = idx
            counterparts[idx] = start
        default:
            break
        }
    }
    
    let q = read().asInt()
    for _ in 0 ..< q {
        let k = read().asInt()
        print(counterparts[k])
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
((()))
2
4
0
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
