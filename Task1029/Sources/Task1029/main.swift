import Foundation

func main(read: () -> String) {
    _ = read()
    let L = read().asList(ofInt)
    
    var C = [Int](repeating: 0, count: 100001)
    for l in L {
        C[l] += 1
    }
    
    var S = [Int]()
    for c in C {
        S.append((S.last ?? 0) + c)
    }
    
    let Q = read().asInt()
    for _ in 0 ..< Q {
        let (a, b) = read().asList(ofInt).asTuple()
        print(S[b] - S[a - 1])
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
