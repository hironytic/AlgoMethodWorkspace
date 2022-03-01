import Foundation

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

func main() {
    let (n, _p) = read().asList(ofInt).asTuple()
    let p = Double(_p) / 100.0
    
    var probabilities = [Double](repeating: 0.0, count: n + 1)
    func run(omote: Int, probability: Double, count: Int) {
        if count == n {
            probabilities[omote] += probability
            return
        }

        // 表が出たとき
        run(omote: omote + 1, probability: probability * p, count: count + 1)
        
        // 裏が出たとき
        run(omote: omote, probability: probability * (1.0 - p), count: count + 1)
    }
    run(omote: 0, probability: 1.0, count: 0)
    
    let expected = probabilities.enumerated().reduce(0.0) { acc, item in
        return acc + Double(item.offset) * item.element
    }
    print(expected)
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
7 50
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
