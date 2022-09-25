import Foundation

func main(read: () -> String) {
    let (A, B, C) = read().asList(ofInt).asTuple()
    let (Y0, M0, D0, X) = read().asList(ofInt).map { $0 - 1 }.asTuple()
    let (Y1, M1, D1) = read().asList(ofInt).map { $0 - 1 }.asTuple()
    let day0 = Y0 * A * B + M0 * B + D0
    let day1 = Y1 * A * B + M1 * B + D1
    let diffD = day1 - day0
    let diffW = diffD % C
    let W = (X + diffW + C) % C
    print(W + 1)
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
    func asTuple() -> (Element, Element, Element, Element) { (self[0], self[1], self[2], self[3]) }
    func asTuple() -> (Element, Element, Element) { (self[0], self[1], self[2]) }
}
// ----------------------------------------------------------

#if DEVELOPING
validate(main)
#else
main { readLine()! }
#endif
