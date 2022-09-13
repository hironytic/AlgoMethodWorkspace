import Foundation

func main(read: () -> String) {
    let (N, M) = read().asList(ofInt).asTuple()
    let W = read().asList(ofInt)
    let V = read().asList(ofInt)
    
    var ans = Int.min
    for i in 0 ..< (1 << N) {
        var sw = 0
        var sv = 0
        for j in 0 ..< N where i & (1 << j) != 0 {
            sw += W[j]
            sv += V[j]
        }
        if sw <= M {
            ans = max(ans, sv)
        }
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
