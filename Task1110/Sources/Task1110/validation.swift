import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
4 3
1135
""", expected: """
5
""")

let data2 = TestData(name: "Data 2", text: """
7 10
1475842
""", expected: """
0
""")

let data3 = TestData(name: "Data 3", text: """
33 2
314159265358979323846264338327950
""", expected: """
647094440
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
    data3,
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
