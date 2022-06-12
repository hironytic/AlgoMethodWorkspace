import Foundation

class UnionFind {
    var parent: [Int]
    
    init(count: Int) {
        parent = [Int](repeating: -1, count: count)
    }
    
    func isSameGroup(_ a: Int, _ b: Int) -> Bool {
        return root(of: a) == root(of: b)
    }
    
    private func root(of i: Int) -> Int {
        var vertex = [Int]()
        
        var i = i
        var p = parent[i]
        while p != -1 {
            vertex.append(i)
            i = p
            p = parent[i]
        }
        for v in vertex {
            parent[v] = i
        }
        return i
    }
    
    func union(_ a: Int, _ b: Int) {
        parent[root(of: b)] = root(of: a)
    }
}

func main() {
    let (n, m) = read().asList(ofInt).asTuple()
    let unionFind = UnionFind(count: n)
    
    for _ in 0 ..< m {
        let (a, b) = read().asList(ofInt).asTuple()
        if unionFind.isSameGroup(a, b) {
            print("Yes")
        } else {
            print("No")
            unionFind.union(a, b)
        }
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
100000 1
0 99999
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
