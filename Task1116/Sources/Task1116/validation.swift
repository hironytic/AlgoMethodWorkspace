import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
5
60 70 10 50 80
40 40 20 90 30
""", expected: """
210
""")

let data2 = TestData(name: "Data 2", text: """
7
3 1 4 1 5 9 2
6 5 3 5 8 9 7
""", expected: """
32
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
