//
//  Enumerations.swift
//  Swift Language Practice - Enumerations
//
//  This file contains examples demonstrating Swift's enumeration types,
//  including associated values, raw values, and recursive enumerations.
//

import Foundation

// MARK: - Enumeration Syntax

// You introduce enumerations with the enum keyword and place their entire definition
// within a pair of braces.

// Here's an example for the four main points of a compass:

enum CompassPoint {
    case north
    case south
    case east
    case west
}

// The values defined in an enumeration (such as north, south, east, and west) are its enumeration cases.
// You use the case keyword to introduce new enumeration cases.

// Note: Swift enumeration cases don't have an integer value set by default, unlike languages like C and Objective-C.
// In the CompassPoint example above, north, south, east and west don't implicitly equal 0, 1, 2 and 3.
// Instead, the different enumeration cases are values in their own right, with an explicitly defined type of CompassPoint.

// Multiple cases can appear on a single line, separated by commas:

enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

// Each enumeration definition defines a new type. Like other types in Swift, their names
// (such as CompassPoint and Planet) start with a capital letter. Give enumeration types
// singular rather than plural names, so that they read as self-evident.

print("=== Enumeration Syntax ===")
var directionToHead = CompassPoint.west
print("Initial direction: \(directionToHead)")

// The type of directionToHead is inferred when it's initialized with one of the possible values of CompassPoint.
// Once directionToHead is declared as a CompassPoint, you can set it to a different CompassPoint value
// using a shorter dot syntax:

directionToHead = .east
print("Updated direction: \(directionToHead)")

// The type of directionToHead is already known, and so you can drop the type when setting its value.
// This makes for highly readable code when working with explicitly typed enumeration values.

// MARK: - Matching Enumeration Values with a Switch Statement

// You can match individual enumeration values with a switch statement:

directionToHead = .south
print("\n=== Matching Enumeration Values with Switch ===")
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
// Prints "Watch out for penguins".

// As described in Control Flow, a switch statement must be exhaustive when considering an enumeration's cases.
// If the case for .west is omitted, this code doesn't compile, because it doesn't consider
// the complete list of CompassPoint cases. Requiring exhaustiveness ensures that enumeration cases
// aren't accidentally omitted.

// When it isn't appropriate to provide a case for every enumeration case, you can provide
// a default case to cover any cases that aren't addressed explicitly:

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}
// Prints "Mostly harmless".

// MARK: - Iterating over Enumeration Cases

// For some enumerations, it's useful to have a collection of all of that enumeration's cases.
// You enable this by writing : CaseIterable after the enumeration's name.
// Swift exposes a collection of all the cases as an allCases property of the enumeration type.

enum Beverage: CaseIterable {
    case coffee, tea, juice
}

print("\n=== Iterating over Enumeration Cases ===")
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// Prints "3 beverages available".

// In the example above, you write Beverage.allCases to access a collection that contains all of the cases
// of the Beverage enumeration. You can use allCases like any other collection — the collection's elements
// are instances of the enumeration type, so in this case they're Beverage values.

// The example below uses a for-in loop to iterate over all the cases:

print("Available beverages:")
for beverage in Beverage.allCases {
    print("  \(beverage)")
}
// coffee
// tea
// juice

// The syntax used in the examples above marks the enumeration as conforming to the CaseIterable protocol.

// MARK: - Associated Values

// The examples in the previous section show how the cases of an enumeration are a defined (and typed) value
// in their own right. You can set a constant or variable to Planet.earth, and check for this value later.
// However, it's sometimes useful to be able to store values of other types alongside these case values.
// This additional information is called an associated value, and it varies each time you use that case
// as a value in your code.

// You can define Swift enumerations to store associated values of any given type, and the value types
// can be different for each case of the enumeration if needed. Enumerations similar to these are known
// as discriminated unions, tagged unions, or variants in other programming languages.

// For example, suppose an inventory tracking system needs to track products by two different types of barcode.
// Some products are labeled with 1D barcodes in UPC format, which uses the numbers 0 to 9.
// Each barcode has a number system digit, followed by five manufacturer code digits and five product code digits.
// These are followed by a check digit to verify that the code has been scanned correctly.

// Other products are labeled with 2D barcodes in QR code format, which can use any ISO 8859-1 character
// and can encode a string up to 2,953 characters long.

