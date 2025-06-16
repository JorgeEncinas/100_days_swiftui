import Cocoa

// 1. Write a function that accepts an integer from 1 through 10,000,
//      and returns the integer sqrt of that number.
//      You can't use Swift's built-in sqrt function or similar, you need to find it yourself.
//   If the number is less than 1, or greater than 10,000...
//      Throw an Out of Bounds error
//   Only consider integer square roots - don't worry about the sqrt of 3 being 1.732
//      If you can't find the square root, throw a "No root" error

// As a reminder, square root means that if you multiply a number by itself, you get the target number.

enum IntegerSqrtError : Error {
    case OutOfBounds, NoRoot
}

func integerSqrt(of target: Int) throws -> Int {
    if (target < 1 || target > 10_000) {
        throw IntegerSqrtError.OutOfBounds
    }
    for i in 1...(target / 2) {
        if (i*i == target) {
            return i
        }
    }
    throw IntegerSqrtError.NoRoot
}
var target = 11_111
target = 10000
target = 0
target = 3
do {
    let integerSqrtResult = try integerSqrt(of:target)
    print("The integer square root for your number is: \(integerSqrtResult)")
} catch IntegerSqrtError.OutOfBounds {
    print("Your number should be an integer between [1, 10,000]")
} catch IntegerSqrtError.NoRoot  {
    print("There is no integer square root for your target number: \(target)")
} catch {
    print("You have reached an unexpected state in the application")
}
