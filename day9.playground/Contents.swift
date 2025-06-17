import Cocoa

// Closures

func greetUser() {
    print("Hello person!")
}
greetUser()
var greetCopy = greetUser
greetCopy()

// Notice that to pass the function into a variable you don't use the parenthesis.

let sayHello = { // This is called a CLOSURE EXPRESSION
    print("Hi there I am normal")
}

sayHello()

// Closure Expression is a CLOSURE, a chunk of code we can pass around and call whenever we want

// For closures to accept parameters, there is a special way to write them;
// The braces are obligatory, so the parameters were made to be within.

let sayHello2 = { (name: String) -> String in // See? There's also a `in` keyword
    "Hi \(name)!"
}

// Closures are extensively used in Swift and in SwiftUI.
//  let's get an idea of why.
//  First, let's talk about FUNCTION TYPES

// Pretty similar to TypeScript, you're saying this variable is actually a function that takes no params and returns nothing (void)
var greetCopy2: () -> Void = greetUser

func getUserData(for id: Int) -> String {
    if id == 2001 {
        return "HAL"
    } else {
        return "Anonymous"
    }
}

let data: (Int) -> String = getUserData
let user = data(2001)
print(user)

// Did you notice? When calling the `data` function, we did not have to specify the argument name `for`
getUserData(for: 2000) // This one will MAKE YOU specify the label, otherwise it will complain.

//See here,
//let sayHello2 = { (name: String) -> String in // See? There's also a `in` keyword
//    "Hi \(name)!"
//}
print(sayHello2("Johnny")) //See that this one, in spite of specifying `name`, does NOT require you to add the label?


//Suppose we wanted to control the following sort...
let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let sortedTeam = team.sorted()
print(sortedTeam)

// Sorted actually allows passing a custom sorting function to control that.

func captainFirstSorted(name1: String, name2: String) -> Bool {
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    
    return name1 < name2
}

//Alright, so this is a function that has a special case for sorting: it will push Suzanne towards the top.
//      This is like some sorting function I wrote some time ago for React, and it depended on just being provided the criteria for True/Falsee
//      anyway, whenever it's NOT Suzanne on either String being compared, it just resorts to the Alphabetical Comparison.

let captainFirstTeam = team.sorted(by: captainFirstSorted) //We're providing a custom sorting function!
print(captainFirstTeam)

// RECAP - CLOSURES
// 1. Create anonymous functions in a constant/variable
let sayHello3 = {
    print("Hello mello")
}
sayHello3()
//2. Pass functions into other functions
let captainFirstTeam2 = team.sorted(by: captainFirstSorted)


// We can ALSO put these together!
let captainFirstTeam3 = team.sorted(by: {
    (name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    return name1 < name2
})
print(captainFirstTeam3)

// TRAILING CLOSURES AND SHORTHAND SYNTAX

// We can reduce the amount of syntax that comes with closures.
//  You see the code above? Seems like a lot.
//  Now here's the thing: We seem to be being very explicit: we specify our input arguments, but those are ALREADY forced by .sorted()
//  So we can do a little trick!
//      Just tell the function that we are receiving two arguments, which are assumed to be the ones needed.

//  This is called TRAILING CLOSURE SYNTAX
let captainFirstTeam4 = team.sorted { name1, name2 in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    return name1 < name2
}

// You see how it even gets rid of the parentheses? Quite odd, but explains why closures have the arguments inside, and not outside.

// And you can even get rid of naming the parameters, instead referring to them by position
let captainFirstTeam5 = team.sorted {
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    }
    
    return $0 < $1
}

// To be honest, it may become unclear, and I personally do NOT like it, but it's nice to know that it exists.
// Suppose you were to make a REVERSE sort, then it makes sense to do something like...
let reverseTeam = team.sorted {
    return $0 > $1 //Now the pattern is looking for $0 always being the biggest one (alphabetically)!
}

//`in` marks the END of the parameters, and the start of the function (or closure, you get it)
// Having one line of code means you can even remove the `return`
let reverseTeam2 = team.sorted { $0 > $1 }

