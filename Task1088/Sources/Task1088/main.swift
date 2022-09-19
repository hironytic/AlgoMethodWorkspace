import Foundation

func main(read: () -> String) {
    var (sA, tA) = read().asList(ofInt).asTuple()
    var (sB, tB) = read().asList(ofInt).asTuple()
    if sA > sB {
        (sA, tA, sB, tB) = (sB, tB, sA, tA)
    }
    
    let ans: Int
    if tA < sB {
        ans = 0
    } else if tB < tA {
        ans = tB - sB
    } else {
        ans = tA - sB
    }
    print(ans)
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
