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
    let price: Int
    let num: Int
}

func main() {
    let (n, k) = read().asList(ofInt).asTuple()
    let items: [Entry] = (0 ..< n).map { _ in
        let (a, b) = read().asList(ofInt).asTuple()
        return Entry(price: a, num: b)
    }.sorted { $0.price < $1.price }
    
    var i = 0
    var totalPrice = 0
    var needed = k
    while needed > 0 {
        let num = min(items[i].num, needed)
        needed -= num
        totalPrice += items[i].price * num
        if num >= items[i].num {
            i += 1
        }
    }
    
    print(totalPrice)
}

// ----------------------------------------------------------
// CodeTemplateのread()をこっちに差し替えれば
// 標準入力の代わりにコードで入力を与えられる。
let testData = TestData("""
1 100000
100000 100000
""")
func read() -> String {
    return testData.read()
}

main()
