import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(name: "Data 1", text: """
5
30 50 60 70 30
40 90 150 100 80
""", expected: """
3
""")

let data2 = TestData(name: "Data 2", text: """
6
4 7 11 9 12 6
20 10 20 13 15 10
""", expected: """
2
""")

let data3 = TestData(name: "Data 3", text: """
4
63 15 35 99
63 15 35 99
""", expected: """
1
""")

let data4 = TestData(name: "Data 4", text: """
""", expected: """
""")

let data5 = TestData(name: "Data 5", text: """
32
73 34 20 19 46 63 66 58 87 87 92 11 31 80 83 46 28 80 42 71 31 56 96 33 65 67 57 31 34 94 39 2
493 524 900 796 548 641 195 936 426 923 340 996 543 532 352 213 658 695 382 732 989 779 433 882 770 454 693 203 111 750 174 603
""", expected: """
23
""")

let validationList = [
    data1,
    data2,
    data3,
//    data4,
    data5,
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
