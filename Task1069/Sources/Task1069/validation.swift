import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
32768 9472 43680 661 384 416 0 0
""", expected: """
x.......
.xoo....
xxxxxx..
...xxooo
...ox...
...oxx..
........
........
""")

let data2 = TestData(name: "Data 2", text: """
0 0 0 384 576 0 0 0
""", expected: """
........
........
........
...ox...
...xo...
........
........
........
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
