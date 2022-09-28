import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
7
1 3 3 2 3 9 4
""", expected: """
1
1
2
2
3
1
1
""")

let data2 = TestData(name: "Data 2", text: """
5
2 2 2 2 2
""", expected: """
1
2
3
4
5
""")

let data3 = TestData(name: "Data 3", text: """
3
1 2 3
""", expected: """
1
1
1
""")

let data4 = TestData(name: "Data 4", text: """
1
100
""", expected: """
1
""")

let data5 = TestData(name: "Data 5", text: """
""", expected: """
""")

let validationList = [
    data1,
    data2,
    data3,
    data4,
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
