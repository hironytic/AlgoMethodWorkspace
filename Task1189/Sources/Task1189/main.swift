import Foundation

func main(read: () -> String) {
    let N = read().asInt()
    let S = read().mapDigit()
    let T = read().mapDigit()

    var ans = [Int](repeating: 0, count: N)
    var r = 0
    for i in (0 ..< N).reversed() {
        ans[i] = S[i] ^ T[i] ^ r
        r = (S[i] & T[i]) | (T[i] & r) | (r & S[i])
    }
    print(ans.joinedString(separator: ""))
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
extension StringProtocol {
    /// 数字のみで構成される文字を各桁の数字の配列にします。
    /// 例： `"123"` → `[1, 2, 3]`
    /// - Returns: 数字の桁の配列
    func mapDigit() -> [Int] {
        return map { Int($0.asciiValue! - 48) }
    }
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
