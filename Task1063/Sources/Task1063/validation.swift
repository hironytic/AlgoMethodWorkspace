import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
12 5
""", expected: """
8
""")

let data2 = TestData(name: "Data 2", text: """
13 5
""", expected: """
8
""")

let data3 = TestData(name: "Data 3", text: """
3 12
""", expected: """
3
""")

let data4 = TestData(name: "Data 4", text: """
364418270 376388288
""", expected: """
26248222
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
