import Foundation

func main(read: () -> String) {
    let (N, D) = read().asList(ofInt).asTuple()
    let X = read().asList(ofInt)
    var sum = [0]
    for x in X {
        sum.append(sum.last! + x)
    }
    
    var maxNum = Int.min
    var ans = -1
    for s in 0 ... N - D {
        let num = sum[s + D] - sum[s]
        if maxNum <= num {
            ans = s
            maxNum = num
        }
    }
    print("\(ans)~\(ans + D - 1)")
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
validate(main)
#else
main { readLine()! }
#endif
