import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
JumpsOver
""", expected: """
!?mps#v?r
""")

let data2 = TestData(name: "Data 2", text: """
AlgoMethod
""", expected: """
#lg?!?th?d
""")

let data3 = TestData(name: "Data 3", text: """
abcdefghijABCDEFGHIJ
""", expected: """
?bcd?fgh?j#!!!#!!!#!
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
