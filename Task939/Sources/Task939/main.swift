import Foundation

func main() {
    let (_, m) = read().asList(ofInt).asTuple()
    let a = read().asList(ofInt)
    
    var modCount = [Int: Int]()
    for i in a {
        modCount[i % m, default: 0] += 1
    }
    
    var ans = 0
    for (_, ic) in modCount {
        ans += ic * (ic - 1)
    }
    print(ans / 2)
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
8 4
15 15 15 15 15 15 15 15
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
