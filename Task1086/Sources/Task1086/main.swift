import Foundation

func main(read: () -> String) {
    let (H, W) = read().asList(ofInt).asTuple()
    let values: [[Bool]] = (0 ..< H).map { _ in
        read().map { $0 == "#" }
    }
    let cells = values.reduce(0) { acc, row in
        let line = row.enumerated().reduce(0) { acc, cell in
            return cell.element ? acc | (1 << cell.offset) : acc
        }
        return (acc << W) | line
    }
    var masks = [Int]()
    for y in 0 ..< H {
        for x in 0 ..< W {
            var mask = 0
            for (dy, dx) in [(-1, 0), (0, -1), (0, 0), (0, 1), (1, 0)] {
                let yy = y + dy
                let xx = x + dx
                if yy >= 0 && yy < H && xx >= 0 && xx < W {
                    mask |= (1 << (yy * W + xx))
                }
            }
            masks.append(mask)
        }
    }

    for i in 0 ..< (1 << (H * W)) {
        var value = cells
        for j in 0 ..< H * W where i & (1 << j) != 0 {
            value ^= masks[j]
        }
        if value == 0 {
            print("Yes")
            return
        }
    }
    print("No")
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
