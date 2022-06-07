import Foundation

struct Item {
    var number: Int
    var count: Int
}

func main() {
    _ = read()
    var a = read().asList(ofInt).map { Item(number: $0, count: 1) }
    var totalCount = a.count
    
    let q = read().asInt()
    for _ in 0 ..< q {
        let query = read().asList(ofInt)
        switch query[0] {
        case 0:
            let (v, k) = (query[1], query[2])
            a.append(Item(number: v, count: k))
            totalCount += k
            
        case 1:
            var k = query[1]
            if totalCount < k {
                print("Error")
            } else {
                totalCount -= k
                var ans = 0
                while k > 0 {
                    let item = a.popLast()!
                    if item.count > k {
                        // 取り過ぎたので戻す
                        a.append(Item(number: item.number, count: item.count - k))
                        
                        ans += item.number * k
                        k = 0
                    } else {
                        ans += item.number * item.count
                        k -= item.count
                    }
                }
                print(ans)
            }
            
        default:
            break
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
let testData = TestData("""
5
19 0 42 169 389
7
1 3
0 198344926 34802
0 30067915 69027
1 100000
0 0 2678
1 20493
1 905
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
