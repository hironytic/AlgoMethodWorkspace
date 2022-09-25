import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
12 31 7
2021 1 1 6
2021 1 3
""", expected: """
1
""")

let data2 = TestData(name: "Data 2", text: """
100 100 100
3000 100 100 1
1 1 1
""", expected: """
2
""")

let data3 = TestData(name: "Data 3", text: """
12 31 7
2021 1 3 1
2021 1 1
""", expected: """
6
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
