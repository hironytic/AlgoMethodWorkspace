import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
2
13
""", expected: """
1101
""")

let data2 = TestData(name: "Data 2", text: """
5
2022
""", expected: """
31042
""")

let data3 = TestData(name: "Data 3", text: """
3
0
""", expected: """
0
""")

let data4 = TestData(name: "Data 4", text: """
8
18014398509481983
""", expected: """
777777777777777777
""")

let data5 = TestData(name: "Data 5", text: """
""", expected: """
""")

let validationList = [
    data1,
    data2,
    data3,
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
