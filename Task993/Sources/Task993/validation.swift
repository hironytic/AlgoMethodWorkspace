import Foundation
#if DEVELOPING
import TestData

let data1 = TestData(enabled: true, name: "Data 1", text: """
4 3
1 3 6
0 1 11
1 2 7
""")

let data2 = TestData(enabled: true, name: "Data 2", text: """
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
""")

let data3 = TestData(enabled: false, name: "Data 3", text: """
""")

let data4 = TestData(enabled: false, name: "Data 4", text: """
""")

let data5 = TestData(enabled: false, name: "Data 5", text: """
""")

let validationList = [data1, data2, data3, data4, data5]

#endif
