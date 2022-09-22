import Foundation

func main(read: () -> String) {
    let (N, _) = read().asList(ofInt).asTuple()
    var menu = [String: Int]()
    for _ in 0 ..< N {
        let (F, C) = read().asList().asTuple()
        menu[String(F)] = C.asInt()
    }
    let X = read().asList()
    let ans = X.reduce(0) { acc, name in
        return acc + menu[String(name), default: 0]
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
