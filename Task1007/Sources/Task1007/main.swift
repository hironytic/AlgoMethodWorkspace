import Foundation

func main() {
    let (N, s, K) = read().asList(ofInt).asTuple()
    var G = [[Int]](repeating: [], count: N)
    for _ in 0 ..< N - 1 {
        let (a, b) = read().asList(ofInt).asTuple()
        G[a].append(b)
        G[b].append(a)
    }

    var ans = 0
    let flagK = K % 2
    var V = [Int](repeating: -1, count: N)
    var queue = ArraySlice<Int>()
    V[s] = 0
    queue.append(s)
    
    while let v = queue.popFirst() {
        let step = V[v]
        if step % 2 == flagK {
            ans += 1
        }
        if step < K {
            for n in G[v] where V[n] == -1 {
                V[n] = step + 1
                queue.append(n)
            }
        }
    }
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
9 7 15
2 6
7 8
0 5
3 0
0 4
1 7
7 0
3 6
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
