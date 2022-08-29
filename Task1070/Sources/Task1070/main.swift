import Foundation

func main(read: () -> String) {
    let (O, G, U) = read().map { String($0).asInt() }.asTuple()
    let (P, Q) = read().asList().asTuple()
    
    let p: Int
    switch P {
    case "o":
        p = O
    case "g":
        p = G
    case "u":
        p = U
    default:
        fatalError()
    }
    
    let q: Int
    switch Q {
    case "r":
        q = 0b100
    case "w":
        q = 0b010
    case "x":
        q = 0b001
    default:
        fatalError()
    }
    
    print((p & q != 0) ? "Yes" : "No")
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
