import Foundation

let u = ["B", "KiB", "MiB", "GiB"]
while let l = readLine() {
    var n = Int(l)!
    for i in 0...3 {
        if n < 1024 {
            print("\(String(n).enumerated().map { i, j in i > 0 ? "0" : "\(j)" }.joined()) \(u[i])")
            break
        } else {
            n /= 1024
        }
    }
}
