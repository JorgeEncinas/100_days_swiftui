import Cocoa

protocol Building {
    var numberOfRooms : Int { get set }
    var cost : Int { get set }
    var sellingAgent : String { get } //Somebody else could re-sell it, so perhaps this doesn't make sense. For the sake of demonstration, I'll keep it.
    
    func printSalesSummary() -> Void
}

extension Building {
    func printSalesSummary() {
        print("This building has \(numberOfRooms) rooms, a cost of $\(cost), please contact \(sellingAgent)")
    }
}

struct House : Building {
    var numberOfRooms : Int
    var cost : Int
    let sellingAgent : String
    
    func printSalesSummary() {
        print("A Home with \(numberOfRooms) rooms, for a price of $\(cost), please contact \(sellingAgent) ")
    }
}

struct Office : Building {
    var numberOfRooms: Int
    var cost : Int
    let sellingAgent : String
    
    func printSalesSummary() {
        print("An Office Building with \(numberOfRooms) office spaces, for a price of $\(cost), please contact \(sellingAgent)")
    }
}
