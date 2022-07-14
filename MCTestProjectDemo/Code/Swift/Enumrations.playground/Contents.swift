import UIKit

import CommonCrypto

enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

func evaluateArithmetic(_ arithmetic: ArithmeticExpression) -> Int {
    switch arithmetic {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluateArithmetic(left) + evaluateArithmetic(right)
    case let .multiplication(left, right):
        return evaluateArithmetic(left) * evaluateArithmetic(right)
    }
}

extension String {
    
    var md5:String {
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        
        return digest.reduce("") { $0 + String(format:"%02X", $1) }
    }
    
    var md5A:String {
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        
        CC_SHA256(utf8, CC_LONG(utf8!.count - 1), &digest)
        
        return digest.reduce("") { $0 + String(format:"%02X", $1) }
    }
}

let n5 = ArithmeticExpression.number(5)
let n6 = ArithmeticExpression.number(10)

let result = ArithmeticExpression.addition(n5, n6)
let mul = ArithmeticExpression.multiplication(result, ArithmeticExpression.number(2))
let rv = evaluateArithmetic(result)
let mv = evaluateArithmetic(mul)

let uuid = UUID().uuidString
print(uuid)
print(uuid.md5)
print(uuid.md5A)



