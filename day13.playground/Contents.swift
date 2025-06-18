import Cocoa

// CREATE AND USE PROTOCOLS
//      They are a bit like CONTRACTS in Swift (interfaces?)
//      They let us define what kinds of functionality we expect a data type to support
//      and Swift ensures the rest of our code follows those rules.

// For example, simulating someone commuting from their home to their office.

class Car2 {
    
}

func commute(distance: Int, using vehicle: Car2) {
    // Lots of code here
}

// But what if they travel by Bus?
class Bus {
    
}

func commute(distance: Int, using vehicle: Bus) {
    
}

// Or a bike, a scooter, a ride share, you get the point.
// Then we really have to realize we don't care about HOW the underlying trip happens.

// We care about something more high level:
//      How long it might take for the user to commute using each option,
//      and how to perform the actual act of moving to the new location.

// This is where protocols come in.
//      They let us define PROPERTIES and METHODS that we want to use, WITHOUT IMPLEMENTING THEM
//      We're just saying that the properties and methods must exist, a bit like a BLUEPRINT.

protocol Vehicle {
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

// Since our protocol creates a new Type, we need to use Camel Case, starting with an uppercase letter.
//      Inside the protocol we list all the methods we require in order for the protocol to work the way we expect.
//      The methods do NOT contain any code inside, there are no function bodies providd here.

//  You mark:
//      - Method names
//      - Parameters
//      - Return Types
//      - Methods as being throwing or mutating (if needed)

// Then you can design types that work with that protocol:
//  - Structs
//  - Classes
//  - Enums
// That implement the requirements for that protocol, which is a process called `adopting` or `conforming` to the protocol.


// The protocol does NOT specify the full range of Functionality that must exist; only a BARE MINIMUM.
// This means when you create NEW TYPES that conform to the protocol,
//      you can add all sorts of other properties
//      and methods as needed.

struct Car : Vehicle {
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }
    
    func travel(distance : Int) -> Void {
        print("I'm driving \(distance)km.")
    }
    
    func openSunroof() -> Void {
        print("Sunroof at 99% openness")
    }
}

// Notice we added an extra function there in Car and it doesn't complain
//     It cares only about you implementing whatever the protocol asks for.

// So now let's update `commute()` so that it uses the new methods we added to `Car`
func commute2(distance: Int, using vehicle: Vehicle) { // The book uses `Car` instead of Vehicle here, but come on, this was the next step.
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! Try a different vehicle")
    } else {
        vehicle.travel(distance: distance)
    }
}

let car = Car()
commute2(distance: 100, using: car)


struct Bicycle: Vehicle {
    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }
    
    func travel(distance: Int) -> Void {
        print("I'm cycling for \(distance)km!?!")
    }
}

let bike = Bicycle()
commute2(distance: 50, using: bike)

//Protocols can describe PROPERTIES as well, not only Methods.

protocol Vehicle2 {
    var name: String { get }
    var currentPassengers: Int { get set }
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

// That adds 2 properties:
//      1. A string called name, which must be readable. That might mean (imply) two things:
//          - It is a constant.
//          - It can be a Computed Property with a getter.
//      2. An integer `currentPassenger`, read-write. It implies two things:
//          - It's a variable (you can modify it)
//          - It might be a Computed Property with a `getter` and a `setter`

// TYPE ANNOTATION is required, since we cannot specify a DEFAULT VALUE in a protocol, just like they can't have implementations for methods.


struct Car3 : Vehicle2 {
    let name = "Car"
    var currentPassengers = 1
    
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }
    
    func travel(distance : Int) -> Void {
        print("I'm driving \(distance)km.")
    }
    
    func openSunroof() -> Void {
        print("Sunroof at 99% openness")
    }
}

struct Bicycle3: Vehicle2 {
    let name = "Bicycle"
    var currentPassengers: Int = 1 //Here the `Int` specification might be unnecessary, but I prefer having it explicitly.
    
    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }
    
    func travel(distance: Int) -> Void {
        print("I'm cycling for \(distance)km!?!")
    }
}


