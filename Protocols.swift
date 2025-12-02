//
//  Protocols.swift
//  Swift Language Practice - Protocols
//
//  This file contains examples demonstrating Swift protocols, including
//  property requirements, method requirements, protocol inheritance, and extensions.
//

import Foundation

// MARK: - Introduction to Protocols

// A protocol defines a blueprint of methods, properties, and other requirements that suit a
// particular task or piece of functionality. The protocol can then be adopted by a class, structure,
// or enumeration to provide an actual implementation of those requirements. Any type that satisfies
// the requirements of a protocol is said to conform to that protocol.

// In addition to specifying requirements that conforming types must implement, you can extend a
// protocol to implement some of these requirements or to implement additional functionality that
// conforming types can take advantage of.

// MARK: - Protocol Syntax

// You define protocols in a very similar way to classes, structures, and enumerations:

// protocol SomeProtocol {
//     // protocol definition goes here
// }

// Custom types state that they adopt a particular protocol by placing the protocol's name after
// the type's name, separated by a colon, as part of their definition. Multiple protocols can be
// listed, and are separated by commas:

// struct SomeStructure: FirstProtocol, AnotherProtocol {
//     // structure definition goes here
// }

// If a class has a superclass, list the superclass name before any protocols it adopts, followed
// by a comma:

// class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
//     // class definition goes here
// }

// Note: Because protocols are types, begin their names with a capital letter (such as FullyNamed
// and RandomNumberGenerator) to match the names of other types in Swift (such as Int, String,
// and Double).

// MARK: - Property Requirements

// A protocol can require any conforming type to provide an instance property or type property with
// a particular name and type. The protocol doesn't specify whether the property should be a stored
// property or a computed property — it only specifies the required property name and type. The
// protocol also specifies whether each property must be gettable or gettable and settable.

// If a protocol requires a property to be gettable and settable, that property requirement can't
// be fulfilled by a constant stored property or a read-only computed property. If the protocol
// only requires a property to be gettable, the requirement can be satisfied by any kind of
// property, and it's valid for the property to be also settable if this is useful for your own
// code.

// Property requirements are always declared as variable properties, prefixed with the var keyword.
// Gettable and settable properties are indicated by writing { get set } after their type declaration,
// and gettable properties are indicated by writing { get }.

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

// Always prefix type property requirements with the static keyword when you define them in a protocol.
// This rule pertains even though type property requirements can be prefixed with the class or static
// keyword when implemented by a class

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

// Here's an example of a protocol with a single instance property requirement

protocol FullyNamed {
    var fullName: String { get }
}

// The FullyNamed protocol requires a conforming type to provide a fully qualified name. The protocol
// doesn't specify anything else about the nature of the conforming type — it only specifies that
// the type must be able to provide a full name for itself. The protocol states that any FullyNamed
// type must have a gettable instance property called fullName, which is of type String.

// Here's an example of a simple structure that adopts and conforms to the FullyNamed protocol

struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John Appleseed")
// john.fullName is "John Appleseed"

// This example defines a structure called Person, which represents a specific named person. It
// states that it adopts the FullyNamed protocol as part of the first line of its definition.

// Each instance of Person has a single stored property called fullName, which is of type String.
// This matches the single requirement of the FullyNamed protocol, and means that Person has correctly
// conformed to the protocol. (Swift reports an error at compile time if a protocol requirement
// isn't fulfilled.)

// Here's a more complex class, which also adopts and conforms to the FullyNamed protocol

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
// ncc1701.fullName is "USS Enterprise"

// This class implements the fullName property requirement as a computed read-only property for a
// starship. Each Starship class instance stores a mandatory name and an optional prefix. The
// fullName property uses the prefix value if it exists, and prepends it to the beginning of name
// to create a full name for the starship.

// MARK: - Method Requirements

// Protocols can require specific instance methods and type methods to be implemented by conforming
// types. These methods are written as part of the protocol's definition in exactly the same way as
// for normal instance and type methods, but without curly braces or a method body. Variadic parameters
// are allowed, subject to the same rules as for normal methods. Default values, however, can't be
// specified for method parameters within a protocol's definition.