// It's convenient for an inventory tracking system to store UPC barcodes as a tuple of four integers,
// and QR code barcodes as a string of any length.

// In Swift, an enumeration to define product barcodes of either type might look like this:

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

// This can be read as:
// "Define an enumeration type called Barcode, which can take either a value of upc with an associated
// value of type (Int, Int, Int, Int), or a value of qrCode with an associated value of type String."

// This definition doesn't provide any actual Int or String values — it just defines the type of associated
// values that Barcode constants and variables can store when they're equal to Barcode.upc or Barcode.qrCode.

print("\n=== Associated Values ===")
// You can then create new barcodes using either type:

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
print("Created UPC barcode: \(productBarcode)")

// This example creates a new variable called productBarcode and assigns it a value of Barcode.upc
// with an associated tuple value of (8, 85909, 51226, 3).

// You can assign the same product a different type of barcode:

productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
print("Updated to QR code barcode: \(productBarcode)")

// At this point, the original Barcode.upc and its integer values are replaced by the new Barcode.qrCode
// and its string value. Constants and variables of type Barcode can store either a .upc or a .qrCode
// (together with their associated values), but they can store only one of them at any given time.

// You can check the different barcode types using a switch statement, similar to the example in
// Matching Enumeration Values with a Switch Statement. This time, however, the associated values
// are extracted as part of the switch statement. You extract each associated value as a constant
// (with the let prefix) or a variable (with the var prefix) for use within the switch case's body:

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."

// If all of the associated values for an enumeration case are extracted as constants, or if all are
// extracted as variables, you can place a single let or var annotation before the case name, for brevity:

switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."

// When you're matching just one case of an enumeration — for example, to extract its associated value —
// you can use an if-case statement instead of writing a full switch statement:

if case .qrCode(let productCode) = productBarcode {
    print("Found QR code: \(productCode).")
}

// Just like in the switch statement earlier, the productBarcode variable is matched against the pattern
// .qrCode(let productCode) here. And as in the switch case, writing let extracts the associated value as a constant.

// MARK: - Raw Values

// The barcode example in Associated Values shows how cases of an enumeration can declare that they store
// associated values of different types. As an alternative to associated values, enumeration cases can come
// prepopulated with default values (called raw values), which are all of the same type.

// Here's an example that stores raw ASCII values alongside named enumeration cases:

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

// Here, the raw values for an enumeration called ASCIIControlCharacter are defined to be of type Character,
// and are set to some of the more common ASCII control characters.

print("\n=== Raw Values ===")
print("Tab character: \(ASCIIControlCharacter.tab.rawValue)")
print("Line feed character: \(ASCIIControlCharacter.lineFeed.rawValue)")
print("Carriage return character: \(ASCIIControlCharacter.carriageReturn.rawValue)")

// Raw values can be strings, characters, or any of the integer or floating-point number types.
// Each raw value must be unique within its enumeration declaration.

// Although you can use both raw values and associated values to give an enumeration an additional value,
// it's important to understand the difference between them. You pick the raw value for an enumeration case
// when you define that enumeration case in your code, such as the three ASCII codes above.
// The raw value for a particular enumeration case is always the same. In contrast, you pick associated values
// when you create a new constant or variable using one of the enumeration's cases, and you can pick
// a different value each time you do so.

// MARK: - Implicitly Assigned Raw Values

// When you're working with enumerations that store integer or string raw values, you don't have to
// explicitly assign a raw value for each case. When you don't, Swift automatically assigns the values for you.

// For example, when integers are used for raw values, the implicit value for each case is one more than
// the previous case. If the first case doesn't have a value set, its value is 0.

// The enumeration below is a refinement of the earlier Planet enumeration, with integer raw values
// to represent each planet's order from the sun:

enum PlanetWithOrder: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

// In the example above, PlanetWithOrder.mercury has an explicit raw value of 1,
// PlanetWithOrder.venus has an implicit raw value of 2, and so on.

print("\n=== Implicitly Assigned Raw Values ===")
print("Mercury order: \(PlanetWithOrder.mercury.rawValue)")
print("Venus order: \(PlanetWithOrder.venus.rawValue)")
print("Earth order: \(PlanetWithOrder.earth.rawValue)")
print("Mars order: \(PlanetWithOrder.mars.rawValue)")

