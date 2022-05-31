import Foundation

func main() {
    let (_, m) = read().asList(ofInt).asTuple()
    let a = read().asList(ofInt)
    
    var count = [Int: Int]()
    for i in a {
        count[i, default: 0] += 1
    }
    
    var ans = 0
    for (i, ic) in count {
        let x = m - i
        if let xc = count[x] {
            if i == x {
                if ic > 1 {
                    ans += ic * (ic - 1)
                }
            } else {
                ans += ic * xc
            }
        }
    }
    print(ans / 2)
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
/// n 個の中から r 個を順番関係なく取り出した場合の数を返します。
func combination(_ n: Int, _ r: Int) -> Int {
    return (n - r + 1 ... n).reduce(1, *) / (1 ... r).reduce(1, *)
}
/// n 個の中から r 個を順に取り出して並べる場合の数を返します。
func permutation(_ n: Int, _ r: Int) -> Int {
    return (n - r + 1 ... n).reduce(1, *)
}
// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
15 8
1 1 2 3 4 4 4 5 5 6 7 7 8 9 10
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
