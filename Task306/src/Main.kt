import kotlin.math.min

fun solve() {
    val (N, M) = readln().toIntArray()
    val A = readln().toIntArray()
    val dp = IntArray(N) { Int.MAX_VALUE }
    dp[0] = 0
    for (i in 1 .. N - 1) {
        for (j in 1 .. M) {
           if (i - j >= 0) {
               dp[i] = min(dp[i], dp[i - j] + j * A[i])
           }
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
