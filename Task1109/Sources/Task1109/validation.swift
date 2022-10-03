import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
6 2
10 -6 4 -18 11 -2
""", expected: """
19
""")

let data2 = TestData(name: "Data 2", text: """
8 5
-4 -9 -2 0 -7 11 -10 -2
""", expected: """
0
""")

let data3 = TestData(name: "Data 3", text: """
10 3
-1 4 -1 5 9 -2 -6 5 -3 5
""", expected: """
21
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