// When strings are used for raw values, the implicit value for each case is the text of that case's name.

// The enumeration below is a refinement of the earlier CompassPoint enumeration, with string raw values
// to represent each direction's name:

enum CompassPointWithRawValue: String {
    case north, south, east, west
}

// In the example above, CompassPointWithRawValue.south has an implicit raw value of "south", and so on.

print("\nString raw values:")
print("North: \(CompassPointWithRawValue.north.rawValue)")
print("South: \(CompassPointWithRawValue.south.rawValue)")
print("East: \(CompassPointWithRawValue.east.rawValue)")
print("West: \(CompassPointWithRawValue.west.rawValue)")

// You access the raw value of an enumeration case with its rawValue property:

let earthsOrder = PlanetWithOrder.earth.rawValue
// earthsOrder is 3
print("\nEarth's order from the sun: \(earthsOrder)")

let sunsetDirection = CompassPointWithRawValue.west.rawValue
// sunsetDirection is "west"
print("Sunset direction: \(sunsetDirection)")

// MARK: - Initializing from a Raw Value

// If you define an enumeration with a raw-value type, the enumeration automatically receives an initializer
// that takes a value of the raw value's type (as a parameter called rawValue) and returns either
// an enumeration case or nil. You can use this initializer to try to create a new instance of the enumeration.

print("\n=== Initializing from a Raw Value ===")
// This example identifies Uranus from its raw value of 7:

let possiblePlanet = PlanetWithOrder(rawValue: 7)
// possiblePlanet is of type PlanetWithOrder? and equals PlanetWithOrder.uranus
if let planet = possiblePlanet {
    print("Found planet at position 7: \(planet)")
} else {
    print("No planet found at position 7")
}

// Not all possible Int values will find a matching planet, however. Because of this,
// the raw value initializer always returns an optional enumeration case.
// In the example above, possiblePlanet is of type PlanetWithOrder?, or "optional PlanetWithOrder."

// Note: The raw value initializer is a failable initializer, because not every raw value will return
// an enumeration case.

// If you try to find a planet with a position of 11, the optional PlanetWithOrder value returned
// by the raw value initializer will be nil:

let positionToFind = 11
if let somePlanet = PlanetWithOrder(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}
// Prints "There isn't a planet at position 11".

// This example uses optional binding to try to access a planet with a raw value of 11.
// The statement if let somePlanet = PlanetWithOrder(rawValue: 11) creates an optional PlanetWithOrder,
// and sets somePlanet to the value of that optional PlanetWithOrder if it can be retrieved.
// In this case, it isn't possible to retrieve a planet with a position of 11,
// and so the else branch is executed instead.

// MARK: - Recursive Enumerations

// A recursive enumeration is an enumeration that has another instance of the enumeration as the associated
// value for one or more of the enumeration cases. You indicate that an enumeration case is recursive
// by writing indirect before it, which tells the compiler to insert the necessary layer of indirection.

// For example, here is an enumeration that stores simple arithmetic expressions:

enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

// You can also write indirect before the beginning of the enumeration to enable indirection
// for all of the enumeration's cases that have an associated value:

indirect enum ArithmeticExpression2 {
    case number(Int)
    case addition(ArithmeticExpression2, ArithmeticExpression2)
    case multiplication(ArithmeticExpression2, ArithmeticExpression2)
}

// This enumeration can store three kinds of arithmetic expressions: a plain number, the addition of two expressions,
// and the multiplication of two expressions. The addition and multiplication cases have associated values
// that are also arithmetic expressions — these associated values make it possible to nest expressions.
// For example, the expression (5 + 4) * 2 has a number on the right-hand side of the multiplication
// and another expression on the left-hand side of the multiplication. Because the data is nested,
// the enumeration used to store the data also needs to support nesting — this means the enumeration needs to be recursive.

print("\n=== Recursive Enumerations ===")
// The code below shows the ArithmeticExpression recursive enumeration being created for (5 + 4) * 2:

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

print("Created expression: (5 + 4) * 2")

// A recursive function is a straightforward way to work with data that has a recursive structure.
// For example, here's a function that evaluates an arithmetic expression:

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

