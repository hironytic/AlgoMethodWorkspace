import Foundation

func main(read: () -> String) {
    let (H, W) = read().asList(ofInt).asTuple()
    let B = Board(height: H, width: W, values: (0 ..< H).map { _ in
        read().map { $0 == "#" }
    })
    for i in 0 ..< (1 << (H * W)) {
        var b = B
        for j in 0 ..< H * W where i & (1 << j) != 0 {
            b.select(y: j / W, x: j % W)
        }
        if b.isClear {
            print("Yes")
            return
        }
    }
    print("No")
}

struct Board {
    private var rawValue: Int
    private var height: Int
    private var width: Int
    init(height: Int, width: Int, values: [[Bool]]) {
        self.height = height
        self.width = width
        self.rawValue = values.reduce(0) { acc, row in
            let line = row.enumerated().reduce(0) { acc, cell in
                return cell.element ? acc | (1 << cell.offset) : acc
            }
            return (acc << width) | line
        }
    }

    var isClear: Bool {
        return rawValue == 0
    }
    
    private mutating func reverse(y: Int, x: Int) {
        guard y >= 0 && y < height && x >= 0 && x < width else { return }
        rawValue ^= (1 << (y * width + x))
    }
    
    mutating func select(y: Int, x: Int) {
        for (dy, dx) in [(-1, 0), (0, -1), (0, 0), (0, 1), (1, 0)] {
            reverse(y: y + dy, x: x + dx)
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
validate(main)
#else
main { readLine()! }
#endif
