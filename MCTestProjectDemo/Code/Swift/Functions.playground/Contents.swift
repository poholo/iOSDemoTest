//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    
    var v = 0
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
        moreParams(1, 2, 3.0, 5.1, 2)
        moreParams(22, 223.1, 5)
        print(v)
        inoutTest(&v)
        print(v)
        
        let (a, b) = (10, 11)
        let test = (b, a)
        
        print(add(1, 2))
        print(add(1.1, 2))
        
        moreBig(11, 99, 1.0)
        
//        testTT()
        
        print(["a", "b", "ac", "ba", "dd"].sorted { $0 > $1})
        
        print(["a", "b", "ac", "ba", "dd"].sorted(by: >))
        
        testClosure {
            print("testC2")
        }
        
        testClosure(closure: {
            print("testC3")
        })
        
        var e = 0
        reqData(nil) {
            print("success")
        } failed: {
            e += 1
            print("failed1")
            print(e)
        }
        
        reqData(["a": "a"]) {
            print("success2")
            e = 5
            print(e)
        } failed: {
            print("failed")
        }
        
        let creater = makeIncremeter(orinMount: 10)
        
        print(creater())
        print(creater())
        
        

    }

    func moreParams(_ nums: Float...) {
        print(nums)
    }
    func inoutTest(_ value: inout Int) {
        value += 1
        print(value)
    }
    
    func testClosure(closure: () -> ()) {
        print("closure1")
        closure()
    }
    
    func reqData(_ params: [String: Any]?, success: () -> (), failed: () -> ()) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            if params != nil {
                success()
            } else {
                failed()
            }
//        }
    }
    
    func makeIncremeter(orinMount: Int) -> () -> Int {
        var runnintTotal = 0
        func increater() -> Int {
            runnintTotal += orinMount
            return runnintTotal
        }
        return increater
    }
//
//    func add(_ a: Int, _ b: Int) -> Int {
//        a + b
//    }
//
//    func add(_ a: Float, _ b: Float) -> Float {
//        a + b
//    }
    
    func add<T>(_ a: T, _ b: T) -> T where T : AdditiveArithmetic {
        a + b
    }
    
    func bigOne<T>(_ a: T, _ b: T) -> T where T : Comparable {
        max(a, b)
    }
    
    
    func moreBig<T>(_ a: T, _ b: T, _ c: T) where T: Comparable {
        let big: (_ a: T, _ b: T) -> T = bigOne
        let d = big(a, b)
        print(d)
        print(big(a, big(a,b)))
        
    }
    
//    func testTT() {
//
//        let bb = bigOne
//        print(more(bb))
//    }
//
//    func more(_ m: (_ a: Int, _ b: Int) -> Int) -> Int {
//        m(12, 11)
//    }
    
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()


