import Foundation

func main() {
    _ = read()
    let a = read().asList(ofInt)
    let q = read().asInt()
    
    var front = [Int]()
    var back = [Int]()
    
    for _ in 0 ..< q {
        let (command, param) = read().asList(ofInt).asTuple()
        switch command {
        case 0:
            front.append(param)
        case 1:
            back.append(param)
        case 2:
            if param < front.count {
                print(front[front.count - param - 1])
            } else if param - front.count < a.count {
                print(a[param - front.count])
            } else if param - front.count - a.count < back.count {
                print(back[param - front.count - a.count])
            } else {
                print("Error")
            }
        default:
            break
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
3
1 4 1
6
0 3
1 5
2 0
2 5
1 9
2 5
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
