import Foundation

func main() {
    let (h, w) = read().asList(ofInt).asTuple()
    let black = (0 ..< h).map { _ in
        return read().map { $0 == "#" }
    }
    
    var visited: [[Bool]] = .init(repeating: .init(repeating: false, count: w) , count: h)
    
    func visit(_ x: Int, _ y: Int) {
        visited[x][y] = true
        for (nx, ny) in [(x - 1, y), (x, y - 1), (x, y + 1), (x + 1, y)] {
            if nx >= 0 && ny >= 0 && nx < h && ny < w {
                if black[nx][ny] && !visited[nx][ny] {
                    visit(nx, ny)
                }
            }
        }
    }
    
    var ans = 0
    for x in 0 ..< h {
        for y in 0 ..< w {
            if black[x][y] && !visited[x][y] {
                ans += 1
                visit(x, y)
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
5 2
..
..
..
..
..
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
