fun solve() {
    val N = readln().toInt()
    val A = readln().toIntArray()
    val dp = Array(N) { IntArray(N) { 0 } }
    for (j in 0 .. N - 1) {
        dp[0][j] = A[j]
    }
    for (i in 1 .. N - 1) {
        for (j in 0 .. N - 1) {
            if (j - 1 >= 0) {
                dp[i][j] += dp[i - 1][j - 1]
                dp[i][j] %= 100
            }
            dp[i][j] += dp[i - 1][j]
            dp[i][j] %= 100
            if (j + 1 <= N - 1) {
                dp[i][j] += dp[i - 1][j + 1]
                dp[i][j] %= 100
            }
        }
    }
    println(dp[N - 1][N  - 1])
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
