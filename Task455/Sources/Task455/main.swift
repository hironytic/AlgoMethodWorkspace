import Foundation

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

struct Factor {
    var base: Int
    var power: Int
}

extension Int {
    func factorization() -> [Factor] {
        var result = [Factor]()
        var n = self
        var i = 2
        while i * i <= n {
            var power = 0
            while n.isMultiple(of: i) {
                power += 1
                n /= i
            }
            if power > 0 {
                result.append(Factor(base: i, power: power))
            }
            i += 1
        }
        if n > 1 {
            result.append(Factor(base: n, power: 1))
        }
        
        return result
    }
}

func main() {
    let a = read().asInt()
    
    let factors = a.factorization()
    let n = factors
        .lazy
        .filter { !$0.power.isMultiple(of: 2) }
        .reduce(1) { (acc, factor) in
            return acc * factor.base
        }
    print(n)
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
9316358251200
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
