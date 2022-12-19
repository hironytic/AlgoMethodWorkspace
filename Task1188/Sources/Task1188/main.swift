import Foundation

let ch0 = Character("0")
let ch9 = Character("9")
let chA = Character("A")
let chF = Character("F")

func main(read: () -> String) {
    _ = read().asInt()
    let S: [Int] = read().map { ch in
        if ch0 <= ch && ch <= ch9 {
            return Int(ch.asciiValue! - ch0.asciiValue!)
        } else {
            let uch = ch.uppercased().first!
            if chA <= uch && uch <= chF {
                return Int(uch.asciiValue! - chA.asciiValue! + 10)
            } else {
                preconditionFailure()
            }
        }
    }
    
    let bits = [
        "0000", "0001", "0010", "0011",
        "0100", "0101", "0110", "0111",
        "1000", "1001", "1010", "1011",
        "1100", "1101", "1110", "1111",
    ]
    
    var ans = ""
    for s in S {
        ans += bits[s]
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
