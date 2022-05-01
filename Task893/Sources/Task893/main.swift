import Foundation

func main() {
    let n = read().asInt()
    let a = read().asList(ofInt)
    
    if n == 1 {
        return
    }
    
    var spans = [Int](repeating: -1, count: n)
    for i in 1 ..< n {
        let e = a[i]
        var span = 1
        
        var j = i - 1
        while true {
            let p = a[j]
            if p < e {
                break
            } else {
                let pspan = spans[j]
                span += pspan
                j -= pspan
            }
        }
        spans[i] = span
    }

    for e in spans[1...] {
        print(e)
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
0 10000 1000 100 10 1
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
