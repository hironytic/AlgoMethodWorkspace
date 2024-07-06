fun solve() {
    val S = readln()
    val N = readln().toInt()
    val (a, b) = readln().toIntArray()
    println("$S $N $a $b")
}

// ----------------------------------------------------------
fun String.toStringList() = split(" ")
fun String.toIntArray() = toStringList().let { list -> IntArray(list.size) { list[it].toInt() } }
fun String.toLongArray() = toStringList().let { list -> LongArray(list.size) { list[it].toLong() } }
// ----------------------------------------------------------

fun main() {
    solve()
}
