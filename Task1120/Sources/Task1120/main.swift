import Foundation

func main(read: () -> String) {
    let (N, K) = read().asList(ofInt).asTuple()
    let A = read().asList(ofInt)
    
    // 累積和
    var sums: [Int] = [0]
    for a in A {
        sums.append(sums.last! + a)
    }
    // i in from ..< to についての、A[i]の総和
    func sum(from: Int, to: Int) -> Int {
        return sums[to] - sums[from]
    }

    // dp[i][k]
    // 前からi個をk個に分割したときの、各分割区間の和の最小値
    var dp: [[Int]] = .init(repeating: .init(repeating: Int.min, count: K + 1), count: N + 1)
    func update(_ i: Int, _ k: Int, value: Int) {
        dp[i][k] = max(dp[i][k], value)
    }
    
    dp[0][0] = Int.max
    
    for i in 0 ..< N {
        for j in 0 ... i {
            for k in 0 ..< min(K, j + 1) { // 前からj個をj + 1個以上に分割できることはないので
                let value = dp[j][k]
                guard j == 0 || value != Int.min else { continue }
                
                let s = sum(from: j, to: i + 1)
                update(i + 1, k + 1, value: min(value, s))
            }
        }
    }
    let ans = dp[N][K]
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
validate(main)
#else
main { readLine()! }
#endif
