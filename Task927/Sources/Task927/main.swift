import Foundation

struct Key: Comparable {
    var time: Int
    var index: Int
    
    static func < (lhs: Key, rhs: Key) -> Bool {
        if lhs.time < rhs.time { return true }
        if lhs.time == rhs.time && lhs.index < rhs.index { return true }
        return false
    }
    
    static let max = Key(time: Int.max, index: Int.max)
}


func main() {
    var heap = [(Key, String)]()
    
    func insert(time: Int, index: Int, name: String) {
        heap.append((Key(time: time, index: index), name))
        var ix = heap.count - 1
        while ix > 0 {
            let pix = (ix - 1) / 2
            if heap[pix].0 <= heap[ix].0 {
                break
            }
            heap.swapAt(ix, pix)
            ix = pix
        }
    }
    
    func removeMinimum() -> String {
        let result = heap[0].1
        let v = heap.removeLast()
        if !heap.isEmpty {
            heap[0] = v
            var i = 0
            while true {
                let li = 2 * i + 1
                let ri = 2 * i + 2
                let c = heap.count
                let left = li < c ? heap[li].0 : Key.max
                let right = ri < c ? heap[ri].0 : Key.max
                if v.0 <= min(left, right) {
                    break
                }
                
                if left <= right {
                    heap.swapAt(i, li)
                    i = li
                } else {
                    heap.swapAt(i, ri)
                    i = ri
                }
            }
        }
        return result
    }

    let q = read().asInt()
    for i in 0 ..< q {
        let query = read().asList()
        switch query[0] {
        case "0":
            let t = query[1].asInt()
            let s = String(query[2])
            insert(time: t, index: i, name: s)
        case "1":
            let name = removeMinimum()
            print(name)
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
0 5 abc
0 5 stu
0 3 xyz
1
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
