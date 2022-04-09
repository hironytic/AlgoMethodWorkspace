import Foundation

class Runner {
    var forward: Int = -1
    var backward: Int = -1
    var withdrawn: Bool = false
}

func main() {
    let n = read().asInt()
    let a = read().asList(ofInt)
    
    let runners = (0 ..< n).map { _ in Runner() }
    var fw = a[0]
//#if DEVELOPING
//    var top = fw
//#endif
    for i in a[1...] {
        runners[fw].backward = i
        runners[i].forward = fw
        fw = i
    }

    func forward(_ i: Int) -> Int {
        if i == -1 {
            return -1
        } else {
            return runners[i].forward
        }
    }
    
    func setForward(_ i: Int, forward: Int) {
        if i != -1 {
            runners[i].forward = forward
        }
    }
    
    func backward(_ i: Int) -> Int {
        if i == -1 {
            return -1
        } else {
            return runners[i].backward
        }
    }
    
    func setBackward(_ i: Int, backward: Int) {
        if i != -1 {
            runners[i].backward = backward
        }
    }
    
    let q = read().asInt()
    for _ in 0 ..< q {
        let query = read().asList(ofInt)
        switch query[0] {
        case 0:
            let r = query[1]
            if runners[r].withdrawn || runners[r].forward == -1 {
                print("Error")
            } else {
                let fw = forward(r)
                let fw2 = forward(fw)
                let bw = backward(r)
                
                print(fw)
                
                setBackward(fw2, backward: r)
                setForward(r, forward: fw2)
                setBackward(r, backward: fw)
                setForward(fw, forward: r)
                setBackward(fw, backward: bw)
                setForward(bw, forward: fw)
                
//#if DEVELOPING
//                if fw == top {
//                    top = r
//                }
//#endif
            }
        case 1:
            let r = query[1]
            runners[r].withdrawn = true

            let fw = forward(r)
            let bw = backward(r)
            setBackward(fw, backward: bw)
            setForward(bw, forward: fw)
            
            setForward(r, forward: -1)
            setBackward(r, backward: -1)
            
//#if DEVELOPING
//            if r == top {
//                top = bw
//            }
//#endif
        default:
            break
        }
        
//#if DEVELOPING
//        print("---")
//        var c = top
//        while c != -1 {
//            print("-> \(c)")
//            c = backward(c)
//        }
//        print("---")
//#endif
    }
}

// ----------------------------------------------------------
func ofInt<S: StringProtocol>(_ string: S) -> Int { Int(string)! }
func ofDouble<S: StringProtocol>(_ string: S) -> Double { Double(string)! }
extension StringProtocol {
    func asInt() -> Int { ofInt(self) }
    func asDouble() -> Double { ofDouble(self) }
    func asList() -> [SubSequence] { split(separator: " ") }
    func asList<T>(_ transform: (SubSequence) -> T) -> [T] { asList().map(transform) }
}
extension Array {
    func asTuple() -> (Element, Element) { (self[0], self[1]) }
    func asTuple() -> (Element, Element, Element) { (self[0], self[1], self[2]) }
}
// ----------------------------------------------------------
#if DEVELOPING
let testData = TestData("""
6
5 0 3 2 4 1
6
0 1
0 1
0 1
1 0
0 1
0 1
""")
func read() -> String {
    return testData.read()
}
#else
func read() -> String { readLine()! }
#endif

main()
