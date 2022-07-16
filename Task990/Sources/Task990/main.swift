import Foundation

struct Edge {
    var from: Int
    var to: Int
    var weight: Int
}

let INF = 1_000_000_000

func add(_ a: Int, _ b: Int) -> Int {
    if a == INF || a == -INF {
        return INF
    } else {
        return a + b
    }
}

func main() {
    let (N, M) = read().asList(ofInt).asTuple()
    let E: [Edge] = (0 ..< M).map { _ in
        let (u, v, w) = read().asList(ofInt).asTuple()
        return Edge(from: u, to: v, weight: w)
    }
    var G = [[Int]](repeating: [], count: N)
    for e in E {
        G[e.to].append(e.from)
    }

    // 頂点(N - 1)にたどり着ける頂点
    var seen = [Bool](repeating: false, count: N)
    seen[N - 1] = true
    var queue = ArraySlice<Int>()
    queue.append(N - 1)
    while let v = queue.popFirst() {
        for n in G[v] where !seen[n] {
            seen[n] = true
            queue.append(n)
        }
    }
    if !seen[0] {
        print("impossible")
        return
    }

    // 頂点(N - 1)にたどり着ける頂点に向かう辺だけ取り出したもの
    let EE = E.filter { seen[$0.to] }
    
    var d = [Int](repeating: INF, count: N)
    d[0] = 0

    func step() -> Bool {
        var isChanged = false
        for e in EE {
            let value = d[e.to]
            let updated = add(d[e.from], e.weight)
            if value > updated {
                isChanged = true
                d[e.to] = updated
            }
        }
        return isChanged
    }
    
    var isSettled = false
    for _ in 0 ..< N {
        if !step() {
            isSettled = true
            break
        }
    }
    if !isSettled {
        print("-inf")
    } else {
        print(d[N - 1])
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
5 5
0 1 -1
1 2 -1
2 3 -1
3 1 -1
0 4 100
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
