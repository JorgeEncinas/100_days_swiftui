import Cocoa

// CREATE YOUR OWN CLASSES

// Swift PREFERS structs for storing most of its data types...
//      String, Int, Double, Array

// But there is another way to create Custom Data Types: CLASSES

//  IN COMMON WITH STRUCTS
//      - You get to create and name them
//      - You can add properties and methods, including
//          - Property Observers
//          - Access Control
//      - You can create Custom Initializers to configure new instances however you want


//  DIFFERENT FROM STRUCTS
//      - INHERITANCE, with extension and overriding
//      - Swift doesn't automatically generate a memberwise initialzier for classes.
//          you either write your own initializer, or assign default values to all your properties
//      - When you copy an instance of a class, both copies SHARE that same data, if you change one copy, the other one also changes
//      - When the final copy of a class instance is destroyed, Swift can OPTIONALLY run a special function called a DEINITIALIZER
//      - Even if you make a class CONSTANT, you can still change its properties as long as they are variables. (!!!)

// One reason Swift uses classes is because
//   All copies of a class share the same data,
//   which means many parts of your App can share the same information!
//   so that if the user changes their name in ONE screen, ALL the other screens would automatically update to reflect that change!

// About the other points...
//  1. Being able to build one class based on another
//      is really important for UIKit (Apple's older framework)
//      in UIKit it was common to have long class hierarchies (class A, built on class B, which was built on class C, which was built on class D,...)
//      but it's less common in SwiftUI

//  2. Lacking a memberwise initializer is annoying,
//      but it's tricky to have it due to inheritance.

//  3. Being able to change a constant class's variables links in to the multiple copy behavior of classes
//      We can't change what object our copy points to,
//      BUT if the properties are variable one can modify the object.
//      In Structs, every copy is unique, and holds its own data.

//  4. Because one instance of a class can be REFERENCED in several places, it becomes important to know
//      when the final copy has been destroyed!
//      That's where the deinitializer comes in:
//      it allows us to clean up any special resources we allocated when that last copy goes away

// Let's look at a slice of code that Creates and Uses a Class

class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()
newGame.score += 10

// INHERITANCE - HOW TO MAKE ONE CLASS INHERIT FROM ANOTHER
//      Swift lets us create classes by basing them on existing classes.
//      a process known as INHERITANCE (OOP my boy is back)

// The CHILD class or SUBCLASS inherits from the PARENT or SUPER class.
//      Swift will give the new class access to
//          - The PROPERTIES
//          - The METHODS
//      of the parent class, allowing us to make small additions or changes to customize the way the new class behaves.


// To inherit, we need a colon after the class's name

class Employee {
    let hours: Int
    
    init(hours: Int) {
        self.hours = hours
    }
}

class Developer : Employee { //See here? The inheritance is specified.
    func work() {
        print("I am writing code for \(self.hours) hours! HELP ME")
    }
}

class Manager : Employee {
    func work() {
        print("I am going to meetings for \(hours) hours!")
    }
}


//Si it is implied that they both have hours; They don't have to repeat themselves.

let robert = Developer(hours: 9)
let joseph = Manager(hours: 8)

robert.work()
joseph.work()

// You can also share methods, which can be called from the child classes.

class Employee2 {
    let hours: Int
    
    init(hours: Int) {
        self.hours = hours
    }
    
    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}

class Developer2 : Employee2 { //See here? The inheritance is specified.
    func work() {
        print("I am writing code for \(self.hours) hours! HELP ME")
    }
}

class Manager2 : Employee2 {
    func work() {
        print("I am going to meetings for \(hours) hours!")
    }
}

let novall = Developer2(hours: 8)
novall.printSummary()

// What if you want to CHANGE A METHOD YOU INHERITED? then we must use OVERRIDE

class Developer3: Employee2 {
    func work() {
        print("I code for about \(hours) hours a day.")
    }
    override func printSummary() {
        print("I'm a developer who will sometimes work \(hours) hours a day, other times I will spend it arguing about simple things such as tabs vs spaces")
    }
}

// THE `final` KEYWORD
//  If your class should NOT support inheritance, make sure you mark it as `final`
//      which means that, while the class CAN INHERIT, it can be used to inherit FROM. No Children!

// When you don't need `override`
//      If your child class has a method with a different signature, then you do NOT require the `override` keyword.

// ADDING INITIALIZERS FOR CLASSES _______________________
//      Initializers are a bit more complex than was the case for structs.
//      The part that matters is that if a Child Class has any Initializers, it must always call the PARENT'S INITIALIZER after it has finished
//      setting up its own properties (if it has any)

// Swift doesn't automatically create an initializer for classes *as opposed to structs)
//      it applies whether there is inheritance or not.
// So either write your own or provide default values for all properties of the class.

class Vehicle {
    let isElectric: Bool
    
    init(isElectric : Bool) {
        self.isElectric = isElectric
    }
}

// That has a single boolean property, plus an initializer for setting that value

class Car: Vehicle {
    let isConvertible : Bool
    
