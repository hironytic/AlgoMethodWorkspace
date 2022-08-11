import Foundation

func main(read: () -> String) {
    let N = read().asInt()
    let A = read().asList(ofInt)
    var sum = 0
    var B = [Int](repeating: 0, count: N)
    for i in 0 ..< N {
        sum += A[i]
        B[i] = sum
    }
    let Q = read().asInt()
    for _ in 0 ..< Q {
        let k = read().asInt()
        print((k == 0) ? 0 : B[k - 1])
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
validate(main)
#else
main { readLine()! }
#endif
