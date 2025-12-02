//
//  Extensions.swift
//  Swift Language Practice - Extensions
//
//  This file contains examples demonstrating Swift extensions, including
//  adding computed properties, methods, initializers, subscripts, and nested types.
//

import Foundation

// MARK: - Introduction to Extensions

// Extensions add new functionality to an existing class, structure, enumeration, or protocol type.
// This includes the ability to extend types for which you don't have access to the original source
// code (known as retroactive modeling). Extensions are similar to categories in Objective-C.
// (Unlike Objective-C categories, Swift extensions don't have names.)

// Extensions in Swift can:
// - Add computed instance properties and computed type properties
// - Define instance methods and type methods
// - Provide new initializers
// - Define subscripts
// - Define and use new nested types
// - Make an existing type conform to a protocol

// In Swift, you can even extend a protocol to provide implementations of its requirements or add
// additional functionality that conforming types can take advantage of. For more details, see
// Protocol Extensions.

// Note: Extensions can add new functionality to a type, but they can't override existing
// functionality.

// MARK: - Extension Syntax

// Declare extensions with the extension keyword:

// extension SomeType {
//     // new functionality to add to SomeType goes here
// }

// An extension can extend an existing type to make it adopt one or more protocols. To add protocol
// conformance, you write the protocol names the same way as you write them for a class or structure:

// extension SomeType: SomeProtocol, AnotherProtocol {
//     // implementation of protocol requirements goes here
// }

// Adding protocol conformance in this way is described in Adding Protocol Conformance with an
// Extension.

// An extension can be used to extend an existing generic type, as described in Extending a Generic
// Type. You can also extend a generic type to conditionally add functionality, as described in
// Extensions with a Generic Where Clause.

// Note: If you define an extension to add new functionality to an existing type, the new
// functionality will be available on all existing instances of that type, even if they were created
// before the extension was defined.

// MARK: - Computed Properties

// Extensions can add computed instance properties and computed type properties to existing types.
// This example adds five computed instance properties to Swift's built-in Double type, to provide
// basic support for working with distance units

extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
// Prints "One inch is 0.0254 meters"

let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// Prints "Three feet is 0.914399970739201 meters"

// These computed properties express that a Double value should be considered as a certain unit of
// length. Although they're implemented as computed properties, the names of these properties can
// be appended to a floating-point literal value with dot syntax, as a way to use that literal
// value to perform distance conversions.

// In this example, a Double value of 1.0 is considered to represent "one meter". This is why the m
// computed property returns self — the expression 1.m is considered to calculate a Double value of
// 1.0.

// Other units require some conversion to be expressed as a value measured in meters. One kilometer
// is the same as 1,000 meters, so the km computed property multiplies the value by 1_000.00 to
// convert into a number expressed in meters. Similarly, there are 3.28084 feet in a meter, and so
// the ft computed property divides the underlying Double value by 3.28084, to convert it from
// feet to meters.

// These properties are read-only computed properties, and so they're expressed without the get
// keyword, for brevity. Their return value is of type Double, and can be used within mathematical
// calculations wherever a Double is accepted

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")
// Prints "A marathon is 42195.0 meters long"

// Note: Extensions can add new computed properties, but they can't add stored properties, or add
// property observers to existing properties.

// MARK: - Initializers

// Extensions can add new initializers to existing types. This enables you to extend other types to
// accept your own custom types as initializer parameters, or to provide additional initialization
// options that were not included as part of the type's original implementation.

// Extensions can add new convenience initializers to a class, but they can't add new designated
// initializers or deinitializers to a class. Designated initializers and deinitializers must always
// be provided by the original class implementation.

// If you use an extension to add an initializer to a value type that provides default values for all
// of its stored properties and doesn't define any custom initializers, you can call the default
// initializer and memberwise initializer for that value type from within your extension's initializer.
// This wouldn't be the case if you had written the initializer as part of the value type's original
// implementation, as described in Initializer Delegation for Value Types.

// If you use an extension to add an initializer to a structure that was declared in another module,
// the new initializer can't access self until it calls an initializer from the defining module.

// The example below defines a custom Rect structure to represent a geometric rectangle. The example
// also defines two supporting structures called Size and Point, both of which provide default values
// of 0.0 for all of their properties

struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

// Because the Rect structure provides default values for all of its properties, it receives a default
// initializer and a memberwise initializer automatically, as described in Default Initializers.
// These initializers can be used to create new Rect instances

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                         size: Size(width: 5.0, height: 5.0))