// As with type property requirements, you always prefix type method requirements with the static
// keyword when they're defined in a protocol. This is true even though type method requirements are
// prefixed with the class or static keyword when implemented by a class

protocol SomeProtocolWithMethods {
    static func someTypeMethod()
}

// The following example defines a protocol with a single instance method requirement

protocol RandomNumberGenerator {
    func random() -> Double
}

// This protocol, RandomNumberGenerator, requires any conforming type to have an instance method
// called random, which returns a Double value whenever it's called. Although it's not specified
// as part of the protocol, it's assumed that this value will be a number from 0.0 up to (but not
// including) 1.0.

// The RandomNumberGenerator protocol doesn't make any assumptions about how each random number will
// be generated — it simply requires the generator to provide a standard way to generate a new
// random number.

// Here's an implementation of a class that adopts and conforms to the RandomNumberGenerator protocol.
// This class implements a pseudorandom number generator algorithm known as a linear congruential
// generator

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy: m))
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// Prints "Here's a random number: 0.3746499199817101"
print("And another one: \(generator.random())")
// Prints "And another one: 0.729023776863283"

// MARK: - Mutating Method Requirements

// It's sometimes necessary for a method to modify (or mutate) the instance it belongs to. For
// instance methods on value types (that is, structures and enumerations) you place the mutating
// keyword before a method's func keyword to indicate that the method is allowed to modify the
// instance it belongs to and any properties of that instance.

// If you define a protocol instance method requirement that's intended to mutate instances of any
// type that adopts the protocol, mark the method with the mutating keyword as part of the protocol's
// definition. This enables structures and enumerations to adopt the protocol and satisfy that method
// requirement.

// Note: If you mark a protocol instance method requirement as mutating, you don't need to write
// the mutating keyword when writing an implementation of that method for a class. The mutating
// keyword is only used by structures and enumerations.

// The example below defines a protocol called Togglable, which defines a single instance method
// requirement called toggle. As its name suggests, the toggle() method is intended to toggle or
// invert the state of any conforming type, typically by modifying a property of that type.

// The toggle() method is marked with the mutating keyword as part of the Togglable protocol
// definition, to indicate that the method is expected to mutate the state of a conforming instance
// when it's called

protocol Togglable {
    mutating func toggle()
}

// If you implement the Togglable protocol for a structure or enumeration, that structure or
// enumeration can conform to the protocol by providing an implementation of the toggle() method
// that's also marked as mutating.

// The example below defines an enumeration called OnOffSwitch. This enumeration toggles between two
// states, indicated by the enumeration cases on and off. The enumeration's toggle implementation
// is marked as mutating, to match the Togglable protocol's requirements

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
// lightSwitch is now equal to .on

// MARK: - Initializer Requirements

// Protocols can require specific initializers to be implemented by conforming types. You write
// these initializers as part of the protocol's definition in exactly the same way as for normal
// initializers, but without curly braces or an initializer body

protocol SomeProtocolWithInit {
    init(someParameter: Int)
}

// MARK: - Class Implementations of Protocol Initializer Requirements

// You can implement a protocol initializer requirement on a conforming class as either a designated
// initializer or a convenience initializer. In both cases, you must mark the initializer
// implementation with the required modifier

class SomeClass: SomeProtocolWithInit {
    required init(someParameter: Int) {
        // initializer implementation goes here
    }
}

// The use of the required modifier ensures that you provide an explicit or inherited implementation
// of the initializer requirement on all subclasses of the conforming class, such that they also
// conform to the protocol.

// Note: You don't need to mark protocol initializer implementations with the required modifier on
// classes that are marked with the final modifier, because final classes can't be subclassed.

// If a subclass overrides a designated initializer from a superclass, and also implements a matching
// initializer requirement from a protocol, mark the initializer implementation with both the required
// and override modifiers

protocol SomeProtocol {
    init()
}

