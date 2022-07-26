import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
2 2
31
41
59 26
""", expected: """
26
""")

let data2 = TestData(name: "Data 2", text: """
2 5
1 2 3 4
5 6 7 8
5 4 3 2 1
""", expected: """
6
""")

let data3 = TestData(name: "Data 3", text: """
8 5
22 29 10 19
82 41 47 66
44 55 93 66
78 62 48 55
50 93 41 36
2 9 80 69
16 67 20 53
86 58 61 15
34 52 18 39 36
71 100 80 45 58
13 16 75 98 89
70 15 80 53 75
91 1 85 31 60
75 34 57 69 56
23 25 57 54 56
""", expected: """
829
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
