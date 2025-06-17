import Cocoa

// CREATE YOUR OWN STRUCTS

// Structs let us create custom, complex data types, with their own variables and functions

struct Album {
    let title: String
    let artist: String
    let year: Int
    
    func printSummary() {
        print(" \(title) (\(year)) by \(artist)")
    }
}

//This is a new Type called `Album`, with two string constants: `title` and `artits`, and an Int constant, `year`
// AND as you can see it can include functions.

// The Swift standard is that structs must start with an uppercase.
let aStudyOfLosses = Album(title: "A Study of Losses", artist: "Beirut", year: 2025)
let hadsel =  Album(title: "Hadsel", artist: "Beirut", year: 2024)

print(aStudyOfLosses.title)
print(hadsel.artist)

aStudyOfLosses.printSummary()
hadsel.printSummary()

// See that when we cal printSummary() on each struct, each instance refers to its own variables, so they're not overwritten by new instances.
// I guess they're the `classes` equivalent of Swift, though there probably is more nuance to this term. Perhaps similar to C or C++ structs?

struct Employee {
    let name: String
    var vacationRemaining: Int
    
    mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days //Swift does not like this line at all, unless you add the `mutating` keyword
            print("I'm vacationing, still \(vacationRemaining) days left!")
        } else {
            print("Looks like my summer vacation is... over.")
        }
    }
}

// You see, when we create an employee instance as a constant using `let`,
//      then Swift will make the Employee and all of its data CONSTANT
//      we can call functions, but those functions should not be allowed to change the struct's data,
//      because we made it constant!

// BUT, we can take an extra step: any functions that change data belonging to the struct,
//  MUST be marked with the `mutating` keyword.
//  This does NOT mean that structs created with `let` may be changed. It won't be allowed.
//  it will ONLY work for structs in a `var`.

var archer = Employee(
    name: "Sterling Archer",
    vacationRemaining: 14
)
archer.takeVacation(days: 5)
print(archer.vacationRemaining)

let archer2 = Employee(
    name: "Robin Hood",
    vacationRemaining: 0
)
//archer2.takeVacation(days: 1) //Not allowed because archer2 is a `let` constant!

// STRUCT - DEFINING ITS COMPONENTS
//      PROPERTIES: Variables and Constants
//      METHODS: Functions that belong to structs.
//      INSTANCE: Creating a constant or variable out of a struct. e.g. a dozen instances of the Album struct
//      INITIALIZER: When we create instances of structs, we do so via an initializer Album(title: ..., artist:..., year:...)

// SYNTACTIC SUGAR - You notice that the initializer is us treating the struct like a function, and passing in parameters
//      It is Syntactic Sugar: Swift silently creates a special function inside the struct called init()
//      using all the properties of the struct as its parameters.
//      Then it automatically treats these two pieces of code as being the same.

var archer3 = Employee(name: "Sterling Archer", vacationRemaining: 14)
var archer4 = Employee.init(name: "Robin Hood", vacationRemaining: 14) //See the original but not quite used format.

//We have relied on syntactic sugar previously as well
let a = 1
let b = 2.0
let c = Double(a) + b //Swift's `Double` is a struct, and has an initializer function that accepts an integer.

//Swift is even smart in creating the struct:
//  The initializer will even account for variables that you've defined a default value, marking them as optional!

struct Employee2 {
    let name: String
    var vacationRemaining: Int = 14
    
    mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days //Swift does not like this line at all, unless you add the `mutating` keyword
            print("I'm vacationing, still \(vacationRemaining) days left!")
        } else {
            print("Looks like my summer vacation is... over.")
        }
    }
}
// Then...
let kane = Employee2(name: "Lana Kane")
let poovey = Employee2(name: "Pam Poovey", vacationRemaining: 35)

// NOTE that if you assign a default value for a CONSTANT property
//      then it will be removed from the initializer entirely!

// COMPUTING PROPERTY VALUES DYNAMICALLY _______________________

// TYPES OF PROPERTY IN STRUCTS
//      1. Stored Property
//          A variable or constant that holds a piece of data inside an instance of the struct
//      2. Computed Property
//          Calculates the value of the property dynamically every time it's accessed.

// For example, looking at our original struct, having a property `vacationRemaining` only,
//      means that whenever we update it, we won't have a way of checking the amount initially allocated.
//      So instead, we could have a Stored Property that told us how many days were allocated
//      a Stored Property to know how many have been taken
//      and so, with these two we will have a way to compute how many days are left.

