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
let abb = names[2...3]
print(abb)
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
print(shoppingList[1...3])

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


let minteInterval = 5
let mintes = 60
for t in stride(from: 0, through: mintes, by: minteInterval) {
    print(t)
}

print("stide through by")

for t in stride(from: 80, to: 100, by: 4) {
    print(t)
}

let rr = [Int](repeating: 1, count: 20)

print(rr)

var conditon : Bool = true
var numbers = 1
//while conditon {
//    if numbers > 100 {
//        conditon = false
//    } else {
//        numbers += 1
//        print(numbers)
//    }
//}

conditon = true
numbers = 1
repeat {
    if numbers > 100 {
        conditon = false
    } else {
        numbers += 1
        print(numbers)
    }
} while conditon


let json = """
{
            "ct": "topic",
            "foods": [
                {
                    "collectnum": 0,
                    "cooker": {
                        "cooknum": 0,
                        "fansnum": 0,
                        "follownum": 0,
                        "gender": "",
                        "id": "10140888",
                        "job": "",
                        "jointime": 0,
                        "location": "",
                        "nm": "烟火间",
                        "pic": "http://39.105.91.114/images/02/02808ee0c9164ee8b85e003fc2f77bb6_162w_162h.jpg",
                        "token": ""
                    },
                    "cooknum": 11751,
                    "created": 1374199847.0,
                    "ct": "food",
                    "id": "100013174",
                    "isCollected": false,
                    "isPraised": false,
                    "isProfessional": true,
                    "lom": [],
                    "nm": "香辣口水鸡",
                    "pic": "http://39.105.91.114/images/d5/d54269bc87ca11e6b87c0242ac110003_1000w_853h.jpg",
                    "picBig": "http://39.105.91.114/images/d5/d54269bc87ca11e6b87c0242ac110003_1000w_853h.jpg",
                    "planTime": 0.0,
                    "praisenum": 0,
                    "score": "8.5",
                    "step": []
                },
                {
                    "collectnum": 0,
                    "cooker": {
                        "cooknum": 0,
                        "fansnum": 0,
                        "follownum": 0,
                        "gender": "",
                        "id": "10140888",
                        "job": "",
                        "jointime": 0,
                        "location": "",
                        "nm": "烟火间",
                        "pic": "http://39.105.91.114/images/02/02808ee0c9164ee8b85e003fc2f77bb6_162w_162h.jpg",
                        "token": ""
                    },
                    "cooknum": 6842,
                    "created": 1376267516.0,
                    "ct": "food",
                    "id": "100021799",
                    "isCollected": false,
                    "isPraised": false,
                    "isProfessional": true,
                    "lom": [],
                    "nm": "手撕杏鲍菇",
                    "pic": "http://39.105.91.114/images/9a/9a39cd9487d711e6a9a10242ac110002_500w_752h.jpg",
                    "picBig": "http://39.105.91.114/images/9a/9a39cd9487d711e6a9a10242ac110002_500w_752h.jpg",
                    "planTime": 0.0,
                    "praisenum": 0,
                    "score": "8.3",
                    "step": []
                },
                {
                    "collectnum": 0,
                    "cooker": {
                        "cooknum": 0,
                        "fansnum": 0,
                        "follownum": 0,
                        "gender": "",
                        "id": "10001401",
                        "job": "",
                        "jointime": 0,
                        "location": "",
                        "nm": "渍",
                        "pic": "http://39.105.91.114/images/a8/a8b5b274c3264875bb3615aa6af37fcd_160w_160h.jpg",
                        "token": ""
                    },
                    "cooknum": 72395,
                    "created": 1302075491.0,
                    "ct": "food",
                    "id": "1000229",
                    "isCollected": false,
                    "isPraised": false,
                    "isProfessional": true,
                    "lom": [],
                    "nm": "可乐鸡翅",
                    "pic": "http://39.105.91.114/images/ed/ed35e338873811e6b87c0242ac110003_450w_600h.jpg",
                    "picBig": "http://39.105.91.114/images/ed/ed35e338873811e6b87c0242ac110003_450w_600h.jpg",
                    "planTime": 0.0,
                    "praisenum": 0,
                    "score": "8.2",
                    "step": []
                },
                {
                    "collectnum": 0,
                    "cooker": {
                        "cooknum": 0,
                        "fansnum": 0,
                        "follownum": 0,
                        "gender": "",
                        "id": "11566793",
                        "job": "",
                        "jointime": 0,
                        "location": "",
                        "nm": "歌歌小姐",
                        "pic": "http://39.105.91.114/images/47/47735d72549211e7947d0242ac110002_160w_160h.jpg",
                        "token": ""
                    },
                    "cooknum": 3835,
                    "created": 1377056013.0,
                    "ct": "food",
                    "id": "100023491",
                    "isCollected": false,
                    "isPraised": false,
                    "isProfessional": true,
                    "lom": [],
                    "nm": "肉末番茄烧毛豆",
                    "pic": "http://39.105.91.114/images/74/7445f6a287dd11e6b87c0242ac110003_750w_749h.jpg",
                    "picBig": "http://39.105.91.114/images/74/7445f6a287dd11e6b87c0242ac110003_750w_749h.jpg",
                    "planTime": 0.0,
                    "praisenum": 0,
                    "score": "8.2",
                    "step": []
                }
            ],
            "id": "40076",
            "nm": "家常菜"
        }
"""

struct FoodDto: Codable, Identifiable {
    var id: String
    var tids: [String]?
    var nm: String?
    var tags: String?
    var score: Float?
    var praisenum: Int?
    var collect: Int?
    var created: Int?
    var cookednum: Int?
    var isPraised: Bool?
    var isCollected: Bool?
    var pic: String?
    var picBig: String?
    var desc: String?
    var tips: String?
    var isProfessional: Bool?
    var planTime: Int?
}

struct TopicDto: Codable, Identifiable {
    var id: String
    let nm: String?
//    let foods: [FoodDto]
    
//    enum CodginKeys: String, CodingKey { case id, nm, foodarr }
//
//    enum FoodKeys: String, CodginKey { case foods }
//
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decode(String.self, forKey: .id)
//        nm = try values.decode(String.self, forKey: .nm)
//
//        let foodDicts = try values.nestedContainer(keyedBy: FoodKeys.self, forKey: .foodarr)
//
//    }
}

func toModel<T>(_ type: T.Type, value: Any) -> T? where T : Decodable {
    guard let data = try? JSONSerialization.data(withJSONObject: value) else { return nil }
    let decoder = JSONDecoder()
    decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
    let d = try? decoder.decode(type, from: data)
    return d
}

let data = json.data(using: .utf8)


let topic = toModel(TopicDto.self, value: data)


