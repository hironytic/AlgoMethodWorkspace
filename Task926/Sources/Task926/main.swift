import Foundation

func main() {
    var heap = [Int]()
    
    let q = read().asInt()
    for _ in 0 ..< q {
        let query = read().asList(ofInt)
        switch query[0] {
        case 0:
            let v = query[1]
            heap.append(v)
            var ix = heap.count - 1
            while ix > 0 {
                let pix = (ix - 1) / 2
                if heap[pix] >= heap[ix] {
                    break
                }
                heap.swapAt(ix, pix)
                ix = pix
            }
        case 1:
            print(heap[0])
            let v = heap.removeLast()
            if !heap.isEmpty {
                heap[0] = v
                var i = 0
                while true {
                    let li = 2 * i + 1
                    let ri = 2 * i + 2
                    let c = heap.count
                    let left = li < c ? heap[li] : Int.min
                    let right = ri < c ? heap[ri] : Int.min
                    if v >= max(left, right) {
                        break
                    }
                    
                    if left >= right {
                        heap[i] = left
                        heap[li] = v
                        i = li
                    } else {
                        heap[i] = right
                        heap[ri] = v
                        i = ri
                    }
                }
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
7
0 23
0 23
1
1
0 23
0 23
1
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