class SomeSuperClass {
    init() {
        // initializer implementation goes here
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}

// MARK: - Protocols as Types

// Protocols don't actually implement any functionality themselves. Regardless, you can use a
// protocol as a type in your code.

// The most common way to use a protocol as a type is to use a protocol as a generic constraint.
// Code with generic constraints can work with any type that conforms to the protocol, and the
// specific type is chosen by the code that uses the API.

// MARK: - Delegation

// Delegation is a design pattern that enables a class or structure to hand off (or delegate) some
// of its responsibilities to an instance of another type. This design pattern is implemented by
// defining a protocol that encapsulates the delegated responsibilities, such that a conforming type
// (known as a delegate) is guaranteed to provide the functionality that has been delegated.

// The example below defines a dice game and a nested protocol for a delegate that tracks the game's
// progress

class DiceGame {
    let sides: Int
    let generator = LinearCongruentialGenerator()
    weak var delegate: Delegate?
    
    init(sides: Int) {
        self.sides = sides
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
    
    func play(rounds: Int) {
        delegate?.gameDidStart(self)
        for round in 1...rounds {
            let player1 = roll()
            let player2 = roll()
            if player1 == player2 {
                delegate?.game(self, didEndRound: round, winner: nil)
            } else if player1 > player2 {
                delegate?.game(self, didEndRound: round, winner: 1)
            } else {
                delegate?.game(self, didEndRound: round, winner: 2)
            }
        }
        delegate?.gameDidEnd(self)
    }
    
    protocol Delegate: AnyObject {
        func gameDidStart(_ game: DiceGame)
        func game(_ game: DiceGame, didEndRound round: Int, winner: Int?)
        func gameDidEnd(_ game: DiceGame)
    }
}

// The DiceGame class implements a game where each player takes a turn rolling dice, and the player
// who rolls the highest number wins the round. It uses a linear congruential generator from the
// example earlier in the chapter, to generate random numbers for dice rolls.

// The DiceGame.Delegate protocol can be adopted to track the progress of a dice game. Because the
// DiceGame.Delegate protocol is always used in the context of a dice game, it's nested inside of
// the DiceGame class. Protocols can be nested inside of type declarations like structures and
// classes, as long as the outer declaration isn't generic.

// To prevent strong reference cycles, delegates are declared as weak references. Marking the
// protocol as class-only lets the DiceGame class declare that its delegate must use a weak reference.
// A class-only protocol is marked by its inheritance from AnyObject.

// This next example shows a class called DiceGameTracker, which adopts the DiceGame.Delegate protocol

class DiceGameTracker: DiceGame.Delegate {
    var playerScore1 = 0
    var playerScore2 = 0
    
    func gameDidStart(_ game: DiceGame) {
        print("Started a new game")
        playerScore1 = 0
        playerScore2 = 0
    }
    
    func game(_ game: DiceGame, didEndRound round: Int, winner: Int?) {
        switch winner {
        case 1:
            playerScore1 += 1
            print("Player 1 won round \(round)")
        case 2:
            playerScore2 += 1
            print("Player 2 won round \(round)")
        default:
            print("The round was a draw")
        }
    }
    
    func gameDidEnd(_ game: DiceGame) {
        if playerScore1 == playerScore2 {
            print("The game ended in a draw.")
        } else if playerScore1 > playerScore2 {
            print("Player 1 won!")
        } else {
            print("Player 2 won!")
        }
    }
}

// Here's how DiceGame and DiceGameTracker look in action:

let tracker = DiceGameTracker()
let game = DiceGame(sides: 6)
game.delegate = tracker
game.play(rounds: 3)
// Started a new game
// Player 2 won round 1
// Player 2 won round 2
// Player 1 won round 3
// Player 2 won!

// MARK: - Adding Protocol Conformance with an Extension

// You can extend an existing type to adopt and conform to a new protocol, even if you don't have
// access to the source code for the existing type. Extensions can add new properties, methods,
// and subscripts to an existing type, and are therefore able to add any requirements that a
// protocol may demand.

// Note: Existing instances of a type automatically adopt and conform to a protocol when that
// conformance is added to the instance's type in an extension.

// For example, this protocol, called TextRepresentable, can be implemented by any type that has
// a way to be represented as text. This might be a description of itself, or a text version of its
// current state

protocol TextRepresentable {
    var textualDescription: String { get }
}

// A simple Dice class for demonstration
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
}

// The Dice class can be extended to adopt and conform to TextRepresentable

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

// Any Dice instance can now be treated as TextRepresentable

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)
// Prints "A 12-sided dice"

