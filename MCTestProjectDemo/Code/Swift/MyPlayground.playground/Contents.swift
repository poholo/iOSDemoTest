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


let size: Int = 1024 * 1024 + 3333
print("\(size)MB")

let gb = Double(size) / 1024

let gbstr = String(format: "%.1fGB", gb)
print("\(gb)GB")

print(gbstr)


let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let z where z.hasSuffix("pepper"):
    print("Is it a spicy \(z)?")
default:
    print("Everything tastes good in soup.")
}


let names = [70, 80, 20, 8, 59, 60, 98]
names.forEach {
    switch $0{
        case let x where x>=60:
            print("及格")
        default:
            print("不及格")
    }
}

// for in where
for score in names where score >= 60 {
    print("for in where score = \(score)")
}

//let where

let info: String? = "Hello, Swift5.2"
if let str = info, str.hasPrefix("Hello") {
    print(str)
}

//guard let where
/*
guard let str = info, str.hasSuffix("5.2") else {
    print("no 5.2")
    return
}
print(str)
*/


let numbers = [1, 2, 3, 4, 5, 6]
let mapnumbers = numbers.map( { number in 3 * number })
let mapnumbers2 = numbers.map({ 3 * $0 })
print(mapnumbers)
print(mapnumbers2)

enum SpecialError: Error {
    case nmerror
    case noerror
}

func send(job: Int, nm: String) throws -> String {
    if nm == "error" {
        throw SpecialError.nmerror
    } else if job < 100 {
        throw SpecialError.noerror
    } else {
        return "Job sent - " + nm
    }
}

do {
    let result = try send(job: 100, nm: "error")
    print(result)
} catch {
    print(error)
}

do {
    let result = try send(job: 101, nm: "poholo")
    print(result)
} catch {
    print(error)
}


do {
    let result = try send(job: 99, nm: "mm")
    print(result)
} catch SpecialError.noerror {
    print("noerror")
} catch SpecialError.nmerror {
    print("nmerror")
} catch {
    print(error)
}

print("try?")

do {
    let result = try? send(job: 98, nm: "98nm")
    print(result)
} catch {
    print(error)
}


let result = try? send(job: 98, nm: "98nm")
print(result)

print("try!")
do {
    let res2 = try! send(job: 101, nm: "98nm")
    print(res2)
} catch {
    print(error)
}

print("defer")
defer {
    print("HHH")
}

print("defer......-----> start")

enum DeferError: Error {
    case zeroError
}
func testdefer() throws -> Int {
    var idx = 0
    
    print("deferBefore")
    defer {
        idx = 10
        print("deferExecting")
        print(idx)
    }
    if idx == 0 {
        print("throw error")
        throw DeferError.zeroError
    }
    print("deferAfter")
    return idx
}


do {
    let idx = try testdefer()
    print(idx)
} catch {
    print(error)
}

print("defer......-----> End")


//Generics functions methods classes enumatations structs

// functions
func makeArray<Item>(repeating item: Item, numOfTimes: Int) -> [Item] {
    var result = [Item]()
    for _ in 0..<numOfTimes {
        result.append(item)
    }
    return result
}

print(makeArray(repeating: 1, numOfTimes: 4))
print(makeArray(repeating: "aa", numOfTimes: 2))
print(makeArray(repeating: 1.2, numOfTimes: 2))


//enumarations
enum OptionValue<Wrap> {
    case none
    case some(Wrap)
}

var possibleInteger: OptionValue<Int> = .none

print(possibleInteger)
possibleInteger = .some(100)
print(possibleInteger)

//classes
func anyCommenElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool where T.Element: Equatable, T.Element == U.Element {
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    return false
}

print(anyCommenElements([1, 2, 3], [4, 5, 6]))
print(anyCommenElements([1, 2, 3], [3, 4, 5]))
print(anyCommenElements(["a", "b", "c"], ["b", "d", "f"]))

