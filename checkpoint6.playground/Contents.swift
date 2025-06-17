import Cocoa

// Create a struct to store information about a CAR:
// -model
// -number of seats
// -current gear

// Add a method to change gears up or down.
//  Think about variables and access control: what should be variable, and what should be constant?
//  What data should be exposed publicly?
//  Think about gear input validation.

enum CarGears {
    case first
    case second
    case third
    case fourth
    case fifth
    case reverse
}

//struct CarGear {
//    let gear: CarGears
//    let allowedGears: Set<CarGears> //This will make it easier.
//}

struct Car {
    let model: String
    let numberOfSeats: Int
    private var currentGear: CarGears = CarGears.first
    private var speed: Int = 0
    
    private static let gears : [CarGears : Set<CarGears>] = [ // A more advanced version would let you modify this from car to car.
        CarGears.first : [CarGears.second, CarGears.reverse],
        CarGears.second : [CarGears.first, CarGears.third],
        CarGears.third : [CarGears.second, CarGears.fourth, CarGears.first],
        CarGears.fourth: [CarGears.third, CarGears.fifth, CarGears.second, CarGears.first],
        CarGears.fifth: [CarGears.fourth, CarGears.third, CarGears.second, CarGears.first],
        CarGears.reverse: [CarGears.first]
    ]
    
    mutating func changeGear(to newGear: CarGears) {
        if Car.gears[self.currentGear] != nil && Car.gears[self.currentGear]!.contains(newGear) {
            self.currentGear = newGear
            print("You have successfully changed to \(self.currentGear)")
        } else {
            print("You try moving the gears. The move was not possible. The car windows leave, they feel disrespected. The chassis cries, it can't believe what you've done.")
        }
    }
    
    mutating func accelerate(to newSpeed: Int) {
        self.speed = newSpeed
    }
    
    init(model: String, numberOfSeats: Int) {
        self.model = model
        self.numberOfSeats = numberOfSeats
    }
}

// I am going to keep it simple, but it would really be a combination of the current gear and the speed at least, wouldn't it?
// So states would be more complicated.
// For example, maybe I should include neutral!

var car = Car(model: "Toyota", numberOfSeats: 5)
car.changeGear(to: CarGears.second)
car.changeGear(to: CarGears.second)
car.changeGear(to: CarGears.reverse)
car.changeGear(to: CarGears.third)

// A smarter solution would imply that we have a number integrated within each state, so that just by checking the numbers we know if we're able to.
// Of course, we need to also consider reverse.

// Anyway, this is all a bigger complication than was expected of this exercise, as I can tell from the hint, now that I'm checking them, and it says to just go from 1 to 10
struct Car2 {
    let model: String
    let numberOfSeats: Int
    let maxGear: Int
    private var currentGear: Int = 1
    
    mutating func changeGear(to newGear: Int) {
        if newGear < 1 || newGear > self.maxGear {
            print("Gear chosen not within car's capabilities")
        } else if newGear == self.currentGear || newGear == self.currentGear + 1 || newGear < self.currentGear {
            self.currentGear = newGear
            print("New Gear: \(self.currentGear)")
        } else {
            print("You can't go to that gear, go between intermediate gears first!")
        }
    }
    
    init(model: String, numberOfSeats: Int, maxGear: Int) {
        self.model = model
        var cap = 60
        if(numberOfSeats > cap) {
            print("A Number of Seats of \(numberOfSeats)?!?! Buddy, we're capping you at \(cap)")
            self.numberOfSeats = cap
        } else {
            self.numberOfSeats = numberOfSeats
        }
        var defaultMaxGear = 5
        var maxGearLimit = 10
        if maxGear < 1 {
            print("Yeah right, Max Gear is not \(maxGear), we're setting it to \(defaultMaxGear)")
            self.maxGear = defaultMaxGear
        } else if maxGear > maxGearLimit {
            print("A Max Gear of \(maxGear)?!?!? We don't do that here, have a max of \(maxGearLimit)")
            self.maxGear = maxGearLimit
        } else {
            self.maxGear = maxGear
        }
    }
}

var car2 = Car2(model: "Toyota", numberOfSeats: 5, maxGear: 5)
car2.changeGear(to: 2)
car2.changeGear(to: 2)
car2.changeGear(to: 4)
car2.changeGear(to: 3)
car2.changeGear(to: 1)

//Alright, seems to conform better to specifications