// MARK: - Conditionally Conforming to a Protocol

// A generic type may be able to satisfy the requirements of a protocol only under certain conditions,
// such as when the type's generic parameter conforms to the protocol. You can make a generic type
// conditionally conform to a protocol by listing constraints when extending the type.

// The following extension makes Array instances conform to the TextRepresentable protocol whenever
// they store elements of a type that conforms to TextRepresentable

extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

let d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
let myDice = [d6, d12]
print(myDice.textualDescription)
// Prints "[A 6-sided dice, A 12-sided dice]"

// MARK: - Declaring Protocol Adoption with an Extension

// If a type already conforms to all of the requirements of a protocol, but hasn't yet stated that
// it adopts that protocol, you can make it adopt the protocol with an empty extension

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable {}

// Instances of Hamster can now be used wherever TextRepresentable is the required type

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)
// Prints "A hamster named Simon"

// Note: Types don't automatically adopt a protocol just by satisfying its requirements. They must
// always explicitly declare their adoption of the protocol.

// MARK: - Adopting a Protocol Using a Synthesized Implementation

// Swift can automatically provide the protocol conformance for Equatable, Hashable, and Comparable
// in many simple cases. Using this synthesized implementation means you don't have to write
// repetitive boilerplate code to implement the protocol requirements yourself.

// Swift provides a synthesized implementation of Equatable for the following kinds of custom types:
// - Structures that have only stored properties that conform to the Equatable protocol
// - Enumerations that have only associated types that conform to the Equatable protocol
// - Enumerations that have no associated types

struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
}

let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if twoThreeFour == anotherTwoThreeFour {
    print("These two vectors are also equivalent.")
}
// Prints "These two vectors are also equivalent."

// Swift provides a synthesized implementation of Hashable for similar types, and Comparable for
// enumerations that don't have a raw value

enum SkillLevel: Comparable {
    case beginner
    case intermediate
    case expert(stars: Int)
}

var levels = [SkillLevel.intermediate, SkillLevel.beginner,
              SkillLevel.expert(stars: 5), SkillLevel.expert(stars: 3)]
for level in levels.sorted() {
    print(level)
}
// Prints "beginner"
// Prints "intermediate"
// Prints "expert(stars: 3)"
// Prints "expert(stars: 5)"

// MARK: - Protocol Inheritance

// A protocol can inherit one or more other protocols and can add further requirements on top of
// the requirements it inherits. The syntax for protocol inheritance is similar to the syntax for
// class inheritance, but with the option to list multiple inherited protocols, separated by commas

protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // protocol definition goes here
}

// Here's an example of a protocol that inherits the TextRepresentable protocol from above

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

// This example defines a new protocol, PrettyTextRepresentable, which inherits from TextRepresentable.
// Anything that adopts PrettyTextRepresentable must satisfy all of the requirements enforced by
// TextRepresentable, plus the additional requirements enforced by PrettyTextRepresentable.

// MARK: - Class-Only Protocols

// You can limit protocol adoption to class types (and not structures or enumerations) by adding
// the AnyObject protocol to a protocol's inheritance list

protocol SomeClassOnlyProtocol: AnyObject, SomeProtocol {
    // class-only protocol definition goes here
}

// In the example above, SomeClassOnlyProtocol can only be adopted by class types. It's a compile-time
// error to write a structure or enumeration definition that tries to adopt SomeClassOnlyProtocol.

// Note: Use a class-only protocol when the behavior defined by that protocol's requirements assumes
// or requires that a conforming type has reference semantics rather than value semantics.

