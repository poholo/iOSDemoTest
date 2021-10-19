import UIKit


let a = 5e2
let b = 5e-2
let c = 0b0101
let c2 = 0b0001
let c3 = 0b0010
let d = 0o77
let d1 = 0o10

let f = 0x1abcdef

let f1 = 0x9.3p0

let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0

let paddeDouble = 000_123.456
let oneMillion = 1_000_1000

let cannotBeNegative: UInt8 = 1 // -2
// UInt8 can't store negative numbers, and so this will report an error
let tooBig: Int8 = Int8.max //+1
// Int8 can't store a number larger than its maximum value,
// and so this will also report an error


let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
typealias AudioSample = UInt16
let aa: AudioSample = 10

let aaa: String? = "1"
var bbb: String? = aaa

let success = true
assert(success, "success failed")

let result = true
precondition(result, "precondition failed")

func countInch(_ pwx: Double, phx: Double, ppi: Double) -> Double {
    sqrt(pow(pwx, 2) + pow(phx, 2)) / ppi
}

let (pxw, pxh, ppi): (Double, Double, Double) = (1170, 2532, 460)


let ip13proinch = countInch(pxw, phx: pxh, ppi: ppi)
let ip13maxinch = countInch(1284, phx: 2778, ppi: 458)

let ip13w = pxw / ppi
let ip13h = pxh / ppi

let ip13wcm = ip13w * 2.54
let ip13hcm = ip13h * 2.54

let inch = sqrt(pow(ip13w, 2) + pow(ip13h, 2))

let names = ["a", "b", "c", "d"]

print("2...3")
for a in names[2...3] {
    print(a)
}


print("2..<3")
for a in names[2..<3] {
    print(a)
}

print("2...")
for a in names[2...] {
    print(a)
}



print("...2")
for a in names[...2] {
    print(a)
}

print("..<2")
for a in names[..<2] {
    print(a)
}


//let b = ...4
//print(b)


let age1: [Int] = [1, 2, 3, 4, 5]
let age2: [Int] = [6, 7, 8, 9, 10]
let sumage = age1 + age2
print(sumage)

var shoppingList = ["shoes", "book"]

shoppingList.append("food")

shoppingList += ["milk", "orange"]

print(shoppingList)

shoppingList[2...4] = ["H", "K", "L"]
print(shoppingList)

shoppingList.insert("A", at: 2)
print(shoppingList)

shoppingList.popLast()
print(shoppingList)

//shoppingList.remove(at: 2)
//shoppingList.removeLast(2)
//shoppingList.removeFirst(2)
//let range = Range<Int>(uncheckedBounds: (lower: 2, upper: 6))
//shoppingList.removeSubrange(range)
//shoppingList.removeAll { $0 == "K"}
//shoppingList.removeAll { $0.contains("o")}
//shoppingList.removeAll { $0.contains { $0 == "o"}}
//print(shoppingList)

for item in shoppingList {
    print(item)
}

for (index, item) in shoppingList.enumerated() {
    print(index)
    print(item)
}

var sets = Set<Int>()
sets.insert(2)
sets.insert(10)
sets.insert(100)
sets.insert(1000)
sets.insert(2)
print(sets)

sets.remove(10)
print(sets)


sets = [25, 10, 15]
print(sets)

print(sets.isEmpty)

for item in sets { print(item)}
print("repeat")
for item in sets.sorted() { print(item) }


let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

print(houseAnimals == farmAnimals)
print(houseAnimals.isSubset(of: farmAnimals))
print(houseAnimals.isSubset(of: houseAnimals))
print(houseAnimals.isSuperset(of: houseAnimals))
print(houseAnimals.isStrictSubset(of: houseAnimals))
print(houseAnimals.isStrictSuperset(of: houseAnimals))
print(houseAnimals.union(cityAnimals))
print(houseAnimals.intersection(farmAnimals))


var airports = ["BJ": "Beijin", "LD": "London"]
airports["HK"] = "Hankon"
airports.updateValue("TE", forKey: "TEST")
print(airports)

for (key, value) in airports {
    print(key + "-" + value)
}
