import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream
import java.io.PrintStream

fun main() {
    val data1 = TestData("Data 1", """
        8 8
        ..#.....
        .###.##.
        .###..#.
        ####....
        .#..###.
        .....###
        ....##.#
        .....##.
    """.trimIndent(), """
        3
    """.trimIndent())

    val data2 = TestData("Data 2", """
        3 5
        #.#.#
        .###.
        #.#.#
    """.trimIndent(), """
        5
    """.trimIndent())

    val data3 = TestData("Data 3", """
        5 2
        ..
        ..
        ..
        ..
        ..
    """.trimIndent(), """
        0
    """.trimIndent())

    val data4 = TestData("Data 4", """
    """.trimIndent(), """
    """.trimIndent())

    val data5 = TestData("Data 5", """
    """.trimIndent(), """
    """.trimIndent())

    val validationList = listOf(
        data1,
        data2,
        data3,
//        data4,
//        data5,
    )
    
    println()
    validationList.forEach { it.execute(::solve) }
    println("--------------------------------")
    println()
}

class TestData(
    private val name: String,
    private val data: String,
    private val expected: String,
) {
    fun execute(block: () -> Unit) {
        println("--- [$name] -------------------")
        val originalIn = System.`in`
        val originalOut = System.out
        val actual = ByteArrayInputStream(data.toByteArray()).use { inputStream ->
            ByteArrayOutputStream().use { outputStream ->
                System.setIn(inputStream)
                try {
                    System.setOut(PrintStream(outputStream))
                    try {
                        block()
                        outputStream.toString()
                    } finally {
                        System.setOut(originalOut)
                    }
                } finally {
                    System.setIn(originalIn)
                }
            }
        }
        print(actual)
        if (actual[actual.length - 1] != '\n') {
            println()
        }

        if (expected.isNotEmpty()) {        
            if (actual.trim() == expected.trim()) {
                println("✅ OK")
            } else {
                println("❌ NG")
            }
        }
    }
}
