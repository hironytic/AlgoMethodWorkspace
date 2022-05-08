import Foundation

let smallLatinA = Character("a").asciiValue!

// 与えられた文字列を構成している文字の若い順でソートして（例："algo" → ["a", "g", "l", "o"]）
// それを27進数とみなして返す。
// ここで文字列の長さは10文字以内。27^10 - 1 = 205891132094648（15桁）なのでIntの正数部分（63 ビット）に収まる。
func anagramNumber(_ str: String.SubSequence) -> Int {
    var ret = 0
    var d = 1
    for ch in str.sorted() {
        ret += Int(ch.asciiValue! - smallLatinA + 1) * d
        d *= 27
    }
    return ret
}

func main() {
    let n = read().asInt()
    let s = read().asList().map { anagramNumber($0) }
    
    var count = [Int: Int]()
    for es in s {
        if let c = count[es] {
            count[es] = c + 1
        } else {
            count[es] = 1
        }
    }
    
    // 例えば n = 7 で、s が [1 2 3 4 3 4 3] だったとすると、
    // count == [
    //   1: 1,
    //   2: 1,
    //   3: 3,
    //   4: 2,
    // ]
    // ここで、求めたい確率は、
    // 「7つからi番目を取り出した場合(1/7)に、その数が残りの6つに含まれる確率((count[s[i]] - 1) / 6)」を全iについて足したもの。
    // ans = 1/7 * (count[s[0]] - 1)/6  (i == 0)
    //     + 1/7 * (count[s[1]] - 1)/6  (i == 1)
    //     + 1/7 * (count[s[2]] - 1)/6  (i == 2)
    //     + 1/7 * (count[s[3]] - 1)/6  (i == 3)
    //     + 1/7 * (count[s[4]] - 1)/6  (i == 4)
    //     + 1/7 * (count[s[5]] - 1)/6  (i == 5)
    //     + 1/7 * (count[s[6]] - 1)/6  (i == 6)
    // ここで、s[i] == k となるものは count[k] 個あるので、
    // ans = 1/7 * count[1] * (count[1] - 1)/6  (k == 1)
    //     + 1/7 * count[2] * (count[2] - 1)/6  (k == 2)
    //     + 1/7 * count[3] * (count[3] - 1)/6  (k == 3)
    //     + 1/7 * count[4] * (count[4] - 1)/6  (k == 4)
    // つまり
    // ans = Σ(count[k] * count[k] - 1) / (7 * 6)
    let sum = count.values.reduce(0) { acc, c in acc + (c * (c - 1)) }
    let ans = Double(sum) / Double(n * (n - 1))
    print(ans)
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
10
algo live silent goal algo listen method algo evil live
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
