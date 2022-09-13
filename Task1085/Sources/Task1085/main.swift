import Foundation

let asciiA = Int(Character("a").asciiValue!)
let pangramMask = (1 << 26) - 1

func main(read: () -> String) {
    let N = read().asInt()
    let W: [Int] = read().asList().map { w in
        w.map {
            return Int($0.asciiValue!) - asciiA
        }
        .reduce(0) { acc, v in
            return acc | (1 << v)
        }
    }
    var ans = Int.max
    for i in 0 ..< (1 << N) {
        var flags = 0
        var count = 0
        for j in 0 ..< N where i & (1 << j) != 0 {
            flags |= W[j]
            count += 1
        }
        if flags & pangramMask == pangramMask {
            ans = min(ans, count)
        }
    }
    print(ans == Int.max ? -1 : ans)
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
