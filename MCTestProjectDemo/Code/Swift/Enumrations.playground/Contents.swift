import UIKit

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

let n5 = ArithmeticExpression.number(5)
let n6 = ArithmeticExpression.number(10)

let result = ArithmeticExpression.addition(n5, n6)
let mul = ArithmeticExpression.multiplication(result, ArithmeticExpression.number(2))
let rv = evaluateArithmetic(result)
let mv = evaluateArithmetic(mul)
