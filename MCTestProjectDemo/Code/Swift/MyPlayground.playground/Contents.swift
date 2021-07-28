var a1 = 1
var a2 = 2
var a3 = 3
var a = [a1, a2, a3]
a1 = 10
print(a)
var b = a

print(b)

class A {}

class B: A {}

let aa = A()
let bb = B()

print(aa.self)
print(bb.self)
print(aa is A)
print(bb is A)

var bytes: [CChar] = [1, 2, 3]

var u: String = "http://baidu.com/大家看;领导看见/abc/aaa.json?param=data&s=的;打卡进度;放假啊;"
import Foundation

let url = u.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
print(url)

let url2 = "http://img.gymchina.com/h5/pc/fs/专题管理/690x216.png".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

print(url2)
