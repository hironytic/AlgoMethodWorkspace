import Foundation

struct Address {
    var x: Int
    var y: Int
}

extension Array where Element == [Int] {
    subscript(address: Address) -> Int {
        get {
            return self[address.y][address.x]
        }
        set {
            self[address.y][address.x] = newValue
        }
    }
}

func main() {
    let (h, w) = read().asList(ofInt).asTuple()
    
    var map: [[Int]] = .init(repeating: .init(repeating: -1, count: w), count: h)
    var start = Address(x: -1, y: -1)
    var goal = Address(x: -1, y: -1)
    for y in 0 ..< h {
        let row = read().map { $0 }
        for x in 0 ..< w {
            let address = Address(x: x, y: y)
            switch row[x] {
            case "#":
                map[address] = -2
            case "S":
                map[address] = 0
                start = address
            case "G":
                goal = address
            default:
                break
            }
        }
    }

    func forEach(nextTo address: Address, body: (Address) -> Void) {
        let (x, y) = (address.x, address.y)
        
        if y - 1 >= 0 {
            body(Address(x: x, y: y - 1))
        }
        if x + 1 < w {
            body(Address(x: x + 1, y: y))
        }
        if y + 1 < h {
            body(Address(x: x, y: y + 1))
        }
        if x - 1 >= 0 {
            body(Address(x: x - 1, y: y))
        }
    }

    var queue = ArraySlice<Address>()
    queue.append(start)
    
    while let address = queue.popFirst() {
        let nextStep = map[address] + 1
        forEach(nextTo: address) { nextAddress in
            if map[nextAddress] == -1 {
                map[nextAddress] = nextStep
                queue.append(nextAddress)
            }
        }
        let ans = map[goal]
        if ans != -1 {
            print(ans)
            return
        }
    }
    print(-1)
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
5 6
G...#.
.##.#.
#.#..#
....#.
S.#.##
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
