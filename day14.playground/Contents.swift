import Cocoa

// OPTIONALS
//  Swift likes to be predictable, working with code that is as safe as possible
//  one way of ensuring predictability is through `optionals`
//  "This thing might have a value or might not."

let opposites = [
    "Earth" : "Air",
    "Water" : "Fire"
]

var electricityOpposite : String? = opposites["Electricity"]
// If we try a key that doesn't exist...
// The solution is `optionals`, data that might be present or might not.

// You represent them by a Question Mark after your data type `?`

// String? means either a String, or nothing - `nil`
// which means `no value`

// Any kind of data can be optional: Int, Double, Bool,
//  instances of 'enum's, 'struct's, and classes

// HOW OPTIONALS CHANGE THE GAME
// You need code to check for the optional and UNWRAP the optional in order to use it
//  we need to look inside the box to see if there's a value, in which case, we take it out and use it.

if let earthOpposite = opposites["Earth"] {
    print("Earth's opposite is \(earthOpposite)")
} else {
    print("Are they truly opposites anyway?")
}

// if let
// is a very common syntax in Swift. You can also add an `else` block, of course.

// OPTIONALS GIVE IMPORTANCE TO NON-OPTIONALS AS WELL
//      A non-optional means we MUST provide a value.
// Even Array and Dictionary can be optionals if needed.
//  note that empty arrays and dictionaries are different from `nil`.

func square(number: Int) -> Int {
    number * number
}

let number: Int? = nil // Wow, it even allows it when number is defined as a constant.
if let number = number { // ONE MORE THING: It's common to unwrap optionals into a constant of the same name, which is allowed in Swift.
    print(square(number: number))
} else {
    print("No number here")
}

// What is happening is that we temporarily create a second constant of the same name,
//      available ONLY inside the condition's body.
//  This is called SHADOWING, mainly used with optional unwraps as seen above.
//      Inside the condition's body, we have an unwrapped value to work with
//      a real Int, rather than an optional Int?
//      but outside, we still have the optional.

// UNWRAPPING OPTIONALS WITH `GUARD` ----------------------------

// apart from `if let`, the most common way, yes.
// there is also another, almost as common: `guard`

func printSquare(of number: Int?) {
    guard let number = number else {
        print("Missing input")
        return
    }
    print("\(number) * \(number) is \(number * number)")
}

// It lets us check, and if there is it will place the value into a constant of our choosing.
// Otherwise, we enter the `else` block and run that case.

// `guard` provides the ability to check whether our program state is what we expect.
//      and if it isn't, it BAILS OUT

// This is called an EARLY RETURN
//      We check that all a function's inputs are valid right as the function starts,
//      and if any are NOT valid, we run some code and exit right away.

// using `guard`, Swift ALWAYS requires you to use `return` if the check fails.
// on the other hand, `if let` allows you to process them somehow.

// Last tip: you can use guard with ANY CONDITION, not just for unwrapping conditionals
var someArray = [String]()

func example(someArray : [String]) {
    guard someArray.isEmpty else { return }
}

// UNWRAPPING WITH NIL COALESCING
//      There is a third way of unwrapping conditionals
//      called `Nil Coalescing Operator`
//      it lets you unwrap an optional and provide a default value if the optional was empty

let captains = [
    "Enterprise" : "Picard",
    "Voyager" : "Janeway",
    "Defiant" : "Sisko"
]

let new : String = captains["Serenity"] ?? "N/A"
// Attempts to unwrap, and if it fails, uses the alternate value.
let new2 : String = captains["Serenity", default: "N/A"] //This also works

// The difference is that the `nil coalescing operator` works not just for dictionaries, but with any optionals.
//  For example, `randomElement()`
//      it returns ONE random item from the array,
//      but it actually returns an optional, since you might be calling it on an empty arrray.
//  Here we can use `nil coalescing`

let tvShows = ["Archer", "Babylon 5", "Ted Lasso"]
let favorite : String = tvShows.randomElement() ?? "None"

// Perhaps you have a struct with an optional property, and want to provide a sensible default for when it's missing
struct Book {
    let title : String
    let author : String?
}

let book = Book(title: "Beowulf", author: nil)
let author = book.author ?? "Anonymous"
print(author)

let input = ""
let number3 = Int(input) ?? 0 // Hmmm seems like no 'try' or 'tryParse'
print(number3)


// HANDLE MULTIPLE OPTIONALS USING `OPTIONAL CHAINING`

let names = ["Arya", "Bran", "Robb", "Sansa"]
let chosen = names.randomElement()?.uppercased() ?? "No one"
print("Next in line: \(chosen)")

// There are TWO optional features at once.
//      You've already seen how the Nil Coalescing Operator helps provide a default value if an optional is empty
//  Now Optional Chaining,
//      where we have a question mark followed by more code.

//  OPTIONAL CHAINING says:
//      if the optional has a value inside, unwrap it then...
//      and we can add more code.
//  The magic of optional chaining is that it silently does NOTHING if the optional is empty.
//      it will just send back the same optional you had before, still empty.
//      this means that the RETURN VALUE of an OPTIONAL CHAIN is always an OPTIONAL,
//  which is why we STILL need NIL COALESCING to provide a default value.

struct Book2 {
    let title: String
    let author: String?
}

var book2 : Book2? = nil
let author2 = book2?.author?.first?.uppercased() ?? "N/A"
//So, check if we have an author, and if the first letter is there (aka not an empty string), then uppercase it.
print(author2)


// HANDLING FUNCTION FAILURE WITH OPTIONALS -----------------------
//  For functions that might throw errors, we call it using `try` and handle errors,OR
//      if we're certain it won't fail, use `try!`
//      and accept it will crash if it does fail (don't do this)

//  An ALTERNATIVE is to, if you only care about the function failing or succeeding,
//      use an OPTIONAL to try have the function return an Optional Value.
//   That way, you know it worked when your optional has a value,
//      and it didn't work when you have a `nil` on your hands.
//   You won't know what error happened though.

enum UserError : Error {
    case badID, networkFailed
}
func getUser(id : Int) throws -> String { //Notice this always throws.
    throw UserError.networkFailed
}

if let user = try? getUser(id:23) { //`try?` makes getUser() return an OPTIONAL STRING
    print("User: \(user)")
}

let user3 = (try? getUser(id : 23)) ?? "Anonymous" //NOTE: the question mark in try cannot be spaced!
print(user3)

// Uses for `try?`
//      1. In combination with `guard let`,
//              you can exit the current function if `try?` returns `nil`
//      2. In combination with `nil coalescing`,
//              to attempt something or provide a default value on failure
//      3. When calling any throwing function without a return value,
//              when you don't care if it succeeded or not,
//              like writing to a log file, or sending analytics to a server.

// SUMMARY - OPTIONALS
//      Optionals can help with absence of data
//      Everything that isn't optional definitely has a value inside
//      Unwrapping is looking to see if there's a value, otherwise `nil`
//      We can use `if let` to run some code if the optional has a value
//          with `guard let` we check if it DOESN'T have a value, and it must always exit the function (if it's nil)
//      The Nil Coalescing operator `??` unwraps and returns an optional's value
//          or uses a default value instead
//      Optional chaining lets us read optionals inside optionals, or return a default
//      If a function might throw errors, we can CONVERT IT TO AN OPTIONAL
//          using `try?`, you get the value or you get `nil`
