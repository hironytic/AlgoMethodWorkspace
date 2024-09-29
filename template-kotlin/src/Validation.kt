import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream
import java.io.PrintStream

fun main() {
    val data1 = TestData("Data 1", """
        input
        1
        2 3
    """.trimIndent(), """
        input 1 2 3
    """.trimIndent())

    val data2 = TestData("Data 2", """
    """.trimIndent(), """
    """.trimIndent())

    val data3 = TestData("Data 3", """
    """.trimIndent(), """
    """.trimIndent())

    val data4 = TestData("Data 4", """
    """.trimIndent(), """
    """.trimIndent())

    val data5 = TestData("Data 5", """
    """.trimIndent(), """
    """.trimIndent())

    val validationList = listOf(
        data1,
//        data2,
//        data3,
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
    private val expected: String? = null,
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

        validate(actual)?.let {
            if (it) {
                println("✅ OK")
            } else {
                println("❌ NG")
            }
        }
    }

    private data class LineReader(val data: String) {
        private val lines = data.split("\n").map { it.trim() }
        private var nextLine = 0

        fun readln(): String {
            return lines[nextLine++]
        }

        fun readlnOrNull(): String? {
            if (nextLine < lines.size) {
                return lines[nextLine++]
            } else {
                return null
            }
        }
    }

    private fun validate(actual: String): Boolean? {
        if (expected == null) {
            return null
        } else {
            val actualReader = LineReader(actual)
            val expectedReader = LineReader(expected)
            var expectedLine = expectedReader.readlnOrNull()
            while (expectedLine != null) {
                val actualLine = actualReader.readlnOrNull()
                if (expectedLine != actualLine) {
                    return false
                }
                expectedLine = expectedReader.readlnOrNull()
            }
            return true
        }
    }
}