// Again, you could replace those with computed properties as long as you obey the rules,
//      If you use { get set } then you can't conform to the protocol using a constant property

struct Airplane : Vehicle2 {
    var name = "Airplane" //
    var currentPassengers = 100 // If this is `let`: "Candidate is not settable, but protocol requires it"
    
    func estimateTime(for distance: Int) -> Int {
        distance / 300
    }
    
    func travel(distance: Int) -> Void {
        print("I'm flying for \(distance)km")
    }
}

var ap = Airplane()
ap.name = "Some Other Name Airplane"
print(ap.name)

// So now our protocol requires two methods, and two properties.
// Now we can write a method that accepts vehicles and we can ensure that whatever is needed to work them will be there.

func getTravelEstimates(using vehicles: [Vehicle2], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print("\(vehicle.name) estimate: \(estimate) hours to travel \(distance)km. Passengers: \(vehicle.currentPassengers)")
    }
}
print("-------------------")
var bike3 = Bicycle3()
var car3 = Car3(currentPassengers: 5)
getTravelEstimates(using: [ap, bike3, car3], distance: 100)

// We can also return PROTOCOLS FROM A FUNCTION wowie!

// Also, a struct or class or enum can conform to AS MANY PROTOCOLS AS YOU WANT, listing them one by one, separated with a comma.
//   AND you can also Subclass something AND conform to a protocol
//   you should put the parent class name first, THEN write your protocols afterwards.


// OPAQUE RETURN TYPES ___________________________
//  These let us REMOVE COMPLEXITY in our code.
//      you will see it in our first SwiftUI project as well.

func getRandomNumber() -> Int {
    Int.random(in: 1...6)
}

func getRandomBool() -> Bool {
    Bool.random()
}

// Both `Int` and `Bool` are types that conform to a Swift PROTOCOL called `Equatable`
//  which means "can be compared for equality"
//  that is, it allows us to use `==`
//  print(getRandomNumber() == getRandomNumber())

// So, because both types conform to Equatable, you could try
//  setting them up to return an Equatable, but it won't work

func getRandomNumberEq() -> some Equatable {
    Int.random(in:1...6)
}

func getRandomBoolEq() -> some Equatable {
    Bool.random()
}

//  "Returning `Equatable` does not make sense" is what Swift means with the error
//  "protocol 'Equatable' can only be used as a generic constraint because it has Self or associated type requirements"
//      NOTE: To me it says: "Use of protocol 'Equatable' as a type must be written 'any Equatable'"
//              in fact changing it to "any Equatable" worked

// If it is possible to return Protocols from functions, for example, a Vehicle,
// And now Int and Bool are conforming to Equatable as well....
// The thing is that unlike Vehicles, these aren't INTERCHANGEABLE
//      That is, we can't use `==` to compare an Int and a Bool
//  Swift won't let us regardless of what protocols they conform to.

// While Vehicle can hide information but maintain functionality,
// such a thing is different with `Equatable`,
// because it is not possible to compare two different Equatable things.
// Even if we call `getRandomNumber()` twice, we can't compare them,

// Because we've hidden their exact data type: the fact that they're two integers.

// So we add the `some` keyword, and it is used for PROTOCOLS

// `some` VS `any` PROTOCOL
// `some` is faster, limits you to a specific type, which is known at compile type,
//      most importantly it is OPAQUE, fixed conforming type                            -ChatGPT
// `any` is slower, can return different types all conforming to the protocol, is NOT known at compile time,
//      it is of EXISTENTIAL TYPE, any conforming type.



// Now with `some` Equatable we can call getRandomNumber() twice and compare results. Swift knows that behind-the-scenes they are two Integers.
// WHAT IS THE POINT?
//      It means we can focus on the FUNCTIONALITY we want to return, rather than the specific type.
//      so we can change our minds about the specific return type later.

// `Vehicle` -> Any sort of Vehicle type, but we don't know what
// `some Vehicle` -> A specific sort of Vehicle type but we don't want to say which one


