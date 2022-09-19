import Foundation

func main(read: () -> String) {
    let N = read().asInt()
    
    for n in 1 ... N {
        if n.isMultiple(of: 12) {
            print("FizzBuzz")
        } else if n.isMultiple(of: 4) {
            print("Fizz")
        } else if n.isMultiple(of: 6) {
            print("Buzz")
        } else {
            print(n)
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
