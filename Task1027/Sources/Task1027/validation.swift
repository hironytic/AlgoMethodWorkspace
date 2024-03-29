import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
3
3 5
2
0 2
1 2
""", expected: """
8
5
""")

let data2 = TestData(name: "Data 2", text: """
4
1 10 100
3
1 3
1 3
1 3
""", expected: """
110
110
110
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