//      However this computation will be considered a variable!

struct Employee3 {
    let name: String
    var vacationAllocated: Int = 14
    var vacationTaken: Int = 0
    
    var vacationRemaining: Int {
        vacationAllocated - vacationTaken
    }
}

var archer5 = Employee3(name: "Sterling Archer", vacationAllocated: 14)
archer5.vacationTaken += 4
print(archer5.vacationRemaining)
archer5.vacationTaken += 4
print(archer5.vacationRemaining)

// Behind the scenes Swift is running some code to calculate that value every time.
//  however, we can't write to this variable, we have not made code for that.

// there are SETTERS and GETTERS, you see. Let's refine our struct now with that in mind.

struct Employee4 {
    let name: String
    var vacationAllocated: Int = 14
    var vacationTaken: Int = 0
    
    var vacationRemaining: Int {
        get {
           vacationAllocated - vacationTaken
        }
        set {
            vacationAllocated = vacationTaken + newValue
        }
    }
}

// Notice that `newValue` is a variable automatically provided to us by Swift, storing whatever the user was trying to assign
print("____________________")
var archer6 = Employee4(name: "Sterling Archer", vacationAllocated: 14)
archer6.vacationTaken += 4
print(archer6.vacationRemaining)
archer6.vacationRemaining = 5
print(archer6.vacationAllocated)
print(archer6.vacationRemaining)
print(archer6.vacationTaken)

// TAKING ACTION WHEN A PROPERTY CHANGES

//Swift lets us create PROPERTY OBSERVERS
//  These are pieces of codes that run when properties change (so the observer pattern, I guess?)

//  There are 2 Forms:
//      1. didSet observer
//          runs when the property JUST CHANGED
//      2. willSet observer
//          runs BEFORE the property changed.

// Let's see when it might be useful.

struct Game {
    var score = 0
}

var game = Game()
game.score += 10
print("Score is now \(game.score)")
game.score -= 3
print("Score is now \(game.score)")
game.score += 1

// It gets tedious pretty quickly, right? You might even forget to print it
//  So a Property Observer could handle this.

