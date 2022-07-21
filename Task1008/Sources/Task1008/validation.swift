import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
4 3
1 3 6
0 1 11
1 2 7
""", expected: """
0
11
18
17
""")

let data2 = TestData(name: "Data 2", text: """
5 10
3 1 46
2 1 48
4 2 21
0 1 26
4 1 50
4 0 87
1 0 57
1 3 42
1 2 52
0 4 10
""", expected: """
0
26
31
68
10
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
