import Foundation

func main(read: () -> String) {
    var minutes = 0
    for _ in 0 ..< 30 {
        let (H1, M1, H2, M2) = read().asList(ofInt).asTuple()
        let s = H1 * 60 + M1
        let e = H2 * 60 + M2
        let d = e - s
        if d > 8 * 60 {
            minutes += d - 60
        } else if d > 6 * 60 {
            minutes += d - 45
        } else {
            minutes += d
        }
    }
    let Hr = minutes / 60
    let Mr = minutes % 60
    print("\(Hr) \(Mr)")
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
    func asTuple() -> (Element, Element, Element, Element) { (self[0], self[1], self[2], self[3]) }
}
// ----------------------------------------------------------

#if DEVELOPING
validate(main)
#else
main { readLine()! }
#endif
