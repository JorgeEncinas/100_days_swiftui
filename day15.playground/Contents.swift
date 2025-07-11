import Cocoa

// Day 15, the big long review

// Constants and variables
var name = "Ted"
name = "Rebecca"

let user = "Daphne"
print(user)

let actor = "Tom Cruise 😎"

let quote = "He tapped a sign saying \"Believe\" and walked away."
let movie = """
A day in
the life of an
Apple engineer
"""

print(actor.count)
print(quote.hasPrefix("He"))
print(quote.hasSuffix("Away.")) //case-sensitive

let score = 10
let higherScore = score + 10
let halvedScore = score / 2

var counter = 10
counter += 5

let number = 120 //Non-modifiable once assigned.
print(number.isMultiple(of: 3))

let id = Int.random(in: 1...1000)

// DECIMALS
let score2 = 3.0

// BOOLEANS
let goodDogs = true
let gameOver = false

var isSaved = false
isSaved.toggle()

// JOINING STRINGS
let name2 = "Taylor"
let age = 26
let message = "I'm \(name2) and I'm \(age) years old."
print(message)

//Arrays
var colors = ["Red", "Green", "Blue"]
let numbers = [1, 2, 3, 4]
var readings = [0.2, 0.3, 0.4]

colors.append("Tartan")
colors.remove(at:0)
print(colors.count)

print(colors.contains("Octarine"))

// DICTIONARIES


// Enums
enum Weather {
    case sun, rain, wind
}

let forecast = Weather.sun
switch forecast {
case .sun:
    print("A nice day")
case .rain:
    print("A very nice day")
case .wind:
    print("Your umbrella might fly today")
//default: //Notifies it will never be executed
//    print("Unknown weather today")
}

let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

for os in platforms {
    print("Swift works on \(os)")
}
for i in 1...12 {
    print("Today I will eat \(i) corn dogs.")
}
for i in 1..<12 {
    print("I got sick from eating \(i) corn dogs. I won't eat 12 corn dogs")
}
