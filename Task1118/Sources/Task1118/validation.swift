import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
3 5
80 20 15 50 30
25 40 95 60 85
90 10 30 70 50
""", expected: """
110
""")

let data2 = TestData(name: "Data 2", text: """
1 10
529 463 931 247 385 410 629 666 849 425
""", expected: """
0
""")

let data3 = TestData(name: "Data 3", text: """
5 6
1 4 1 5 9 2
6 5 3 5 8 9
7 9 3 2 3 8
4 6 2 6 4 3
3 8 3 2 7 9
""", expected: """
32
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
