import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
5 6
0 4 2
2 0 8
1 3 11
0 1 5
2 4 8
4 1 2
""", expected: """
3
""")

let data2 = TestData(name: "Data 2", text: """
5 4
3 0 67
2 1 13
0 2 50
2 4 83
""", expected: """
4
""")

let data3 = TestData(name: "Data 3", text: """
10 15
6 3 1
0 3 1
7 5 1
1 4 1
9 4 1
9 0 1
2 7 1
2 4 1
5 3 1
6 2 1
9 2 1
9 8 1
8 2 1
0 6 1
0 5 1
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
//    data1,
//    data2,
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
