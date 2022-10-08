import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
5 10
70 70 70 60 30
50 80 40 60 70
60 60 60 60 60
""", expected: """
230
""")

let data2 = TestData(name: "Data 2", text: """
7 29
135 184 123 149 166 170 151
131 162 147 128 159 116 134
197 149 187 140 136 158 113
""", expected: """
803
""")

let data3 = TestData(name: "Data 3", text: """
""", expected: """
""")

let data4 = TestData(name: "Data 4", text: """
""", expected: """
""")

let data5 = TestData(name: "Data 5", text: """
""", expected: """
""")

let validationList = [
    data1,
    data2,
//    data3,
//    data4,
//    data5,
]

// ----------------------------------------------------------
func print(_ items: Any...) {
    TestData.write(items)
}

func validate(_ main: (() -> String) -> Void) {
    validationList.forEach { $0.execute(main) }
}
// ----------------------------------------------------------

#endif
