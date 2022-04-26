import Foundation

func main() {
    let x = read()
    _ = read()
    let s = read().asList()
    
    var stack = [Int]()
    
    for es in s {
        switch es {
        case "+":
            let v2 = stack.popLast()!
            let v1 = stack.popLast()!
            stack.append(v1 + v2)
        case "-":
            let v2 = stack.popLast()!
            let v1 = stack.popLast()!
            stack.append(v1 - v2)
        case "*":
            let v2 = stack.popLast()!
            let v1 = stack.popLast()!
            stack.append(v1 * v2)
        default:
            let v = es.asInt()
            stack.append(v)
        }
    }
    
    let ans = stack.popLast()!
    print("\(x)=\(ans)")
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
14+3*(10-9)-2*5
11
14 3 10 9 - * + 2 5 * -
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
