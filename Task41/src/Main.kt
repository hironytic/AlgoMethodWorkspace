import kotlin.math.max

fun solve() {
    val N = readln().toInt()
    val A = Array(N) { LongArray(3) { 0 } }
    for (i in 0 .. N - 1) {
        val Ai = readln().toLongArray()
        for (j in 0 .. 2) {
            A[i][j] = Ai[j]
        }
    }
    
    val dp = Array(N) { LongArray(3) { 0 } }
    
    // 0日目はどれでも取り組める
    for (j in 0 .. 2) {
        dp[0][j] = A[0][j]
    }
    
    // 1日目以降
    for (i in 1 .. N - 1) {
        for (j in 0 .. 2) {
            val prevYen = LongArray(3) { 0 }
            for (k in 0 .. 2) {
                if (j == k) {
                    continue
                }
                prevYen[k] = dp[i - 1][k]
            }
            dp[i][j] = A[i][j] + prevYen.maxOrNull()!!
        }
    }
    
    println(dp[N - 1].maxOrNull()!!)
}

// ----------------------------------------------------------
fun readln() = readLine()!!
fun String.toStringList() = split(" ")
fun String.toIntArray() = toStringList().let { list -> IntArray(list.size) { list[it].toInt() } }
fun String.toLongArray() = toStringList().let { list -> LongArray(list.size) { list[it].toLong() } }
// ----------------------------------------------------------

fun main() {
    solve()
}