let result = evaluate(product)
print("Result: \(result)")
// Prints "18".

// This function evaluates a plain number by simply returning the associated value.
// It evaluates an addition or multiplication by evaluating the expression on the left-hand side,
// evaluating the expression on the right-hand side, and then adding them or multiplying them.

// MARK: - Additional Examples

// MARK: - Enumeration with Methods

// Enumerations can have methods associated with them:

enum TrafficLight {
    case red, yellow, green
    
    func description() -> String {
        switch self {
        case .red:
            return "Stop"
        case .yellow:
            return "Caution"
        case .green:
            return "Go"
        }
    }
    
    mutating func next() {
        switch self {
        case .red:
            self = .yellow
        case .yellow:
            self = .green
        case .green:
            self = .red
        }
    }
}

print("\n=== Enumeration with Methods ===")
var light = TrafficLight.red
print("Current light: \(light), description: \(light.description())")
light.next()
print("After next: \(light), description: \(light.description())")
light.next()
print("After next: \(light), description: \(light.description())")

// MARK: - Enumeration with Computed Properties

// Enumerations can have computed properties:

enum Device {
    case iPhone(String)
    case iPad(String)
    case macBook(String)
    
    var model: String {
        switch self {
        case .iPhone(let model), .iPad(let model), .macBook(let model):
            return model
        }
    }
    
    var type: String {
        switch self {
        case .iPhone:
            return "iPhone"
        case .iPad:
            return "iPad"
        case .macBook:
            return "MacBook"
        }
    }
}

print("\n=== Enumeration with Computed Properties ===")
let myDevice = Device.iPhone("14 Pro")
print("Device type: \(myDevice.type), Model: \(myDevice.model)")

// MARK: - Enumeration with Initializers

// Enumerations can have initializers:

enum Size {
    case small, medium, large
    
    init(sizeInCm: Int) {
        switch sizeInCm {
        case 0..<50:
            self = .small
        case 50..<100:
            self = .medium
        default:
            self = .large
        }
    }
}

print("\n=== Enumeration with Initializers ===")
let shirtSize = Size(sizeInCm: 75)
print("Shirt size for 75cm: \(shirtSize)")

// MARK: - Example Function Demonstrating All Enumeration Features

func demonstrateEnumerations() {
    print("\n=== Demonstrating Swift Enumerations ===\n")
    
    // Basic enumeration
    print("1. Basic Enumeration:")
    var direction = CompassPoint.north
    print("   Direction: \(direction)")
    direction = .east
    print("   Updated direction: \(direction)")
    
    // Switch with enumeration
    print("\n2. Switch with Enumeration:")
    switch direction {
    case .north:
        print("   Going north")
    case .south:
        print("   Going south")
    case .east:
        print("   Going east")
    case .west:
        print("   Going west")
    }
    
    // CaseIterable
    print("\n3. CaseIterable:")
    print("   All beverages:")
    for beverage in Beverage.allCases {
        print("     \(beverage)")
    }
    
    // Associated values
    print("\n4. Associated Values:")
    let barcode = Barcode.upc(1, 23456, 78901, 2)
    switch barcode {
    case .upc(let a, let b, let c, let d):
        print("   UPC: \(a)-\(b)-\(c)-\(d)")
    case .qrCode(let code):
        print("   QR Code: \(code)")
    }
    
    // Raw values
    print("\n5. Raw Values:")
    print("   Earth's position: \(PlanetWithOrder.earth.rawValue)")
    print("   North direction: \(CompassPointWithRawValue.north.rawValue)")
    
    // Initializing from raw value
    print("\n6. Initializing from Raw Value:")
    if let planet = PlanetWithOrder(rawValue: 3) {
        print("   Planet at position 3: \(planet)")
    }
    
    // Recursive enumeration
    print("\n7. Recursive Enumeration:")
    let expr = ArithmeticExpression.addition(
        ArithmeticExpression.number(10),
        ArithmeticExpression.multiplication(
            ArithmeticExpression.number(2),
            ArithmeticExpression.number(3)
        )
    )
    print("   Expression: 10 + (2 * 3) = \(evaluate(expr))")
    
    print("\n=== End of Demonstration ===\n")
}

// Uncomment to run the demonstration
// demonstrateEnumerations()


