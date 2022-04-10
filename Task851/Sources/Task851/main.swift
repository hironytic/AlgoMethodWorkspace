import Foundation

func main() {
    let (n, k) = read().asList(ofInt).asTuple()
    let s = read().map { $0 }
    
    // 右端から k までの ← を積む
    var rights = [Int]()
    for i in (k + 1 ... n - 1).reversed() {
        if s[i] == "<" {
            rights.append(i - k)
        }
    }
    // 左端から k までの → を積む
    var lefts = [Int]()
    for i in (0 ..< k) {
        if s[i] == ">" {
            lefts.append(k - i)
        }
    }
    
    var count = 0
    var direction = true // true = 右向き、false = 左向き
    while true {
        if direction { // 右向き
            if rights.isEmpty {
                count += n - 1 - k
                break
            }
            count += rights.popLast()! * 2
        } else { // 左向き
            if lefts.isEmpty {
                count += k
                break
            }
            count += lefts.popLast()! * 2
        }
        direction.toggle()
    }
    
    print(count)
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
let testData = TestData("""
10 4
.>>>.<<<<.
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
