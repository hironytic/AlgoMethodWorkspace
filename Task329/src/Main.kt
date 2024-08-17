fun solve() {
    val N = readln().toInt()
    val dp = Array(N) { LongArray(N) { 0 } }
    dp[0][0] = 1
    for (i in 0 .. N - 1) {
        for (j in 0 .. N - 1) {
            if (j + 1 <= N - 1) {
                dp[i][j + 1] += dp[i][j]
            }
            if (i + 1 <= N - 1) {
                dp[i + 1][j] += dp[i][j]
            }
        }
    }
    println(dp[N - 1][N - 1])
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
