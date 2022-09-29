import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
5 2
1 3 5 8 10
""", expected: """
9
""")

let data2 = TestData(name: "Data 2", text: """
6 3
1 3 5 8 10 1000
""", expected: """
9
""")

let data3 = TestData(name: "Data 3", text: """
6 4
1 3 5 8 10 1000
""", expected: """
4
""")

let data4 = TestData(name: "Data 4", text: """
7 4
1 10000000 10000002 10000004 20000000 30000000 30000002
""", expected: """
9999999
""")

let data5 = TestData(name: "Data 5", text: """
""", expected: """
""")

let validationList = [
//    data1,
//    data2,
//    data3,
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
