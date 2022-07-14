import Foundation

func main() {
    let (N, M, s, t) = read().asList(ofInt).asTuple()
    var G = [[Int]](repeating: [], count: N)
    for _ in 0 ..< M {
        let (a, b) = read().asList(ofInt).asTuple()
        G[a].append(b)
    }

    var from = [Int](repeating: -1, count: N)
    var queue = ArraySlice<Int>()
    from[s] = -2
    queue.append(s)
    while let v = queue.popFirst() {
        if v == t {
            break
        }
        for n in G[v] where from[n] == -1 {
            from[n] = v
            queue.append(n)
        }
    }

    var ans = [Int]()
    var v = t
    ans.append(v)
    repeat {
        v = from[v]
        ans.append(v)
    } while from[v] >= 0
    print(ans.count)
    print(ans.lazy.reversed().map { String($0) }.joined(separator: " "))
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
    func asTuple() -> (Element, Element, Element, Element) { (self[0], self[1], self[2], self[3]) }
}
// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
4 6 3 0
0 1
3 1
3 2
1 2
2 0
1 3
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
