//
//  Methods.swift
//  Swift Language Practice - Methods
//
//  This file contains examples demonstrating Swift instance and type methods
//  for classes, structures, and enumerations, including mutating behavior,
//  use of the implicit `self`, and type-level utilities.
//

import Foundation

// MARK: - Instance Methods

// Instance methods are functions that belong to instances of a particular class,
// structure, or enumeration. They support the functionality of those instances, either
// by providing ways to access and modify instance properties, or by providing
// functionality related to the instance's purpose.

class Counter {
    var count = 0
    
    func increment() {
        count += 1
    }
    
    func increment(by amount: Int) {
        count += amount
    }
    
    func reset() {
        count = 0
    }
}

print("=== Instance Methods ===")
let counter = Counter()
print("Initial count: \(counter.count)")
counter.increment()
print("After increment(): \(counter.count)")
counter.increment(by: 5)
print("After increment(by: 5): \(counter.count)")
counter.reset()
print("After reset(): \(counter.count)\n")

// MARK: - The `self` Property

// Every instance of a type has an implicit property called `self`, which is equivalent
// to the instance itself. Swift assumes you are referring to the current instance
// whenever you use a known property or method name within an instance method.
// Explicit `self` is only required when parameter names and property names collide.

struct Point {
    var x = 0.0, y = 0.0
    
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}

let somePoint = Point(x: 4.0, y: 5.0)
print("=== Using self to Disambiguate ===")
print("Point: (\(somePoint.x), \(somePoint.y))")
print("Is to the right of x == 1.0? \(somePoint.isToTheRightOf(x: 1.0))\n")

// MARK: - Modifying Value Types from Within Instance Methods

// Structures and enumerations are value types. By default, their properties cannot
// be modified inside instance methods. Use `mutating` to opt-in to modifying behavior.

struct MovablePoint {
    var x = 0.0, y = 0.0
    
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

print("=== Mutating Methods on Value Types ===")
var movablePoint = MovablePoint(x: 1.0, y: 1.0)
print("Start at (\(movablePoint.x), \(movablePoint.y))")
movablePoint.moveBy(x: 2.0, y: 3.0)
print("After moving by (2, 3): (\(movablePoint.x), \(movablePoint.y))\n")

// Note: You cannot call a mutating method on a constant structure instance.
let fixedPoint = MovablePoint(x: 3.0, y: 3.0)
print("Attempting to mutate a constant point results in a compile-time error:")
print("// fixedPoint.moveBy(x: 2.0, y: 3.0) // Error\n")

// MARK: - Assigning to `self` Within a Mutating Method

// Mutating methods can assign a new instance to `self`.

struct ResettablePoint {
    var x = 0.0, y = 0.0
    
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = ResettablePoint(x: x + deltaX, y: y + deltaY)
    }
}

print("=== Assigning to self in Mutating Methods ===")
var resettablePoint = ResettablePoint(x: 1.0, y: 1.0)
print("Start at (\(resettablePoint.x), \(resettablePoint.y))")
resettablePoint.moveBy(x: 2.0, y: 3.0)
print("After moving: (\(resettablePoint.x), \(resettablePoint.y))\n")

// MARK: - Mutating Methods for Enumerations

// Enumerations can also have mutating methods that set `self` to a different case.

enum TriStateSwitch {
    case off, low, high
    
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

print("=== Mutating Methods on Enumerations ===")
var ovenLight = TriStateSwitch.low
print("Initial state: \(ovenLight)")
ovenLight.next()
print("After next(): \(ovenLight)")
ovenLight.next()
print("After next() again: \(ovenLight)\n")

// MARK: - Type Methods

// Type methods are called on the type itself. Use `static` for structures and enumerations,
// and `class` for classes to allow overriding.

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    
    init(name: String) {
        playerName = name
    }
}

print("=== Type Methods and Shared State ===")
var playerOne = Player(name: "Argyrios")
playerOne.complete(level: 1)
print("Highest unlocked level: \(LevelTracker.highestUnlockedLevel)")

var playerTwo = Player(name: "Beto")
if playerTwo.tracker.advance(to: 6) {
    print("PlayerTwo advanced to level 6")
} else {
    print("Level 6 hasn't yet been unlocked")
}
print("Highest unlocked level remains: \(LevelTracker.highestUnlockedLevel)\n")

// MARK: - Type Methods on Classes

class MathHelper {
    class func square(_ value: Int) -> Int {
        return value * value
    }
    
    static func cube(_ value: Int) -> Int {
        return value * value * value
    }
}

print("=== Type Methods on Classes ===")
print("Square of 4: \(MathHelper.square(4))")
print("Cube of 3: \(MathHelper.cube(3))\n")

// MARK: - Instance and Type Methods Working Together

struct TemperatureConverter {
    static func celsiusToFahrenheit(_ celsius: Double) -> Double {
        (celsius * 9 / 5) + 32
    }
    
    var history: [Double] = []
    
    mutating func recordConversion(of celsius: Double) -> Double {
        let fahrenheit = TemperatureConverter.celsiusToFahrenheit(celsius)
        history.append(fahrenheit)
        return fahrenheit
    }
}

print("=== Instance and Type Methods Together ===")
var converter = TemperatureConverter()
let converted = converter.recordConversion(of: 25)
print("25C is \(converted)F")
print("History: \(converter.history)\n")

// MARK: - Example Function Demonstrating Methods

func demonstrateMethods() {
    print("\n=== Demonstrating Methods Summary ===\n")
    
    // Counter example
    var demoCounter = Counter()
    demoCounter.increment()
    demoCounter.increment(by: 2)
    print("Counter value: \(demoCounter.count)")
    
    // Movable point
    var demoPoint = MovablePoint(x: 0.0, y: 0.0)
    demoPoint.moveBy(x: 5.0, y: -2.0)
    print("Moved point: (\(demoPoint.x), \(demoPoint.y))")
    
    // TriStateSwitch
    var demoSwitch = TriStateSwitch.off
    demoSwitch.next()
    print("TriStateSwitch after next(): \(demoSwitch)")
    
    // MathHelper
    print("Square(7): \(MathHelper.square(7))")
    print("Cube(2): \(MathHelper.cube(2))")
    
    print("\n=== End of Methods Demonstration ===\n")
}

// Uncomment to run the demonstration
// demonstrateMethods()

