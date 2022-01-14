//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()



let a = UIView()
let b = UIView()

if a != b {
    print("a == b")
}

if a !== b {
    print("a === b")
}



"""
properties
"""


struct Shop {
    var eggs: Int
    let price: Int
}

let shop = Shop(eggs: 10, price: 4)

print(shop)

//shop.eggs = 9 err


var sp = Shop(eggs: 11, price: 4)
sp.eggs = 9


class CShop {
    var eddgs: Int
    let price: Int
    
    init(_ e: Int, p: Int) {
        eddgs = e
        price = p
    }
}

let cshop = CShop(10, p: 4)
cshop.eddgs = 11
print(cshop.eddgs)
