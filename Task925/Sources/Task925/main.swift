import Foundation

func main() {
    var heap = [Int]()
    
    let q = read().asInt()
    for _ in 0 ..< q {
        let v = read().asInt()
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
    }
    print(heap.joinedString())
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
extension Array where Element: LosslessStringConvertible {
    /// 配列の内容を連結して1つの文字列にします。
    /// - Parameter separator: セパレータ
    /// - Returns: 連結した文字列
    func joinedString(separator: String = " ") -> String {
        return map { String($0) }.joined(separator: separator)
    }
}
// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
4
23
23
23
23
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
