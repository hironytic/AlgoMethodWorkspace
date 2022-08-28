import Foundation

func main(read: () -> String) {
//    func num(on: Int...) -> Int {
//        return on.reduce(0) { $0 + 1 << $1}
//    }
//
//    let nums = [
//        num(on: 0, 1, 2, 4, 5, 6),
//        num(on: 2, 5),
//        num(on: 0, 2, 3, 4, 6),
//        num(on: 0, 2, 3, 5, 6),
//        num(on: 1, 2, 3, 5),
//        num(on: 0, 1, 3, 5, 6),
//        num(on: 0, 1, 3, 4, 5, 6),
//        num(on: 0, 1, 2, 5),
//        num(on: 0, 1, 2, 3, 4, 5, 6),
//        num(on: 0, 1, 2, 3, 5, 6),
//    ]
//    print(nums.map { String($0) }.joined(separator: ", "))
    let nums = [119, 36, 93, 109, 46, 107, 123, 39, 127, 111]
    let N = read().asInt()
    print(nums[N])
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
