import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
8 12
0 1 11
0 2 7
0 4 8
1 3 7
1 7 6
2 3 1
2 4 10
3 5 4
3 6 2
4 5 9
5 6 3
6 7 5
""", expected: """
32
""")

let data2 = TestData(name: "Data 2", text: """
5 4
3 0 67
2 1 13
0 2 50
2 4 83
""", expected: """
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
