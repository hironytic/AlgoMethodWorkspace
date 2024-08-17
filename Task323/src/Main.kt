fun solve() {
    val (N, M) = readln().toIntArray()
    val D = readln().toIntArray()
    val dp = BooleanArray(N + 1) { false }
    dp[0] = true
    for (i in 0 .. N - 1) {
        if (!dp[i]) {
            continue
        }
        for (d in D) {
            if (i + d <= N) {
                dp[i + d] = true
            }
        }
    }
    if (dp[N]) {
        println("Yes")
    } else {
        println("No")
    }
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
