fun solve() {
    val A = readln().toIntArray()
    var dp = Array(4) { IntArray(4) { 0 } }
    for (j in 0 .. 3) {
        dp[0][j] = A[j]
    }
    for (i in 1 .. 3) {
        for (j in 0 .. 3) {
            if (j - 1 >= 0) {
                dp[i][j] += dp[i - 1][j - 1]
            }
            dp[i][j] += dp[i - 1][j]
            if (j + 1 <= 3) {
                dp[i][j] += dp[i - 1][j + 1]
            }
        }
    }
    println(dp[3][3])
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
