import Foundation

func main() {
    let (_, k) = read().asList(ofInt).asTuple()
    let a = read().asList(ofInt)
    
    var heap = Heap()
    for i in a {
        heap.insert(i)
    }
    
    for _ in 0 ..< k {
        let m = heap.removeMax()
        heap.insert(m / 2)
    }
    
    print(heap.values.reduce(0, +))
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
struct Heap {
    var values = [Int]()
    
    mutating func insert(_ v: Int) {
        values.append(v)
        var ix = values.count - 1
        while ix > 0 {
            let pix = (ix - 1) / 2
            if values[pix] >= values[ix] {
                break
            }
            values.swapAt(ix, pix)
            ix = pix
        }
    }
    
    mutating func removeMax() -> Int {
        let result = values[0]
        let v = values.removeLast()
        if !values.isEmpty {
            values[0] = v
            var i = 0
            while true {
                let li = 2 * i + 1
                let ri = 2 * i + 2
                let c = values.count
                let left = li < c ? values[li] : Int.min
                let right = ri < c ? values[ri] : Int.min
                if v >= Swift.max(left, right) {
                    break
                }
                
                if left >= right {
                    values[i] = left
                    values[li] = v
                    i = li
                } else {
                    values[i] = right
                    values[ri] = v
                    i = ri
                }
            }
        }
        return result
    }
}
// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
2 35
1000 714
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
