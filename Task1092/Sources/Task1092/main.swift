import Foundation

func main(read: () -> String) {
    let aiueo = "aiueoAIUEO".map { $0 }
    let S = read().map { (ch: Character) -> Character in
        let isAiueo = aiueo.contains(ch)
        let isUppercase = ch.isUppercase
        if isUppercase && isAiueo {
            return Character("#")
        } else if isUppercase {
            return Character("!")
        } else if isAiueo {
            return Character("?")
        } else {
            return ch
        }
    }.joinedString(separator: "")
    print(S)    
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
