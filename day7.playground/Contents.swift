import Cocoa

func showWelcome() {
    print("Welcome to my app!")
    print("By default this prints out a conversion")
    print("chart from centimeters to inches, but you")
    print("can also set a custom range if you want")
}
showWelcome()

func printTimesTables(number: Int) {
    for i in 1...12 {
        print("\(i) * \(number) is \(i * number)")
    }
}

printTimesTables(number: 5)

func printTimesTables(number: Int, end: Int) {
    for i in 1...end {
        print("\(i) * \(number) is \(i * number)")
    }
}

printTimesTables(number: 5, end: 20)

//Built-in mathematical function
let root = sqrt(169)
print(root)

func rollDice() -> Int {
    return Int.random(in: 1...6)
}
print(rollDice())

func areLettersIdentical(string1 : String, string2 : String) -> Bool {
    let first = string1.sorted()
    let second = string2.sorted()
    
    return first == second
}

print(areLettersIdentical(string1: "doof", string2: "food"))

func ali(string1: String, string2 : String) -> Bool {
    string1.sorted() == string2.sorted()
}

print(ali(string1: "todo", string2: "todo"))

func pythagoras(a: Double, b: Double) -> Double {
    let input = (a * a) + (b * b)
    let root = sqrt(input)
    return root
}

func ptgr(a: Double, b: Double) -> Double {
    return sqrt((a*a)+(b*b))
}
pythagoras(a:2, b:4)
ptgr(a:2,b:4)

func isUppercase(string: String) -> Bool {
    string == string.uppercased()
}
isUppercase(string:"Squidward")
isUppercase(string:"squidward")
isUppercase(string:"SQUIDWARD")

func getUser() -> [String] {
    ["Taylor", "Swift"]
}

let userGU = getUser()
print("Name \(userGU[0]) \(userGU[1])")

func getUser2() -> [String: String] {
    [
        "firstName":"Taylor",
        "lastName":"Swift"
    ]
}
let userGU2 = getUser2()
print("Name: \(userGU2["firstName", default: "Anonymous"]) \(userGU2["lastName", default:"Anonymous"])")

func getUser3() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
}
let userGU3 = getUser3()
print("Name: \(userGU3.firstName) \(userGU3.lastName)")

func getUser4() -> (firstName: String, lastName: String) {
    ("Taylor", "Swift")
}

let userGU4 = getUser4()
print("Name: \(userGU4.firstName) \(userGU4.lastName)")

func getUser5() -> (String, String) {
    ("Taylor", "Swift")
}

let userGU5 = getUser5()
print("Name: \(userGU5.0) \(userGU5.1)")

func getUser6() -> (firstName: String, lastName: String) {
    (firstName: "Charles", lastName: "Xavier")
}

let userGU6 = getUser6()
let firstNameGU6 = userGU6.firstName
let lastNameGU6 = userGU6.lastName

print("Name : \(firstNameGU6) \(lastNameGU6)")

let (firstNameGU7, lastNameGU7) = getUser6()
let (firstNameGU8, _) = getUser6() //Saying you don't care about the second one

// CUSTOMIZE PARAMETER LABELS
func rollDice( sides: Int, count: Int) -> [Int] {
    //Start with an empty array
    var rolls = [Int]()
    
    //Roll as many dice as needed
    for _ in 1...count {
        //Add each result to our array
        let roll = Int.random(in: 1...sides)
        rolls.append(roll)
    }
    return rolls
}

let rolls = rollDice(sides: 6, count: 4)

// Naming parameters for external use is so important that you can overload the method with different arguments!
// Which is unlike many other languages

func hireEmployee(name: String) {}
func hireEmployee(title: String) {}
func hireEmployee(location: String) {}

// Swift will know which one you mean based on the parameter names you provide
// Sometimes, though, these parameter names are less helpful, and there are two ways I want to look at

let lyric = "Un elefante se columpiaba"
print(lyric.hasPrefix("Un elefante"))

// See we don't have to specify string: or prefix:
// When we define the parameters for a function we can actually add TWO names:
//      One for use where the function is called
//      and one for use inside the function itself.

// If you add an underscore before the parameter name, we can remove the external parameter label

func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}

print(isUppercase("HELLO, WORLD"))

func isUppercaseAlt(string : String) -> Bool {
    string == string.uppercased()
}

print(isUppercaseAlt(string: "HELLO, WORLD"))

// Used a lot in Swift in append(), contains(), and in both places it's pretty evident what the parameter is
// without having a label too.

func printTimesTables2(for number: Int) { //This means that your parameter will be named 'for' externally, but 'number' internally
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables2(for: 5)

// DEFAULT PARAMETER VALUES

func printTimesTables3(for number: Int, end: Int = 12) {
    for i in 1...end {
        print("\(i) * \(number) = \(i * number)")
    }
}
printTimesTables3(for: 4)
printTimesTables3(for:4, end: 8)

var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count)
characters.removeAll()
print(characters.count)
characters.removeAll(keepingCapacity: true) //This is an alternative form of it, that keeps the space in case you are about to add a lot of items back into the array

// HANDLING ERRORS IN FUNCTIONS
// 3 Steps
//      1. Tell Swift about possible errors
//      2. Write a function that can flag up errors if they happen
//      3. Call that function, and handling any errors that might happen

// Example: user asks to check how strong their password is
//          We'll flag up a serious error if password is either too short or is obvious

// 1. Defining possible errors
//      For this we extend Swift's Error type with a new Enum!
enum PasswordError: Error {
    case short, obvious
}
// This enum says there are 2 possible errors. We have not assigned any behavior yet

// 2. Writing a function that will trigger one of those error
//      Now a function that will trigger one of those errors.
//      When an error is thrown in Swift, something fatal went wrong,
func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }
    
    if password == "12345" {
        throw PasswordError.obvious
    }
    
    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}

// 1. If a function can run into errors, but not HANDLE them, then you must mark the function as THROWS before the return type (as seen above)
// 2. We don't specify exactly what kind of error is thrown by the function, just that it can throw errors.
// 3. Being marked with throws does not mean the function MUST throw errors, only that it might
// 4. When it comes to throw an error, we write THROW, then one of our Error cases.
//      This IMMEDIATELY exits the function, meaning it won't return a string



