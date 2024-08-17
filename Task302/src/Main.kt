fun solve() {
    val (N, X, Y) = readln().toIntArray()
    val dp = IntArray(N) { 0 }
    dp[0] = X
    dp[1] = Y
    for (i in 2 until N) {
        dp[i] = (dp[i - 2] + dp[i - 1]) % 100
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
