import Foundation

//func read() -> String { readLine()! }
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

struct Entry {
    let name: String
    let math: Int
    let english: Int
}

func main() {
    let n = read().asInt()
    let list = (0 ..< n).map { _ -> Entry in
        let item = read().asList()
        return Entry(name: String(item[0]), math: item[1].asInt(), english: item[2].asInt())
    }
    
    let indices = (0 ..< n).sorted { l, r in
        if list[l].math > list[r].math {
            return true
        } else if list[l].math < list[r].math {
            return false
        } else {
            if list[l].math + list[l].english < list[r].math + list[r].english {
                return true
            } else if list[l].math + list[l].english > list[r].math + list[r].english {
                return false
            } else {
                return l < r
            }
        }
    }
    
    for i in indices {
        print(list[i].name, list[i].math, list[i].english)
    }
}

// ----------------------------------------------------------
// CodeTemplateのread()をこっちに差し替えれば
// 標準入力の代わりにコードで入力を与えられる。
let testData = TestData("""
1
aruru 100000 100000
""")
func read() -> String {
    return testData.read()
}

main()
