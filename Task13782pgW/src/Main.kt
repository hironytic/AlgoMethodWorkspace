fun solve() {
    val (N, M) = readln().toIntArray()
    val G = Array<MutableList<Int>>(N) { mutableListOf() }
    for (i in 0 until M) {
        val (a, b) = readln().toIntArray()
        G[a].add(b)
    }
    
    val seen = BooleanArray(N)
    val ans = mutableListOf<Int>()
    fun rec(v: Int) {
        seen[v] = true
        ans.add(v)
        for (v2 in G[v].sorted()) {
            if (seen[v2]) {
                continue
            }
            rec(v2)
        }
    }
    rec(0)
    
    print(ans.joinToString(" "))
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