// You can extend the Rect structure to provide an additional initializer that takes a specific center
// point and size

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

// This new initializer starts by calculating an appropriate origin point based on the provided
// center point and size value. The initializer then calls the structure's automatic memberwise
// initializer init(origin:size:), which stores the new origin and size values in the appropriate
// properties

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))
// centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)

// Note: If you provide a new initializer with an extension, you are still responsible for making
// sure that each instance is fully initialized once the initializer completes.

// MARK: - Methods

// Extensions can add new instance methods and type methods to existing types. The following example
// adds a new instance method called repetitions to the Int type

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

// The repetitions(task:) method takes a single argument of type () -> Void, which indicates a
// function that has no parameters and doesn't return a value.

// After defining this extension, you can call the repetitions(task:) method on any integer to
// perform a task that many number of times

3.repetitions {
    print("Hello!")
}
// Hello!
// Hello!
// Hello!

// MARK: - Mutating Instance Methods

// Instance methods added with an extension can also modify (or mutate) the instance itself. Structure
// and enumeration methods that modify self or its properties must mark the instance method as
// mutating, just like mutating methods from an original implementation.

// The example below adds a new mutating method called square to Swift's Int type, which squares the
// original value

extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()
// someInt is now 9

// MARK: - Subscripts

// Extensions can add new subscripts to an existing type. This example adds an integer subscript to
// Swift's built-in Int type. This subscript [n] returns the decimal digit n places in from the
// right of the number:
// - 123456789[0] returns 9
// - 123456789[1] returns 8
// ...and so on

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

746381295[0]
// returns 5
746381295[1]
// returns 9
746381295[2]
// returns 2
746381295[8]
// returns 7

// If the Int value doesn't have enough digits for the requested index, the subscript implementation
// returns 0, as if the number had been padded with zeros to the left

746381295[9]
// returns 0, as if you had requested:
// 0746381295[9]

// MARK: - Nested Types

// Extensions can add new nested types to existing classes, structures, and enumerations

extension Int {
    enum Kind {
        case negative, zero, positive
    }
    
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

// This example adds a new nested enumeration to Int. This enumeration, called Kind, expresses the
// kind of number that a particular integer represents. Specifically, it expresses whether the number
// is negative, zero, or positive.

// This example also adds a new computed instance property to Int, called kind, which returns the
// appropriate Kind enumeration case for that integer.

// The nested enumeration can now be used with any Int value

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}

printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
// Prints "+ + - 0 - 0 + "

// This function, printIntegerKinds(_:), takes an input array of Int values and iterates over those
// values in turn. For each integer in the array, the function considers the kind computed property
// for that integer, and prints an appropriate description.

// Note: number.kind is already known to be of type Int.Kind. Because of this, all of the Int.Kind
// case values can be written in shorthand form inside the switch statement, such as .negative rather
// than Int.Kind.negative.

// MARK: - Additional Examples

// MARK: - String Extensions

extension String {
    // Computed property to get the first character
    var firstCharacter: Character? {
        return self.isEmpty ? nil : self[self.startIndex]
    }
    
    // Method to repeat a string
    func repeated(_ times: Int) -> String {
        return String(repeating: self, count: times)
    }
    
    // Mutating method to capitalize first letter
    mutating func capitalizeFirstLetter() {
        guard !self.isEmpty else { return }
        self = self.prefix(1).uppercased() + self.dropFirst()
    }
    
    // Subscript to get character at index
    subscript(index: Int) -> Character? {
        guard index >= 0 && index < self.count else { return nil }
        let stringIndex = self.index(self.startIndex, offsetBy: index)
        return self[stringIndex]
    }
    
    // Nested type for string validation
    enum ValidationResult {
        case valid
        case invalid(String)
    }
    
    // Method using nested type
    func validateEmail() -> ValidationResult {
        if self.contains("@") && self.contains(".") {
            return .valid
        } else {
            return .invalid("Invalid email format")
        }
    }
}

// MARK: - Array Extensions

extension Array {
    // Safe subscript that returns optional
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    // Method to get middle element
    var middle: Element? {
        guard !isEmpty else { return nil }
        return self[count / 2]
    }
    