struct Game2 {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

print("--------------------")
var game2 = Game2()
game2.score += 10
game2.score -= 3
game2.score += 1

// Inside didSet, Swift also provides `oldValue`
// There is also a willSet {} variant
//      Which will run the code BEFORE the property changes
//      this provides the newValue that will be assigned in case you want to take different action based on that.


struct App {
    var contacts = [String]() {
        willSet {
            print("Current value is: \(contacts)")
            print("Will change to \(newValue)")
        }
        
        didSet {
            print("There are now \(contacts.count) contacts.")
            print("Before there were \(oldValue.count) contacts, see: \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Adrian E.")
app.contacts.append("Allen W.")
app.contacts.append("Ish S.")

// In practice, willSet is much less used than didSet
// but you might still see it from time to time, so it's important you know it exists.
// regardless, avoid putting too much work in property observers.

// If you trigger too much it "will catch you out on a regular basis and cause all sorts of performance problems."

// CREATE CUSTOM INITIALIZERS.

struct Player  {
    let name: String
    let number: Int
    
}

let player = Player(name: "Megan R.", number: 15) //Memberwise Initializer

// It's an initializer that accepts each property in the order it was defined.
// Possible bc Swift silently generates an initalizer accepting those two values.
//      we could write our own to do the same thing.

struct Player2 {
    let name: String
    let number: Int
    
    init(name: String, number: Int) {
        self.name = name
        self.number = number
    }
}

// Now that we own the initializer, we can add extra functionality here!
// (so yeah, it seems like struct is the class equivalent)

//Note that
// 1. There is no `func` keyword
// 2. Initializers don't need an explicit return type, since it always returns the struct type.
// 3. `self` is used to assign parameters to the struct.
//          you can omit it, it is used to say that `name` (the input argument) and `name` (your struct's property) are different

struct Player3 {
    let name: String
    let number: Int
    
    init(name: String) {
        self.name = name
        self.number = Int.random(in: 1...99)
    }
}

let player3 = Player3(name:"Phoenix Wright")

// You can call other methods of your struct inside your initializer
// but you can't do it BEFORE assigning values to all your properties.
//  Swift needs to ensure everything is safe before proceeding, you see.

// You can add multiple initializers to your structs if you want, as well as leveraging features such as
//    - external parameter names
//    - default values

// However, as soon as you implement your own custom initializers, you lose access to Swift's generated memberwise initializer,
// UNLESS you take extra steps to retain it.
// That's because Swift assumes you might need some special way to initialize your properties!

// LIMITING ACCESS TO INTERNAL DATA USING `ACCESS CONTROL` ----------------------------
//  Swift allows us to access properties and methods of a struct freely
//      but we might want to limit that
//  Or there may be some logic you need to apply before touching your properties,
//      or maybe you know some methods should be executed in some specific ways, and not be all accessible

struct BankAccount {
    var funds = 0
    
    mutating func deposit(amount: Int) {
        funds += amount
    }
    
    mutating func withdraw(amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account = BankAccount()
account.deposit(amount: 100)
let success = account.withdraw(amount: 200)

if success {
    print("We got the moneyyyy")
} else {
    print("You don't have enough moneyyyyy")
}

// As it stands right now, nothing is stopping you from just accessing the `funds` property directly
account.funds += 200 // Now we WILL have the moneyyyy

//So let's make `funds` private

struct BankAccount2 {
    private var funds = 0
    
    mutating func deposit(amount: Int) {
        funds += amount
    }
    
    mutating func withdraw(amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

// This is called ACCESS CONTROL,
//  because it controls how a struct's properties and methods can be accessed OUTSIDE the struct

// ACCESS CONTROL OPTIONS
//  1. private - 'Don't let anything outside the struct use this'
//  2. fileprivate - 'Don't let anything outside the current file use this'
//  3. public - "Let anyone, anywhere use this"

//An extra utility is that you can create private setters

struct BankAccount3 {
    private(set) var funds = 0
    
    mutating func deposit(amount: Int) {
        funds += amount
    }
    
    mutating func withdraw(amount : Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

// NOTE: using `private` access controls means you might need to specify your own custom initializers!

// STATIC PROPERTIES AND METHODS --------------------------------
// Sometimes we want to add a property or method to the STRUCT ITSELF, rather than to one particular instance of the struct.

// I (the 100 days of SwiftUI author) use this technique a lot with SwiftUI for 2 things:
//  1. Creating example data
//  2. Storing fixed data that needs to be accessed in various places.

// First, let's look at a simplified example.

struct School {
    static var studentCount = 0 //"Static mutable properties are generally not safe because they can be concurrently modified from any thread/actor, and this is what the compiler error is trying to communitate. (sic.)" From: https://forums.swift.org/t/static-property-is-not-concurrency-safe-is-there-an-easy-solution/74983/2
    
    static func add(student: String) {
        print("\(student) joined the school")
        studentCount += 1
    }
}

School.add(student: "John Smith")
print(School.studentCount)

// No instandce of `School` to be found, see?
// If you want to mix and match static and non-static properties, two rules:
//      1. To access non-static code from static code, you're out of luck.
//          They can't, because you wouldn't know what particular instance of `School` to refer to.
//      2. To access static code from non-static code, always use your type's name,
//          such as `School.studentCount`. You may also use `Self` to refer to the current type, different from `self` (lowercase `s` here, see?)
//              Self - current type
//              self - current instance

// WHY USE STATIC PROPERTIES?
//      A common use-case is to organize common data in apps.

struct AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeURL = "https://www.hackingwthswift.com"
}
// With that, you can access that easily
AppData.version

// Another case is creating EXAMPLES OF A STRUCT
struct Employee5 {
    let username: String
    let password: String
    
    static let example = Employee5(
        username: "cfederighi",
        password: "hairforceone"
    )
}
// Now you can use Employee.example for your design previews.

// RECAP
//      1. You can create your own structs with `struct Name { * your code here *}
//      2. Structs have PROPERTIES: variables/constants, and METHODS: functions
//      3. If a method tries to modify properties of its struct, mark it as `mutating`
//      4. You can store properties in memory (Stored Properties), or create Computed Properties that calculate a value every time they're accessed.
//      5. Observers like `didSet` and `willSet` inside a struct help us execute some code when a property changes
//      6. Initializers!
//      7. You can create your own initializers, make sure all your properties have a value at the end!
//      8. Access Control: `private` `fileprivate` and `public` to control where and how! also `private(set)`
//      9. Static: It's possible to attach a property or methods directly to a struct, so you can use them without creating an instance of the struct.
