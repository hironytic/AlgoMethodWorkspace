import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
2 1
6
2 1
0 1
2 1
2 0
1 0
2 0
""", expected: """
No
Yes
Yes
No
""")

let data2 = TestData(name: "Data 2", text: """
5 0
10
0 0
2 1
1 2
1 0
0 1
1 2
2 3
2 0
0 3
2 1
""", expected: """
No
No
No
Yes
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
