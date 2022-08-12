import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
5
1 2 3 4 5
3
1 3
0 4
0 5
""", expected: """
5
10
15
""")

let data2 = TestData(name: "Data 2", text: """
10
1 1 1 1 1 1 1 1 1 1
3
0 1
5 9
5 9
""", expected: """
1
4
4
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
