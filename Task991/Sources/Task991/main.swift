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
    
    var d = [Int](repeating: -INF, count: N)
    d[0] = 0

    func step() -> Bool {
        var isChanged = false
        for e in E {
            let value = d[e.to]
            let updated = d[e.from].plus(e.weight)
            if value < updated {
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
    if d[N - 1] == -INF {
        print("impossible")
    }
    else if !isSettled {
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
8 12
5 7 12
4 1 -26
6 2 -34
7 5 -26
0 4 -17
6 0 -53
2 1 25
1 3 -5
1 6 2
0 2 -98
3 6 9
2 5 -67
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
