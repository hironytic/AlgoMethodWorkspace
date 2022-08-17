import Foundation

func main(read: () -> String) {
    var (_, S) = read().asList(ofInt).asTuple()
    let Q = read().asInt()
    for _ in 0 ..< Q {
        let (command, x) = read().asList(ofInt).asTuple()
        switch command {
        case 0:
            S = S | (1 << x)
        case 1:
            print(S & (1 << x) != 0 ? "on" : "off")
        default:
            break
        }
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
