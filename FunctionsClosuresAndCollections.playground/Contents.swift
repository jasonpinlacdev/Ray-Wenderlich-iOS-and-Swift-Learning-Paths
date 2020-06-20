


// MARK: - FUNCTIONS, CLOSURES, AND COLLECTIONS -

// this use of type alias below is to show that functions and closures are indeed types. Here is a type below of (String, String) -> String
typealias strClosureType = (String, String) -> String

// Closures are the same as functions. As you can see the syntax is very similar. Closures are first type functions meaning that can be passed or stored into variables. Closures like functions are higher order functions meaning you closures can take other closures as arguments.
var calculateFullNameClosure: (String, String?) -> String = { (first: String, last: String?) -> String in
    return first + " " + (last ?? "Doe")
}

// When invoking a closure you do not use argument labels.
calculateFullNameClosure("Jason", nil)


// Below is an example of a higher order function which takes a closure as an argument
func printResult(_ a: Double, _ b: Double, _ operate: (Double, Double) -> Double) {
    print(operate(a,b))
}


// closures and functions are FIRST TYPE. This means you can pass/store them into variables
var multiplyClosure = { (a: Double, b: Double) -> Double in
    return a * b
}


// closures and functions are HIGHER ORDER meaning they can take other closures/functions as parameter & arguements
printResult(6, 9, multiplyClosure)



// Inline closure
printResult(10.0, 7.0) { (a: Double, b: Double) -> Double in
    return a + b
}




// closures can be shortened
var longClosure: (Int, Int) -> Int = { (a: Int, b: Int) -> Int  in
    return a + b
}
var longClosureResult = longClosure(5 , 5)

// no signature needed
var shortClosure: (Int, Int) -> Int = { (a, b) in
    return a + b
}
var shortClosureResult = shortClosure(7,7)

// no return needed
var evenShorterClosure: (Int, Int) -> Int = { (a, b) in
    a + b
}
evenShorterClosure(1,1)

// no param names needed
var minimalClosure: (Int, Int) -> Int = {
    $0 + $1
    
}


// Void closure
var voidClosure: () -> Void = {
    print("Yay, Swift!")
}



var voidClosureTwo: () -> () = {
    print("Yay, Swift! Yay, Swift!")
}


voidClosure()
voidClosureTwo()

// Trailing closure syntax using the minimal closure syntax
printResult(9.9, 0.3) {
    $0 * $1
}


// MARK: - Useful collection methods that take advantage of closure syntax -s

// MARK: .forEach - takes a closure and iterates on each element of the collection doing some sort of work that you specify in the closure. returns () or Void

var names = ["Jason", "Michael", "David",]

for name in names {
    print(name)
}

// as you can see the for-in loop above acts exactly the same way as the .forEach collection method
names.forEach { name in
    print(name)
}



// MARK: .map - returns a transformed collection after executing the code you provide within the closure argument
var prices = [1.99, 9.99, 4.99, 0.35]

// 10% off sale

var salePrices = prices.map { price in
    return price - (price * 0.10)
}

print(salePrices)


// MARK: .compactMap - like map howver it will only append non nil values in the final collection returned
var numbers = ["1", "2", "3" ,"four", "five"]

var validNumbers = numbers.compactMap { number in
    return Int(number)
}
validNumbers


// MARK: .flapMap -  takes an array inputs that contains arrays and returns within your closure a single flattened array ready to be transformed within the closure.

var brothers = [ ["Jason", "Michael"], ["Javid"] ]

// simple flatten example
var brosInASingleArray = brothers.flatMap { brothersFlattened in
    return brothersFlattened
}

// more complex flatten with condition
var brothersThatStartWithJ = brothers.flatMap { brothersFlattened -> [String] in
    var brothersThatStartWithJ = [String]()
    for brother in brothersFlattened where brother.first == "J" {
        brothersThatStartWithJ.append(brother)
    }
    return brothersThatStartWithJ
}

brothersThatStartWithJ


var brothersThatStartWithM = brothers.flatMap { brothersFlattened in
    brothersFlattened.filter { brother in
        brother.first == "M"
    }
}

brothersThatStartWithM
