fun solve() {
    val N = readln().toInt()
    var dp = IntArray(N + 1) { 0 }
    dp[0] = 1
    dp[1] = 1
    for (i in 2 .. N) {
        dp[i] = dp[i - 1] + dp[i - 2]
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