// MARK: - Protocol Composition

// It can be useful to require a type to conform to multiple protocols at the same time. You can
// combine multiple protocols into a single requirement with a protocol composition. Protocol
// compositions behave as if you defined a temporary local protocol that has the combined requirements
// of all protocols in the composition. Protocol compositions don't define any new protocol types.

// Protocol compositions have the form SomeProtocol & AnotherProtocol. You can list as many protocols
// as you need, separating them with ampersands (&). In addition to its list of protocols, a protocol
// composition can also contain one class type, which you can use to specify a required superclass.

// Here's an example that combines two protocols called Named and Aged into a single protocol
// composition requirement on a function parameter

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct PersonWithAge: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

let birthdayPerson = PersonWithAge(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)
// Prints "Happy birthday, Malcolm, you're 21!"

// MARK: - Checking for Protocol Conformance

// You can use the is and as operators described in Type Casting to check for protocol conformance,
// and to cast to a specific protocol. Checking for and casting to a protocol follows exactly the
// same syntax as checking for and casting to a type.

// This example defines a protocol called HasArea, with a single property requirement of a gettable
// Double property called area

protocol HasArea {
    var area: Double { get }
}

// Here are two classes, Circle and Country, both of which conform to the HasArea protocol

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}

class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

// Here's a class called Animal, which doesn't conform to the HasArea protocol

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

// The Circle, Country and Animal classes don't have a shared base class. Nonetheless, they're all
// classes, and so instances of all three types can be used to initialize an array that stores values
// of type AnyObject

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

// The objects array can now be iterated, and each object in the array can be checked to see if it
// conforms to the HasArea protocol

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}
// Area is 12.5663708
// Area is 243610.0
// Something that doesn't have an area

// MARK: - Optional Protocol Requirements

// You can define optional requirements for protocols. These requirements don't have to be implemented
// by types that conform to the protocol. Optional requirements are prefixed by the optional modifier
// as part of the protocol's definition. Optional requirements are available so that you can write
// code that interoperates with Objective-C. Both the protocol and the optional requirement must be
// marked with the @objc attribute. Note that @objc protocols can be adopted only by classes, not
// by structures or enumerations.

// When you use a method or property in an optional requirement, its type automatically becomes an
// optional. For example, a method of type (Int) -> String becomes ((Int) -> String)?.

// The following example defines an integer-counting class called Counter, which uses an external
// data source to provide its increment amount. This data source is defined by the CounterDataSource
// protocol, which has two optional requirements

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

// The Counter class, defined below, has an optional dataSource property of type CounterDataSource?

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

// Here's a simple CounterDataSource implementation where the data source returns a constant value
// of 3 every time it's queried

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

// You can use an instance of ThreeSource as the data source for a new Counter instance

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}
// 3
// 6
// 9
// 12

// MARK: - Protocol Extensions

// Protocols can be extended to provide method, initializer, subscript, and computed property
// implementations to conforming types. This allows you to define behavior on protocols themselves,
// rather than in each type's individual conformance or in a global function.

// For example, the RandomNumberGenerator protocol can be extended to provide a randomBool() method,
// which uses the result of the required random() method to return a random Bool value

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

// By creating an extension on the protocol, all conforming types automatically gain this method
// implementation without any additional modification

let generator2 = LinearCongruentialGenerator()
print("Here's a random number: \(generator2.random())")
print("And here's a random Boolean: \(generator2.randomBool())")

// Protocol extensions can add implementations to conforming types but can't make a protocol extend
// or inherit from another protocol. Protocol inheritance is always specified in the protocol
// declaration itself.

// MARK: - Providing Default Implementations

// You can use protocol extensions to provide a default implementation to any method or computed
// property requirement of that protocol. If a conforming type provides its own implementation
// of a required method or property, that implementation will be used instead of the one provided
// by the extension.

// Note: Protocol requirements with default implementations provided by extensions are distinct from
// optional protocol requirements. Although conforming types don't have to provide their own
// implementation of either, requirements with default implementations can be called without
// optional chaining.

