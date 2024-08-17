fun solve() {
    val N = readln().toInt()
    var dp = IntArray(N + 1) { 0 }
    dp[0] = 1
    for (i in 0 .. N - 1) {
        dp[i + 1] += dp[i]
        if (i + 2 <= N) {
            dp[i + 2] += dp[i]
        }
        if (i + 3 <= N) {
            dp[i + 3] += dp[i]
        }
    }
    println(dp[N])
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
