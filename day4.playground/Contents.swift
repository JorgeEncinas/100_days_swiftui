import Cocoa

// Make an array of 3 numbers
var numbers = [1, 2, 3]

// Add a 4th
numbers.append(4)

// If we have over 3 items
if numbers.count > 3 {
    // Remove the oldest number
    numbers.remove(at: 0)
}

// Display the result
print(numbers)

var name = "John"
if (name != "Anonymous") {
    print("Welcome, \(name)!")
}
name = ""
if (name == "") {
    name = "Anonymous"
}
print(name)
name = ""
if(name.count < 1) {
    name = "Anonymous again"
}
print(name)
name = ""
if(name.isEmpty) {
    name = "Anonymous again again"
}
print(name)

let age = 17
if (age >= 18) {
    print("You can vote")
} else if ( age > 16 ) {
    print("You can't vote just yet friend")
} else {
    print("Welcome to the Weenie Hut!")
}

if (age < 19 && age > 15) {
    print("You are probably in high school.")
}

var sex = "Male"
if (sex == "Male" || sex == "Female") {
    print("You put in one of the two sexes. Genders are many, however.")
}

enum TransportOption {
    case airplane, helicopter, bicycle, car, scooter, train
}

let transport = TransportOption.airplane

if transport == .airplane || transport == .helicopter {
    print("Let's fly")
} else if transport == .bicycle {
    print("Environmental fella, huh.")
} else {
    print("Why are you not flying, sicko.")
}

enum Weather {
    case sun, rain, wind, snow, unknown
}

let forecast : Weather = Weather.sun

if forecast == .sun {
    print("It's a beautiful day outside...")
} else if forecast == .rain {
    print("My favorite type of day, a rainy day")
} else {
    print("It's so over bros.")
}

switch (forecast) { //Switch is checked in order, so if you put default first, no other cases will run.
case .sun:
    print("Beautiful day outside!")
case .rain:
    print("My favorite type of day")
default:
    print("I don't know, that's scary")
}

let day = 5
print("My true love gave to me…")

switch day {
case 5:
    print("5 golden rings")
    fallthrough //Fallthrough lets you run the next case as well, but then the next case needs to specify it too.
case 4:
    print("4 calling birds")
    fallthrough
case 3:
    print("3 French hens")
    fallthrough
case 2:
    print("2 turtle doves")
    fallthrough
default:
    print("A partridge in a pear tree")
}

// Ternary operator
let canVote = age >= 18 ? "Yes" : "No"
let hour = 23
print(hour < 12 ? "It's before Noon" : "It's after noon")

let names = ["Jayne", "Kaylee", "Mal"]
let crewCount = names.isEmpty ? "No one" : "\(names.count) people"
print(crewCount)

// For loops
let platforms = ["iOS", "macOS", "tvOS", "watchOS"]
for os in platforms {
    print("Swift works great on \(os)")
}

for i in 1...12 {
    print("5 * \(i) is \(5 * i)")
    for j in 1...12 {
        print("\(j) * \(i) is \(i * j)")
    }
    
    print()
}

for i in 1..<5 { //Useful in arrays, where you index by 0 and know it has X items. just do 0..<X
    print("Counting 1 up to 5: \(i)")
}

var lyric = "Haters gonna"

for _ in 1...5 { //For when you'll discard the iterator variable.
    lyric += " hate"
}

print(lyric)

var countdown  = 10

while countdown > 0 {
    print("\(countdown)...")
    countdown -= 1
}
print("Blast off!")

let id = Int.random(in: 1...1000)
print(id)

let amount = Double.random(in: 0...1)
print(amount)

var roll = 0

while roll != 20 {
    roll = Int.random(in: 1...20)
    print("I rolled a \(roll)")
}

print("Critical hit!")

let filenames = ["me.jpg", "work.txt", "sophie.jpg", "logo.psd"]
for filename in filenames {
    if filename.hasSuffix(".jpg") == false {
        continue
    }
    
    print("Found picture: \(filename)")
}

let number1 = 4
let number2 = 14
var multiples = [Int]()

for i in 1...100_000 {
    if i.isMultiple(of: number1) && i.isMultiple(of: number2) {
        multiples.append(i)
        
        if (multiples.count == 10) {
            break
        }
    }
}
print(multiples)