    // Method to chunk array into smaller arrays
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

// MARK: - Date Extensions

extension Date {
    // Computed property for formatted date string
    var formattedString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
    // Method to check if date is today
    func isToday() -> Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    // Method to add days
    func addingDays(_ days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }
}

// MARK: - Protocol Conformance via Extension

protocol Describable {
    var description: String { get }
}

extension Int: Describable {
    var description: String {
        return "The integer value is \(self)"
    }
}

extension String: Describable {
    var description: String {
        return "The string value is '\(self)'"
    }
}

// MARK: - Collection Extensions

extension Collection {
    // Method to check if collection is not empty
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
    // Method to get first element safely
    var firstOrNil: Element? {
        return first
    }
}

// MARK: - Optional Extensions

extension Optional {
    // Method to execute closure if value exists
    func ifSome(_ closure: (Wrapped) -> Void) {
        if let value = self {
            closure(value)
        }
    }
    
    // Method to get value or default
    func or(_ defaultValue: Wrapped) -> Wrapped {
        return self ?? defaultValue
    }
}

// MARK: - Example Function Demonstrating All Extension Concepts

func demonstrateExtensions() {
    print("\n=== Demonstrating Swift Extensions ===\n")
    
    // Computed properties
    print("1. Computed Properties:")
    let distance = 5.km
    print("   5 km = \(distance) meters")
    let marathon = 42.km + 195.m
    print("   Marathon = \(marathon) meters")
    
    // Initializers
    print("\n2. Initializers:")
    let rect = Rect(center: Point(x: 5.0, y: 5.0), size: Size(width: 4.0, height: 4.0))
    print("   Rect center: (\(rect.origin.x), \(rect.origin.y))")
    print("   Rect size: \(rect.size.width) x \(rect.size.height)")
    
    // Methods
    print("\n3. Methods:")
    print("   Repeating 'Hi' 3 times:")
    3.repetitions {
        print("   Hi")
    }
    
    // Mutating methods
    print("\n4. Mutating Methods:")
    var number = 5
    print("   Before square: \(number)")
    number.square()
    print("   After square: \(number)")
    
    // Subscripts
    print("\n5. Subscripts:")
    let testNumber = 746381295
    print("   Digit at index 0: \(testNumber[0])")
    print("   Digit at index 1: \(testNumber[1])")
    print("   Digit at index 2: \(testNumber[2])")
    
    // Nested types
    print("\n6. Nested Types:")
    let numbers = [3, 19, -27, 0, -6, 0, 7]
    print("   Integer kinds: ", terminator: "")
    printIntegerKinds(numbers)
    
    // String extensions
    print("\n7. String Extensions:")
    var greeting = "hello"
    print("   First character: \(greeting.firstCharacter ?? "?")")
    print("   Repeated 3 times: \(greeting.repeated(3))")
    greeting.capitalizeFirstLetter()
    print("   After capitalizeFirstLetter: \(greeting)")
    print("   Character at index 2: \(greeting[2] ?? "?")")
    
    let email = "test@example.com"
    switch email.validateEmail() {
    case .valid:
        print("   Email is valid")
    case .invalid(let message):
        print("   Email validation: \(message)")
    }
    
    // Array extensions
    print("\n8. Array Extensions:")
    let numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    print("   Safe subscript [10]: \(numbersArray[safe: 10] ?? nil)")
    print("   Safe subscript [2]: \(numbersArray[safe: 2] ?? nil)")
    print("   Middle element: \(numbersArray.middle ?? nil)")
    let chunks = numbersArray.chunked(into: 3)
    print("   Chunked into 3: \(chunks)")
    
    // Date extensions
    print("\n9. Date Extensions:")
    let now = Date()
    print("   Formatted date: \(now.formattedString)")
    print("   Is today: \(now.isToday())")
    let tomorrow = now.addingDays(1)
    print("   Tomorrow: \(tomorrow.formattedString)")
    
    // Protocol conformance
    print("\n10. Protocol Conformance via Extension:")
    let intValue: Describable = 42
    print("   \(intValue.description)")
    let stringValue: Describable = "Swift"
    print("   \(stringValue.description)")
    
    // Collection extensions
    print("\n11. Collection Extensions:")
    let collection = [1, 2, 3]
    print("   Is not empty: \(collection.isNotEmpty)")
    print("   First or nil: \(collection.firstOrNil ?? nil)")
    
    // Optional extensions
    print("\n12. Optional Extensions:")
    let optionalValue: Int? = 42
    optionalValue.ifSome { value in
        print("   Value exists: \(value)")
    }
    let nilValue: Int? = nil
    print("   Value or default: \(nilValue.or(0))")
    
    print("\n=== End of Demonstration ===\n")
}

// Uncomment to run the demonstration
// demonstrateExtensions()


