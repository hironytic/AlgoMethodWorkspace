import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream
import java.io.PrintStream

fun main() {
    val data1 = TestData("Data 1", """
        8 12 1 5
        0 1
        0 2
        0 4
        1 3
        1 7
        2 4
        3 2
        3 6
        5 3
        5 4
        6 5
        6 7
    """.trimIndent(), """
        Yes
    """.trimIndent())

    val data2 = TestData("Data 2", """
        8 12 5 1
        3 6
        5 4
        0 2
        1 7
        2 4
        0 4
        1 3
        0 1
        6 5
        6 7
        3 2
        5 3
    """.trimIndent(), """
        No
    """.trimIndent())

    val data3 = TestData("Data 3", """
        4 3 3 0
        1 2
        2 3
        3 1
    """.trimIndent(), """
        No
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
