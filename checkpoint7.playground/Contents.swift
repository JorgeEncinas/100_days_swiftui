import Cocoa

class Animal {
    var legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog : Animal {
    
    func speak() -> Void {
        print("bark!")
    }
    
    override init(legs : Int) { // This initializer could have been inherited. I wrote it out to get some practice going!
        super.init(legs: legs) // Notice that I had to use "override" because it matches the signature of the super class's initializer
    }

}

class Cat : Animal {
    var isTame: Bool
    
    func speak() -> Void {
        print("meow!")
    }
    
    init(legs: Int, isTame : Bool) {
        self.isTame = isTame
        super.init(legs: legs)
    }
}


class Corgi : Dog {
    override func speak() -> Void {
        print("Corgi bark Corgi bark!")
    }
}

class Poodle : Dog {
    override func speak() -> Void {
        print("Poork Poork!")
    }
}

class Persian : Cat {
    override func speak() -> Void {
        print("worship me I am a superior animal")
    }
}

class Lion : Cat {
    override func speak() -> Void {
        print("Roar I am Simba the King of the Jungle")
    }
}

var lion = Lion(legs: 4, isTame: false)
lion.speak()
var persian = Persian(legs: 4, isTame: true)
persian.speak()
var poodle = Poodle(legs: 4)
poodle.speak()
var corgi = Corgi(legs: 4)
corgi.speak()
var dog = Dog(legs: 4)
dog.speak()
var cat = Cat(legs: 4, isTame: true)
cat.speak()
