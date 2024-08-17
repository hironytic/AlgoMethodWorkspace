import kotlin.math.min

fun solve() {
    val N = readln().toInt()
    val A = readln().toIntArray()
    
    val dp = IntArray(N) { Int.MAX_VALUE }
    dp[0] = 0
    for (i in 1 .. N - 1) {
        // マス i - 1 から移動
        dp[i] = min(dp[i], dp[i - 1] + A[i])
        
        // マス i - 2 から移動
        if (i > 1) {
            dp[i] = min(dp[i], dp[i - 2] + 2 * A[i])
        }
    }
    println(dp[N - 1])
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