// For example, the PrettyTextRepresentable protocol can provide a default implementation of its
// required prettyTextualDescription property

extension PrettyTextRepresentable {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

// MARK: - Adding Constraints to Protocol Extensions

// When you define a protocol extension, you can specify constraints that conforming types must
// satisfy before the methods and properties of the extension are available. You write these
// constraints after the name of the protocol you're extending by writing a generic where clause.

// For example, you can define an extension to the Collection protocol that applies to any collection
// whose elements conform to the Equatable protocol

extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}

// The allEqual() method returns true only if all the elements in the collection are equal

let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]

// Because arrays conform to Collection and integers conform to Equatable, equalNumbers and
// differentNumbers can use the allEqual() method

print(equalNumbers.allEqual())
// Prints "true"
print(differentNumbers.allEqual())
// Prints "false"

// MARK: - Collections of Protocol Types

// A protocol can be used as the type to be stored in a collection such as an array or a dictionary,
// as mentioned in Protocols as Types. This example creates an array of TextRepresentable things

let things: [TextRepresentable] = [d12, simonTheHamster]

// It's now possible to iterate over the items in the array, and print each item's textual description

for thing in things {
    print(thing.textualDescription)
}
// A 12-sided dice
// A hamster named Simon

// MARK: - Example Function Demonstrating All Protocol Concepts

func demonstrateProtocols() {
    print("\n=== Demonstrating Swift Protocols ===\n")
    
    // Property requirements
    print("1. Property Requirements:")
    let person = Person(fullName: "Alice Smith")
    print("   Person: \(person.fullName)")
    
    let starship = Starship(name: "Enterprise", prefix: "USS")
    print("   Starship: \(starship.fullName)")
    
    // Method requirements
    print("\n2. Method Requirements:")
    let rng = LinearCongruentialGenerator()
    print("   Random number: \(rng.random())")
    print("   Random bool: \(rng.randomBool())")
    
    // Mutating methods
    print("\n3. Mutating Method Requirements:")
    var switchState = OnOffSwitch.off
    print("   Initial state: \(switchState)")
    switchState.toggle()
    print("   After toggle: \(switchState)")
    
    // Protocol conformance via extension
    print("\n4. Protocol Conformance via Extension:")
    let dice = Dice(sides: 20, generator: rng)
    print("   \(dice.textualDescription)")
    
    // Protocol inheritance
    print("\n5. Protocol Composition:")
    let personWithAge = PersonWithAge(name: "Bob", age: 30)
    wishHappyBirthday(to: personWithAge)
    
    // Protocol conformance checking
    print("\n6. Protocol Conformance Checking:")
    for object in objects {
        if let objectWithArea = object as? HasArea {
            print("   Area: \(objectWithArea.area)")
        } else {
            print("   No area")
        }
    }
    
    // Optional protocol requirements
    print("\n7. Optional Protocol Requirements:")
    let counter = Counter()
    counter.dataSource = ThreeSource()
    counter.increment()
    print("   Counter count: \(counter.count)")
    
    // Collections of protocol types
    print("\n8. Collections of Protocol Types:")
    for thing in things {
        print("   \(thing.textualDescription)")
    }
    
    // Synthesized implementations
    print("\n9. Synthesized Implementations:")
    let vec1 = Vector3D(x: 1.0, y: 2.0, z: 3.0)
    let vec2 = Vector3D(x: 1.0, y: 2.0, z: 3.0)
    print("   Vectors equal: \(vec1 == vec2)")
    
    let sortedLevels = levels.sorted()
    print("   Sorted skill levels: \(sortedLevels)")
    
    // Constrained protocol extensions
    print("\n10. Constrained Protocol Extensions:")
    print("   All equal: \(equalNumbers.allEqual())")
    print("   All different: \(differentNumbers.allEqual())")
    
    print("\n=== End of Demonstration ===\n")
}

// Uncomment to run the demonstration
// demonstrateProtocols()


