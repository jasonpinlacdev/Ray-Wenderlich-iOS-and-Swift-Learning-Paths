import UIKit

struct Wizard {
    
    static let commonMagicalIngredients = ["Polyjuice Potion", "Nimbus 2000"]
    
    var firstName: String {
        willSet {
            print("\(firstName) will be set to \(newValue).")
        }
        didSet {
            print("\(oldValue) was set to \(firstName).")
        }
    }
    var lastName: String
    
    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
        set {
            if let spaceIndex = newValue.firstIndex(of: " ") {
                firstName = String(newValue[newValue.startIndex ..< spaceIndex])
                lastName = String(newValue[spaceIndex ..< newValue.endIndex])
            }
        }
    }
}


var wizard = Wizard(firstName: "Gandalf", lastName: "The Grey")

wizard.firstName = "Hermoine"

wizard.lastName = "The White"


print(Wizard.commonMagicalIngredients)


print(wizard.fullName)

wizard.fullName = "Jason Pinlac"



// MARK: - METHODS -

enum Weekday: CaseIterable {
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday
    
    mutating func advance(by dayCount: UInt) {
        let indexOfToday = Weekday.allCases.firstIndex(of: self)!
        let indexOfAdvancedDay = indexOfToday + Int(dayCount)
        self = Weekday.allCases[indexOfAdvancedDay % Weekday.allCases.count]
    }
}


var days = Weekday.allCases
var day = Weekday.tuesday

day.advance(by: 3)


struct Time {
    var day: Weekday
    var hour: UInt = 0
    
    mutating func advanceTime(by hours: Int) {
        let days: UInt = UInt(hours / 24)
        day.advance(by: days)
        hour = UInt(hours % 24)
    }
}

var time = Time(day: .monday)

time.advanceTime(by: 36)

