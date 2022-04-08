import Foundation

class Train {
    let number: Int
    var prev: Train? = nil
    var next: Train? = nil
    
    init(number: Int) {
        self.number = number
    }
}

func main() {
    let (n, q) = read().asList(ofInt).asTuple()
    
    let trains = (0 ..< n).map { Train(number: $0) }
    
    for _ in 0 ..< q {
        let query = read().asList(ofInt)
        switch query[0] {
        case 0:
            let (p, q) = (query[1], query[2])
            trains[p].next = trains[q]
            trains[q].prev = trains[p]
        case 1:
            let r = query[1]
            let tr = trains[r]
            let pn = tr.next
            tr.next?.prev = tr.prev
            tr.prev?.next = pn
            tr.next = nil
            tr.prev = nil
        default:
            break
        }
    }
    
    var count = 1
    var t = trains[0]
    while let p = t.prev {
        count += 1
        t = p
    }
    t = trains[0]
    while let n = t.next {
        count += 1
        t = n
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
5 5
0 3 4
0 4 0
1 4
1 2
0 1 4
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
