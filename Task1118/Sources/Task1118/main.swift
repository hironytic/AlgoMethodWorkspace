import Foundation

func main(read: () -> String) {
    let (M, N) = read().asList(ofInt).asTuple()
    let A: [[Int]] = (0 ..< M).map { _ in read().asList(ofInt) }

    // 全体を通して「bits」とはMビットの値で下位からiビット目が1ならi行目が黒、0なら白という意味
    // 例：bits が 0b1101 なら
    //   ■
    //   □
    //   ■
    //   ■

    // 全て黒に塗った場合のbits
    let allBlack = (1 << M) - 1

    // j列目がbitsのときの、j列目の黒マスの数字の和を求める
    func columnSum(_ j: Int, bits: Int) -> Int {
        var result = 0
        for i in 0 ..< M {
            if bits & (1 << i) != 0 {
                result += A[i][j]
            }
        }
        return result
    }

    // 3列分のbitsを与えてこれが条件（どの白色マスも、自身に隣接している白色マスの個数は 2 個以下である）
    // を満たすかどうか調べる
    // O(M)
    func validate(_ leftBits: Int, _ middleBits: Int, _ rightBits: Int) -> Bool {
        for (l, m, r) in [
            (allBlack, leftBits, middleBits),
            (leftBits, middleBits, rightBits),
            (middleBits, rightBits, allBlack),
        ] {
            for i in 0 ..< M {
                if m & (1 << i) == 0 { // 白マス
                    var count = 0
                    
                    // 上
                    if i > 0 {
                        if m & (1 << (i - 1)) == 0 {
                            count += 1
                        }
                    }
                    
                    // 下
                    if i < M - 1 {
                        if m & (1 << (i + 1)) == 0 {
                            count += 1
                        }
                    }
                    
                    // 左
                    if l & (1 << i) == 0 {
                        count += 1
                    }
                    
                    // 右
                    if r & (1 << i) == 0 {
                        count += 1
                    }
                    
                    if count > 2 {
                        return false
                    }
                }
            }
        }
        return true
    }

    // values[bitsPair]
    // bitsPairの下位Mビットが真ん中の列のbits、その上のMビットが左の列のbitsとしたときに、
    // 条件を満たすような右の列になり得るbitsの配列
    // 求めるのにかかる計算量は O(2^(3*M) * M)。M=5なら O(163,840)
    let values: [[Int]] = { () -> [[Int]] in
        var result = [[Int]](repeating: [], count: 1 << (M * 2))
        for leftBits in 0 ..< (1 << M) {
            for middleBits in 0 ..< (1 << M) {
                let bitsPair = (leftBits << M) | middleBits
                for rightBits in 0 ..< (1 << M) {
                    if validate(leftBits, middleBits, rightBits) {
                        result[bitsPair].append(rightBits)
                    }
                }
            }
        }
        return result
    }()

    // dp[j][bitsPair]
    // j列目まで塗ったときに、
    // j列目がbitsPairの下位Mビットのbits、j-1列目がその上のMビットのbitsになる場合の
    // 塗った数字の総和の最小値
    var dp = [[Int]](repeating: .init(repeating: Int.max, count: 1 << (M * 2)), count: N)
    
    func update(_ j: Int, _ bitsPair: Int, value: Int) {
        dp[j][bitsPair] = min(dp[j][bitsPair], value)
    }
    
    // j=0
    for bits in values[(allBlack << M) | allBlack] {
        update(0, (allBlack << M) | bits, value: columnSum(0, bits: bits))
    }
    
    // j>0
    // 最高でO(2^(3*M) * N)。M=5,N=100なら3,276,800
    for j in 1 ..< N {
        for bitsPair in 0 ..< (1 << (M * 2)) {
            let value = dp[j - 1][bitsPair]
            guard value != Int.max else { continue }
            
            let shiftedMiddleBits = (bitsPair & ((1 << M) - 1)) << M
            for rightBits in values[bitsPair] {
                update(j, shiftedMiddleBits | rightBits, value: value + columnSum(j, bits: rightBits))
            }
        }
    }
    
    let ans = dp[N - 1].min()!
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
