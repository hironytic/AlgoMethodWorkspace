fun solve() {
    val (H, W) = readln().toIntArray()
    val G = Array(H) { BooleanArray(W) }
    for (r in 0 until H) {
        val line = readln().toList()
        for ((c, ch) in line.withIndex()) {
            G[r][c] = ch == '#'
        }
    }
    
    val seen = Array(H) { BooleanArray(W) }
    fun rec(r: Int, c: Int) {
        seen[r][c] = true
        if (r - 1 >= 0 && G[r - 1][c] && !seen[r - 1][c]) {
            rec(r - 1, c)
        }
        if (r + 1 < H && G[r + 1][c] && !seen[r + 1][c]) {
            rec(r + 1, c)
        }
        if (c - 1 >= 0 && G[r][c - 1] && !seen[r][c - 1]) {
            rec(r, c - 1)
        }
        if (c + 1 < W && G[r][c + 1] && !seen[r][c + 1]) {
            rec(r, c + 1)
        }
    }
    
    var ans = 0
    for (r in 0 until H) {
        for (c in 0 until W) {
            if (G[r][c] && !seen[r][c]) {
                ans++
                rec(r, c)
            }
        }
    }
    println(ans)
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