// SWIFTUI EXAMPLE
//      SwiftUI needs to know what kind of layout, exactly, you want to show on the screen
//      We need to be explicit about every single thing we want to show on the screen
//          - positions, colors, font sizes, ...
//      Can you imagine typing that as your return type?
//          it would be long, and each time you change something, you would need to change the return type to match
//      Instead we use opaque return types
//          - We return `some View`
//          Which means we just don't want to bother writing the entire thing.


// HOW TO CREATE AND USE EXTENSIONS --------------------------
//  Extensions let us add functionality to any type, whether we created it or someone else created it,
//      even one of Apple's own types.

// So let us see with `trimmingCharacters(in:)`

var quote = "   The truth is rarely pure and never simple   "

let trimmed = quote.trimmingCharacters(in: .whitespacesAndNewlines)

// It's a bit wordy, so let's make a shortcut for it
extension String {      //`extension` tells Swift to add functionality to an existing type
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// Which type? `String`
// What are we adding? a method called `trimmed()`
// We want it to return a new String
// Inside we call the same method, and the return is implied, since there is only one statement.
// `self` refers to the current string.
// Now this is defined everywhere (I guess in this playground, who knows how it applies in a more structured project across files)

let trimmed2 = quote.trimmed()


//Is this better than a regular function?
func trim(_ string: String) -> String {
    string.trimmingCharacters(in: .whitespacesAndNewlines)
}
let trimmed3 = trim(quote)

// This would be a `global function`, since it is available everywhere.
// It also seems shorter, but there are a number of benefits over the global function...
//      1. typing `quote.` brings a list of functions, and it would include your extensions, making them easy to find.
//      2. Writing global functions makes your code messy,
//          they are hard to organize, and hard to keep track of
//          Extensions, on the other hand, are naturally grouped by the data type they are extending
//      3. Because your extension methods are a full part of the Original Type,
//          they get full access to the type's INTERNAL DATA
//          That means they can use properties and methods marked with `private` Access Control.
//      4. Extensions make it easy to modify values IN PLACE, without returning a new value.

// For example (about point 4.)
extension String {
    mutating func trim() {
        self = self.trimmed() //Of course, now we got two trimming functions, perhaps we should move that code here instead, but this is for an example's sake.
    }
}

quote.trim() //Easier to do now!


// NOTE: Before we called it `trimmed()` and now we called it `trim()` and that is ON PURPOSE
//      It is a Swift guideline.
//      If you return a NEW VALUE, use word endings like -ed, or -ing, like `reversed()`
//      If you modify in place, the verb is more present tense


// ADDING PROPERTIES VIA EXTENSIONS
//  While you CAN do this, the rule is that they can ONLY BE COMPUTED PROPERTIES
//  Adding Stored Properties would affect the actual size of the data types
//      For example, every integer everywhere would take up more space in memory, causing problems.

// EXAMPLE OF ADDING A COMPUTED PROPERTY
extension String {
    var lines : [String] {
        self.components(separatedBy: .newlines)
    }
}

let lyrics = """
But I keep cruising
Can't stop, won't stop moving
It's like I got this music in my mind
Saying it's gonna be alright
"""

print(lyrics.lines.count) //We are calling our String object, then its `lines` property, and then count, a property of Arrays.

// EXTENSIONS' GOALS
//  Making the code easier to write, read, and maintain

struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int
    
    //init(title: String, pageCount: Int) {
    //    self.title = title
    //    self.pageCount = pageCount
    //    self.readingHours = pageCount / 50
    //}
    
    init(title: String, pageCount: Int, readingHours: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = readingHours
    }
}

let lotr = Book(
    title: "Lord of the Rings",
    pageCount: 1178,
    readingHours: 24
)

//Anyway, here's what we're thinking:
//  If we implement a custom initializer INSIDE an extension, then swift won't disable
//  the AUTOMATIC MEMBERWISE INITIALIZER (which I implemented here just because I can't stand errors)
//  If adding a new initializer INSIDE an extension also disabled the default initializer,
//  one small change from us could break code, so it makes sense that it is kept.

extension Book {
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}


// CREATE AND USE PROTOCOL EXTENSIONS --------------------------------

