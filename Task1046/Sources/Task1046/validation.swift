import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
1 0
7
2 0
0 0
2 0
1 0
2 0
1 0
2 0
""", expected: """
off
on
off
off
""")

let data2 = TestData(name: "Data 2", text: """
4 5
8
2 0
2 1
2 2
2 3
1 2
0 3
2 2
2 3
""", expected: """
on
off
on
off
off
on
""")

let data3 = TestData(name: "Data 3", text: """
30 1073741822
6
2 0
2 29
0 0
2 0
1 29
2 29
""", expected: """
off
on
on
off
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
