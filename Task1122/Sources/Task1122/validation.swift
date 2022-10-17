import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
5
30 50 60 70 30
40 90 150 100 80
""", expected: """
3
""")

let data2 = TestData(name: "Data 2", text: """
6
4 7 11 9 12 6
20 10 20 13 15 10
""", expected: """
2
""")

let data3 = TestData(name: "Data 3", text: """
4
63 15 35 99
63 15 35 99
""", expected: """
1
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
