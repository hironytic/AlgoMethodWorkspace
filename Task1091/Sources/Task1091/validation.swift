import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
2020
""", expected: """
Yes
""")

let data2 = TestData(name: "Data 2", text: """
1900
""", expected: """
No
""")

let data3 = TestData(name: "Data 3", text: """
1603
""", expected: """
No
""")

let data4 = TestData(name: "Data 4", text: """
2000
""", expected: """
Yes
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