    init(isElectric: Bool, isConvertible : Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}

// `super` is a value that Swift provides and allows us to call up methods that belong to our parent class, such as its initializer.
//      You can use it with other methods, its not limited to initializers

let teslaX = Car(isElectric: true, isConvertible: false)

// NOTE: INHERITING INITIALIZERS
//      If a subclass does NOT have any of its own initializers, it automatically inherits the initializer of its parent class.

// COPYING CLASSES --------------------
//      In Swift, all copies of a class instance share THE SAME DATA
//      Any changes done to one copy will automatically change all other copies
//      This happens because classes are REFERENCE TYPES in Swift,
//      which means all copies of a class all REFER BACK to the same underlying pot of data.

class User {
    var username = "Anonymous"
}

var user1 = User()
var user2 = user1
user2.username = "Taylor"
print(user1.username)
print(user2.username)
//Both print "Taylor"

// This is an important feature used in SwiftUI, since it relies heavily on classes for its data, specifically for the ease of sharing.
// struct User would give us a very different result, because every copy is a unique instance!

// DEEP COPY
// A unique copy of a class, you need to handle the creation of a new instance and the copying of data.

class User2 {
    var username = "Anonymous"
    
    func copy() -> User2 {
        let user = User2()
        user.username = self.username
        return user
    }
}
// Now changes are limited to each specific instance.

// CLASS DEINITIALIZERS ----------------------
//      It gets called when the object is DESTROYED, rather than when it's created.

// 1. Just like initializers, you don't use `func`, since they are special
// 2. Deinitializers can NEVER take parameters or return data.
//      as a result, they are not even written with parenthesies
// 3. They are automatically called when the final copy of a class instance is destroyed.
//      That might mean it was created inside a function that is now finishing.
// 4. We never call Deinitializers DIRECTLY; they are automatically handled by the system
// 5. Structs don't have Deinitializers, because you can't copy them.


// WHEN your Deinitializers are called depends on WHAT you're doing, but really it comes down to a concept called SCOPE.
// SCOPE
//  The context where information is available.

//  1. Variables created within a function are only available inside it.
//  2. Variables inside an `if` condition only exist within
//  3. Variables inside a `for` loop only exist within

class User3 {
    let id: Int
    
    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }
    
    deinit {
        print("User \(id): I'm dead!")
    }
}

for i in 1...3 {
    let user = User3(id: i)
    print("User \(user.id): I'm in control!")
}

// Remember, deinitializer is called ONLY when the LAST REMAINING REFERENCE
//      to a class instance is DESTROYED
// For example, if we were adding our `User` instances as they were created, they would only be destroyed when the array is cleared.

var users = [User3]()

for i in 1...3 {
    let user = User3(id: i)
    print("User \(user.id): I'm in control!")
    users.append(user)
}

print("The loop is finished, but the users are not dead yet.")
users.removeAll()
print("By now, surely you saw them destroyed.")


// USING VARIABLES INSIDE CLASSES
// Every copy of a class instance is actually a pointer to the same instance.

class User4 {
    var name: String = "Paul"
}

let user = User4()
user.name = "Ringo"
print(user.name)

// This changed a supposedly 'constant' value, did it not?
//      well, not quite.
// The data inside changed, but the instance has NOT changed, and CANNOT be changed.
// The pointer cannot be reassigned.

// Of course, we were also allowed the change because the variable was `var` and not `let`.

var user4 = User4()
user4.name = "Ringo"
user4 = User4()
print(user4.name) // this prints "Paul" again, and that is because we are allowed to reassign the pointer to a different instance, since `user4` was created with `var`

// So, 4 possibilities
//  1. Constant Instance, Constant Property
//  2. Constant Instance, Variable Property
//  3. Variable Instance, Constant Property
//  4. Variable Instance, Variable Property

// Now say you've been given a `User` instance, which is constant, but the property is declared as a variable
// It tells you that the property may be changed; that there could be a copy somewhere!

// Constant properties mean that you can be sure that NEITHER your current code, nor ANY other code, can change it.
// This is different from `struct`s, because constant structs cannot have their properties changed even fi the properties were made variable!
//      That is because they hold their data DIRECTLY!


// Trying to change a value inside the struct means you're implicitly changing the struct itself!
//  Which isn't possible because it's constant.

// The UPSIDE: you don't need to use `mutating` keyword with methods that change their data!
//  For structs it is important because constant structs CAN NOT have their properties changed no matter HOW they were created.
//      so if Swift sees us calling a `mutating` method on a constant struct instance, it knows it SHOULD NOT BE ALLOWED.

// With classes, how the instance itself was creted no longer matters.
//      The only thing that determines whether a property can be modified or not is...
//      whether the property itself was created as a constant.
//  Swift can see that for itself, just by looking at how you made the property.

// SUMMARY
//  Classes and Structs are similar, but there are 5 key differences/
//      1. Classes have INHERITANCE
//              They get Properties and Methods of their parent class
//              You can override methods
//              or mark the class as `final`
//      2. Swift doesn't generate a memberwise initializer for classes
//              You need to do them yourself, and you need to, for subclasses, call the parent's class initializer
//      3. If you create a Class Instance then take copies of it,
//              copies are pointing to the same instance, and so modifying that instance will reflect on all uses of that instance.
//      4. Classes can have Deinitializers that run when the last copy of one instance is destroyed
//      5. Variable properties in class instances can be changed,
//          regardless of whether the class is constant or variable


