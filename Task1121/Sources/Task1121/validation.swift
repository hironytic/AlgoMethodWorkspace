import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
4 6
1 2 3 4
7 9 7 9
""", expected: """
No
""")

let data2 = TestData(name: "Data 2", text: """
5 10
1 2 3 4 5
25 16 9 4 1
""", expected: """
Yes
""")

let data3 = TestData(name: "Data 3", text: """
7 17
1 1 3 5 8 10 15
0 3 10 0 10 0 3
""", expected: """
No
""")

let data4 = TestData(name: "Data 4", text: """
""", expected: """
""")

let data5 = TestData(name: "Data 5", text: """
6 27
1 4 4 1 11 11
1 2 3 4 1 3
""", expected: """
No
""")

let validationList = [
//    data1,
//    data2,
//    data3,
//    data4,
    data5,
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
