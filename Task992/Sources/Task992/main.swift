import Foundation

struct Edge {
    var from: Int
    var to: Int
    var weight: Int
}

let INF = 1_000_000_000

extension Int {
    func plus(_ x: Int) -> Int {
        if self == INF || self == -INF {
            return self
        } else {
            return self + x
        }
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
    
    var d = [(value: Int, from: Int)](repeating: (INF, -1), count: N)
    d[0] = (0, -2)

    func step() -> Bool {
        var isChanged = false
        for e in E {
            let value = d[e.to].value
            let updated = d[e.from].value.plus(e.weight)
            if value > updated {
                isChanged = true
                d[e.to] = (updated, e.from)
            }
        }
        return isChanged
    }
    
    for _ in 0 ..< N {
        if !step() {
            break
        }
    }
    
    var ans = [Int]()
    var ix = N - 1
    while true {
        ans.append(ix)
        let from = d[ix].from
        if from == -2 {
            break
        }
        ix = from
    }
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
    func asTuple() -> (Element, Element, Element) { (self[0], self[1], self[2]) }
}
// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
5 7
0 3 0
4 2 0
2 3 0
3 1 0
1 4 0
0 2 0
3 4 0
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
