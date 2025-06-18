import Cocoa

// Write a function that accepts an optional array of integers
//  and returns one randomly
// IF array is missing or empty,
//  return a random number in the range [1, 100]

// The CATCH: write your function in a single line of code.

func randomPicker(from intArray: [Int]?) -> Int { intArray?.randomElement() ?? Int.random(in: 1...100) }

print(randomPicker(from:[]))
print(randomPicker(from:[-1, -2, -3, -4]))
