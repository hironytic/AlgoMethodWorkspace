fun solve() {
    val (N, M, s, t) = readln().toIntArray()
    val G = Array(N) { mutableListOf<Int>() }
    repeat(M) {
        val (a, b) = readln().toIntArray()
        G[a].add(b)
    }
    
    var found = false
    val seen = BooleanArray(N)
    val queue = ArrayDeque<Int>()
    queue.add(s)
    while (queue.isNotEmpty()) {
        val i = queue.removeFirst()
        seen[i] = true
        for (j in G[i]) {
            if (j == t) {
                found = true
                break
            }
            if (!seen[j]) {
                queue.add(j)
            }
        }
        if (found) {
            break
        }
    }
    if (found) {
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
