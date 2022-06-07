import Foundation

struct Item {
    var value: Int
    var count: Int
    var span: Int
}

func main() {
    let n = read().asInt()
    var a = read().asList(ofInt).map { Item(value: $0, count: 1, span: -1) }
    
    /// index - 1 まではスパンが求まっていることを前提に
    /// index 番目（値が value）のスパンを求める
    func calcSpan(value: Int, index: Int) -> Int {
        var span = 1
        var j = index - 1
        while true {
            let p = (j >= 0) ? a[j].value : 0
            if p <= value {
                break
            } else {
                let pspan = a[j].span
                span += pspan
                j -= pspan
            }
        }
        return span
    }

    // 初期のaの各値の合計とスパンを求めておく
    var sum = 0
    for i in 0 ..< n {
        sum += a[i].value
        let span = calcSpan(value: a[i].value, index: i)
        a[i].span = span
    }

    let q = read().asInt()
    for _ in 0 ..< q {
        let query = read().asList(ofInt)
        switch query[0] {
        case 0:
            let v = query[1]
            let span = calcSpan(value: v, index: a.count)
            var count = 1
            for _ in 0 ..< span - 1 {
                let popped = a.popLast()!
                sum -= popped.value * popped.count
                count += popped.count
            }
            a.append(Item(value: v, count: count, span: 1))
            sum += v * count
            
        case 1:
            print(sum)
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
4
314 159 265 358
7
0 1000000000
0 1000000000
1
0 1000000000
0 1000000000
0 1000000000
1
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