// Some `rules` about using SHORTHAND SYNTAX
// Use it unless...
//  1. The closure's code is long
//  2. $0 and friends are used MORE THAN ONCE each
//  3. You get three or more parameters (e.g. $2, $3, ...)

// THE POWER OF CLOSURES: ANOTHER EXAMPLE
let tOnly = team.filter { $0.hasPrefix("T") } //So, just return those items who start with capital T
print(tOnly)

//  The map function (also seen in JavaScript frontend/backends)
let uppercaseTeam = team.map { $0.uppercased() }
print(uppercaseTeam)

// map doesn't expect the return type to be the same as the type you started with;
//  You could have returned an int array or something entirely different.

// SWIFTUI AND CLOSURES - When are you going to use them?
//  1. When you create a list of data on the screen
//          SwiftUI will ask you to provide a function that accepts ONE item from the list, and converts it to something it can display on-screen
//  2. When you create a button, SwiftUI will ask you to provide ONE function to execute when the button is pressed,
//          and ANOTHER to generate the contents of the button: a picture, some text, etc.
//  3. Even stacking pieces of text vertically is done using a closure.

//  The alternative would be to create individual functions every time, but in time you won't
//  you'll see how this closure creation comes naturally then.

// ACCEPTING FUNCTIONS AS PARAMETERS
//      (another thing in JavaScript, even in C# it can be sort of done)

func greetUser2() {
    print("Hi")
}
greetUser2()
var greetCopy3: () -> Void = greetUser2
greetCopy3()

// The syntax is going to be weird again...
func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()
    
    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }
    return numbers
}
// Honestly did not seem that weird. It's just that there is an external argument name `using` and an internal argument name `generator`, and the type definition is clear to me.
//  If anything, it might be confusing since the two arrows are close together here, but one is for the argument, and another for the function as a whole.

let rolls = makeArray(size:50) { // Remember the shorthand syntax for declaring the second argument? It's what's happening here.
    Int.random(in: 1...20)
}

func generateNumber() -> Int {
    Int.random(in:1...20)
}

let newRolls = makeArray(size:50, using: generateNumber)
print(rolls)
print(newRolls)

// In Swift and SwiftUI, you won't often need this (?) but it's good to know.

// ACCEPTING MULTIPLE FUNCTION PARAMETERS
func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) -> Void {
    print("Starting first work")
    first()
    print("Starting second work")
    second()
    print("Starting third work")
    third()
    print("Done.")
}

// How about trailing syntax here? Well...
doImportantWork {
    print("This is the first work...")
} second: {
    print("This is the second work...")
} third: {
    print("This is the third work...")
}

// SWIFT WON'T ALLOW THIS!
//doImportantWork {
//    print("This must always be the first work I guess")
//} third: {
//    print("But maybe you allow this to be defined second, even though it is executed last?")
//} second: {
//    print("Let's see if Swift allows it...")
//}

// WHERE IS THIS USED?
//  Making a section of content in SwiftUI is done with three trailing closures:
//      1. Content itself
//      2. A head to be put above
//      3. A footer to be put below

// SUMMARY: CLOSURES
//      1. You can copy function in Swift. They work the same but won't ask for the external parameter names
//      2. All functions have types, just like other data types.
//          This includes Parameters Received and Return Type.
//      3. You can create closures directly by assigning to a constant or variable.
//      4. Their arguments are defined INSIDE of the brackets though { ( arguments_here) -> return type `in` }
//      5. `in` must follow after the arguments, as it says to Swift that we're done defining them (and now comes the closure body)
//      6. Functions can accept other functions as parameters.
//      7. Instead of passing a dedicated function, you can pass a closure (to a function that accepts functions as arguments)
//      8. When passing a closure as a parameter, you may omit the closure's argument types and even argument names, even the return value sometimes.
//      9. If 1+ of a function's final parameters are functions, you can use trailing closure syntax.
//     10. $0, $1 as implied parameter names can be used, but are often avoided.
//     11. You can make your own functions that accept functions as parameters, though in practice,
//              what's important is for you to know WHEN they're appropriate.
