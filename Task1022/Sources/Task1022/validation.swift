import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
3
3 1 4
""", expected: """
3
""")

let data2 = TestData(name: "Data 2", text: """
1
10
""", expected: """
0
""")

let data3 = TestData(name: "Data 3", text: """
5
1 1 1 1000000000 1000000000
""", expected: """
999999999
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
