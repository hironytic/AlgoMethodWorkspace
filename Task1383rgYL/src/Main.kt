fun solve() {
    val (N, M) = readln().toIntArray()
    val G = Array<MutableList<Int>>(N) { mutableListOf() }
    for (i in 0 until M) {
        val (a, b) = readln().toIntArray()
        G[a].add(b)
        G[b].add(a)
    }

    val seen = BooleanArray(N)
    fun rec(v: Int) {
        seen[v] = true
        for (v2 in G[v]) {
            if (seen[v2]) {
                continue
            }
            rec(v2)
        }
    }
    
    var ans = 0
    for (i in 0 until N) {
        if (!seen[i]) {
            ans++
            rec(i)
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