// Protocols define CONTRACTS that conforming types adhere to.
//  Extensions let us add functionality to existing types.
//  What would happen if we add `extension` to Protocols?

// PROTOCOL EXTENSIONS - Any types conforming to that protocol get those methods!

let guests = ["Mario", "Luigi", "Wario"]

if guests.isEmpty == false { //!guests.isEmpty
    print("Guest count: \(guests.count)")
}

// What about a very simple example
extension Array {
    var isNotEmpty : Bool {
        isEmpty == false //self.isEmpty
    }
}

if guests.isNotEmpty {
    print("Guest count: \(guests.count)")
}

// What about sets and dictionaries? Surely we can repeat ourselves, but instead...
// There is a better solution: `Collection`, the protocol they all conform to (arrays, dictionaries, sets)

extension Collection {
    var isNotEmpty : Bool {
        isEmpty == false
    }
}

// That extension exists in a lot of projects due to simple readability.

// Apple calls this technique `Protocol-oriented Programming`
//  we list some required methods in a protocol, then add default implementations of those inside a protocol extension!

protocol Person {
    var name: String { get }
    func sayHello()
}

extension Person {
    func sayHello() {
        print("Hello, my name is \(name)!")
    }
}

class Employee : Person {
    let name : String
    var profession : String
    
    init(name: String, profession : String) {
        self.name = name
        self.profession = profession
    }
}

let taylor = Employee(name: "Taylor Swift", profession: "Artist")
taylor.sayHello()


// GETTING THE MOST OF PROTOCOL EXTENSIONS -----------------------

extension Int {
    func squared() -> Int {
        self * self
    }
}

let wholeNumber = 5
print(wholeNumber.squared())

// But if we want it on a Double as well, without copying code, then we must do something similar to what we did in `Collection`

extension Numeric {
    func squared() -> Self { //Int
        self * self
    }
}

// But that won't work!
// Why?
//  Because self can now be any kind of number, so you can't expect to return an Int if you multiply two Doubles.
//  Instead let's use the `Self` keyword as a return type.
//  What does that mean?
//  `self` refers to the current value,
//  `Self` refers to the current type! So we can effectively return it now!


// Another example ---------------------------
struct User: Equatable {
    let name: String
}

let user1 = User(name: "Ringo")
let user2 = User(name: "Paul")
print(user1 == user2)
print(user1 != user2)

// What Swift does is compare ALL the properties of one object agains the same properties in the other object.
// We can go further, with `Comparable`, another Swift protocol.
//      It allows Swift to see if one object should be sorted before another.
//      Swift can't automatically implement this in our Custom Types.

struct User2 : Equatable, Comparable {
    let name: String
}

func <(lhs : User2, rhs: User2) -> Bool { //This function is called `<`, and accepts a lef hand side, and a right hand side, and compares them for sorting.
    lhs.name < rhs.name
}

let user3 = User2(name: "Ringo")
let user4 = User2(name: "Paul")
print(user3 <= user4)
print(user3 > user4)
print(user3 >= user4)

struct User3: Comparable { //Even better, we don't need `Equatable` to get `==` to work, just having Comparable is fine. Comparable inherits from Equatable, you see!
    let name: String
}

//If you don't have this function, then you will get an error that your struct does NOT conform to Comparable.
func <(lhs : User3, rhs: User3) -> Bool { //This function is called `<`, and accepts a lef hand side, and a right hand side, and compares them for sorting.
    lhs.name < rhs.name
}

// SUMMARY
//      - Protocols: Contracts for code, specify PROPERTIES and METHODS, and conforming types must implement them
//      - Opaque Return Types: Behind the scenes they conform to a specific type, and Swift knows it,
//          but the information is hidden to gain flexibility while writing our code. THe functionality is focused on, not the information
//      - Extensions let us add FUNCTIONALITY to our own custom types,
//          or even to Swift's built-in types.
//          You can add Methods or Computed Properties (but not Stored Properties to Swift's built-in types)
//      - Protocol Extensions let us add Functionality to many types at once.
//          you can use it to implement default functionality as well,
//          and to avoid losing your default memberwise initializer
