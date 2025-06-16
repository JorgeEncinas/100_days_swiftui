import Cocoa

var beatles = ["John", "Paul", "Ringo", "George"]
print(beatles[0])
beatles.append("Adrian")
//beatles.append(23.0) //Not allowed
//let notAllowed = beatles[0] + 23.0 //Not allowed

var scores = Array<Int>()
scores.append(100)
scores.append(80)
print(scores[1])

var albums = Array<String>()
albums.append("Folklore")
albums.append("Fearless")
albums.append("Red")

var albums2 = [String]()
albums2.append("Folklore")

var albums3 = ["Folklore"]
print(albums.count)

var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count)

characters.remove(at: 2)
print(characters.count)
print(characters)

characters.removeAll()
print(characters.count)

print(characters.contains("Ray"))

let cities = ["London", "Tokyo", "Rome", "Budapest"]
print(cities.sorted())
print(cities)
let reversedCities = cities.reversed()
print(reversedCities)

let employee2 = [
    "name": "Taylor Swift",
    "job": "Singer",
    "location": "Nashville"
]

print(employee2["name", default: "Unknown"])
print(employee2["job", default: "Unknown"])
print(employee2["location", default: "Unknown"])

print(employee2["password", default: "Unknown"])
print(employee2["status", default: "Unknown"])
print(employee2["manager", default: "Unknown"])

let hasGraduated = [
    "Eric": false,
    "Maeve": true,
    "Otis": false,
]

let olympics = [
    2012: "London",
    2016: "Rio de Janeiro",
    2021: "Tokyo"
]

print(olympics[2012, default:"Unknown"])

var heights = [String: Int]()
heights["Yao Ming"] = 229
heights["Shaquille O'Neal"] = 216

var personDict = [String: Any]()
personDict["age"] = 27
personDict["name"] = "John Johnson"

var archEnemies = [String: String]()
archEnemies["Batman"] = "The Joker"
archEnemies["Superman"] = "Lex Luthor"

archEnemies["Batman"] = "Penguin"

// SETS
let people = Set(["Denzel Washington", "Tom Cruise", "Nicolas Cage", "Samuel L Jackson"])
print(people)
//Sets don't care about order.
//Sets automatically eliminate duplicates

var people2 = Set<String>()
people2.insert("Denzel Washington") //Note that it's not append, but insert for sets. You can infer when you're dealing with a Set thanks to this.
people2.insert("Tom Cruise")
people2.insert("Nicolas Cage")
print(people2)

print(people2.contains("Nicolas Cage")) //This is much faster for Sets than for Arrays.
print(people2.count)
print(people2.sorted())

//Enums
var selected = "Monday"

enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}

var day = Weekday.monday

enum Weekday2 {
    case monday, tuesday, wednesday, thursday, friday
}

day = Weekday.tuesday
day = .wednesday //Since it's already decided that day is of type Weekday, it knows that .wednesday must refer to another enum value.

//Swift stores enums in an optimized form. monday -> 0. So it's more efficient than storing and checking all letters M o n d a y

// TYPE ANNOTATIONS
let surname: String = "Lasso"
let score: Int = 0
let doubleScore: Double = 0
var isAuthenticated: Bool = false
var albumsAgain : [String] = ["Red", "Fearless"]

var user: [String: String] = ["id": "@twostraws"]
var books: Set<String> = Set(["The Bluest Eye", "Foundation", "Girl, Woman, Other"])
var teams : [String] = [String]()
var cities2: [String] = []
var clues: [String] = Array<String>()
var clues2 = [String]()

//Values of an enum have the same type as the enum itself.
let username: String //Swift must ALWAYS know what data types your constants and variables contain.
