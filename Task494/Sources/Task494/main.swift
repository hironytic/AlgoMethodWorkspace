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
    let n = read().asInt()
    
    let ans: Int
    if n == 1 {
        ans = 1
    } else {
        let factors = n.factorization()
        if factors.contains(where: { f in f.power >= 2 }) {
            ans = 0
        } else {
            if factors.count.isMultiple(of: 2) {
                ans = 1
            } else {
                ans = -1
            }
        }
    }
    
    print(ans)
}

// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
111111111111
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
