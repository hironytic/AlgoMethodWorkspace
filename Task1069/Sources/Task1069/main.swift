import Foundation

func main(read: () -> String) {
    let X = read().asList(ofInt)
    for i in 0 ..< 8 {
        var line = ""
        for j in 0 ..< 8 {
            switch (X[i] >> (2 * (7 - j))) & 0x3 {
            case 0x0:
                line += "."
            case 0x1:
                line += "o"
            case 0x2:
                line += "x"
            default:
                preconditionFailure()
            }
        }
        print(line)
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
