import Cocoa

// sorted(), filter(), map()
// Chain them without using temporary variables

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

// 1. Filter out even numbers
// 2. Sort the array in ascending order
// 3. Map them to strings: "X is a lucky number"
// 4. Print the resulting array, one item per line

luckyNumbers.filter { (number: Int) -> Bool in
    if number % 2 == 0 {
        return false
    }
    return true
}.sorted().map { (item: Int) -> String in
    "\(item) is a lucky number" //The `return` keyword might be unnecessary here.
}.map { (item: String) -> Void in // I probably could further simplify by just not creating an array.
    print(item)
}
print("-----------")
luckyNumbers.filter { (number: Int) -> Bool in
    if number % 2 == 0 { //Here you could also use isMultiple(of: 2)
        return false
    }
    return true
}.sorted().map { (item: Int) -> Void in
    print("\(item) is a lucky number")
}
