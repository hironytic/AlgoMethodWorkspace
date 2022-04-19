import Foundation

func main() {
    let (_, m) = read().asList(ofInt).asTuple()
    let a = read().asList(ofInt)
    
    var ab2 = [Bool](repeating: false, count: m)
    for x in a {
        for y in a {
            let x2y2 = x * x + y * y
            if x2y2 < m {
                ab2[x2y2] = true
            }
        }
    }

    for i in 1 ..< m {
        if ab2[i] && ab2[m - i] {
            print("Yes")
            return
        }
    }
    print ("No")
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
5 51
3 1 4 1 5
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
