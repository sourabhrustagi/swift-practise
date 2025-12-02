//
//  Declarations.swift
//  Swift Language Practice - Declarations
//
//  This file contains examples demonstrating Swift declarations, including
//  constants, variables, functions, types, and other declarations.
//

import Foundation

// MARK: - Introduction to Declarations

// A declaration introduces a new name or construct into your program. For example, you use
// declarations to introduce functions and methods, to introduce variables and constants, and
// to define enumeration, structure, class, and protocol types. You can also use a declaration
// to extend the behavior of an existing named type and to import symbols into your program
// that are declared elsewhere.

// In Swift, most declarations are also definitions in the sense that they're implemented or
// initialized at the same time they're declared. That said, because protocols don't implement
// their members, most protocol members are declarations only.

// MARK: - Top-Level Code

// The top-level code in a Swift source file consists of zero or more statements, declarations,
// and expressions. By default, variables, constants, and other named declarations that are
// declared at the top-level of a source file are accessible to code in every source file that's
// part of the same module.

// Top-level constant
let topLevelConstant = 42

// Top-level variable
var topLevelVariable = "Hello"

// MARK: - Code Blocks

// A code block is used by a variety of declarations and control structures to group statements
// together. It has the following form:
// {
//    <#statements#>
// }

func exampleFunction() {
    // This is a code block
    let localVariable = 10
    print(localVariable)
}

// MARK: - Import Declaration

// An import declaration lets you access symbols that are declared outside the current file.

// Basic import
import Foundation

// Import specific symbol
// import struct Foundation.Date

// Import submodule
// import Foundation.NSObject

// MARK: - Constant Declaration

// A constant declaration introduces a constant named value into your program. Constant
// declarations are declared using the let keyword.

// Basic constant declaration
let constantName: Int = 42

// Constant with type inference
let inferredConstant = "Hello, World!"

// Constant with tuple pattern
let (firstNumber, secondNumber) = (10, 42)
print("The first number is \(firstNumber).")
print("The second number is \(secondNumber).")

// Constant type property
struct SomeStruct {
    static let typeProperty = "Type Property"
}

// MARK: - Variable Declaration

// A variable declaration introduces a variable named value into your program and is declared
// using the var keyword.

// MARK: - Stored Variables and Stored Variable Properties

// The following form declares a stored variable or stored variable property:
// var <#variable name#>: <#type#> = <#expression#>

var storedVariable: Int = 10
var inferredVariable = "Hello"

// Stored variable property
struct Point {
    var x: Double
    var y: Double
}

// MARK: - Computed Variables and Computed Properties

// The following form declares a computed variable or computed property:
// var <#variable name#>: <#type#> {
//    get {
//       <#statements#>
//    }
//    set(<#setter name#>) {
//       <#statements#>
//    }
// }

struct Rectangle {
    var width: Double
    var height: Double
    
    // Computed property with getter and setter
    var area: Double {
        get {
            return width * height
        }
        set {
            // Assuming square when setting area
            width = sqrt(newValue)
            height = sqrt(newValue)
        }
    }
    
    // Read-only computed property
    var perimeter: Double {
        return 2 * (width + height)
    }
}

// Computed variable at global scope
var globalComputed: Int {
    get { return 42 }
    set { print("Setting to \(newValue)") }
}

// MARK: - Stored Variable Observers and Property Observers

// You can also declare a stored variable or property with willSet and didSet observers.

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

// Property observers with default parameter names
class Temperature {
    var celsius: Double = 0.0 {
        willSet {
            print("Temperature will be \(newValue)°C")
        }
        didSet {
            print("Temperature was \(oldValue)°C, now \(celsius)°C")
        }
    }
}

// MARK: - Type Variable Properties

// To declare a type variable property, mark the declaration with the static declaration modifier.

struct SomeStructure {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 42
    }
}

class SomeClass {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 42
    }
    
    // Class type property (can be overridden)
    class var overrideableTypeProperty: Int {
        return 100
    }
}

// MARK: - Type Alias Declaration

// A type alias declaration introduces a named alias of an existing type into your program.

typealias Point2D = (x: Double, y: Double)
typealias StringDictionary<Value> = Dictionary<String, Value>

// The following dictionaries have the same type.
var dictionary1: StringDictionary<Int> = [:]
var dictionary2: Dictionary<String, Int> = [:]

// Type alias with generic parameters
typealias DictionaryOfInts<Key: Hashable> = Dictionary<Key, Int>

// Type alias forwarding generic parameters
typealias Diccionario = Dictionary

// MARK: - Function Declaration

// A function declaration introduces a function or method into your program.

// MARK: - Basic Function Declaration

// Basic function
func greet(name: String) -> String {
    return "Hello, \(name)!"
}

// Function without return type (Void)
func printGreeting(name: String) {
    print("Hello, \(name)!")
}

// Function with implicit return
func add(a: Int, b: Int) -> Int {
    a + b  // Implicit return
}

// Function returning multiple values (tuple)
func getMinMax(array: [Int]) -> (min: Int, max: Int) {
    let min = array.min() ?? 0
    let max = array.max() ?? 0
    return (min, max)
}

// MARK: - Parameter Names

// Function parameters are a comma-separated list where each parameter has one of several forms.

// Default parameter names
func f(x: Int, y: Int) -> Int {
    return x + y
}

// Explicit argument labels
func repeatGreeting(_ greeting: String, count n: Int) {
    for _ in 0..<n {
        print(greeting)
    }
}

// MARK: - Parameter Modifiers

// MARK: - In-Out Parameters

// By default, function arguments in Swift are passed by value. To make an in-out parameter
// instead, you apply the inout parameter modifier.

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

// MARK: - Borrowing and Consuming Parameters

// The borrowing modifier indicates that the function does not keep the parameter's value.
// The consuming parameter modifier indicates that the function takes ownership of the value.

// Note: These are advanced features and may require specific Swift versions
// func isLessThan(lhs: borrowing A, rhs: borrowing A) -> Bool { ... }
// func store(a: consuming A) { ... }

// MARK: - Special Kinds of Parameters

// Ignored parameter
func processValue(_ value: Int, _ ignored: String) {
    print(value)
}

// Variadic parameter
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

// Parameter with default value
func greet(name: String = "World") -> String {
    return "Hello, \(name)!"
}

// MARK: - Special Kinds of Methods

// Mutating method
struct Counter {
    var count = 0
    
    mutating func increment() {
        count += 1
    }
}

// Static method
struct Math {
    static func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
}

// Class method (can be overridden)
class BaseClass {
    class func description() -> String {
        return "BaseClass"
    }
}

class SubClass: BaseClass {
    override class func description() -> String {
        return "SubClass"
    }
}

// MARK: - Methods with Special Names

// Call-as-function method
struct CallableStruct {
    var value: Int
    
    func callAsFunction(_ number: Int, scale: Int) {
        print(scale * (number + value))
    }
}

let callable = CallableStruct(value: 100)
callable(4, scale: 2)
callable.callAsFunction(4, scale: 2)
// Both function calls print 208.

// MARK: - Throwing Functions and Methods

// Functions and methods that can throw an error must be marked with the throws keyword.

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

func canThrowErrors() throws -> String {
    throw VendingMachineError.outOfStock
}

// Function that throws a specific error type
func throwsSpecificError() throws(VendingMachineError) -> String {
    throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
}

// MARK: - Rethrowing Functions and Methods

// A function or method can be declared with the rethrows keyword to indicate that it throws
// an error only if one of its function parameters throws an error.

func someFunction(callback: () throws -> Void) rethrows {
    try callback()
}

// MARK: - Asynchronous Functions and Methods

// Functions and methods that run asynchronously must be marked with the async keyword.

func fetchData() async -> String {
    // Simulate async work
    return "Data"
}

// Async throwing function
func fetchDataWithError() async throws -> String {
    // Simulate async work that might throw
    return "Data"
}

// MARK: - Functions that Never Return

// Swift defines a Never type, which indicates that a function or method doesn't return to
// its caller.

func fatalErrorFunction() -> Never {
    fatalError("This function never returns")
}

// MARK: - Nested Functions

// A function definition can appear inside another function declaration.

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}

// MARK: - Enumeration Declaration

// An enumeration declaration introduces a named enumeration type into your program.

// MARK: - Enumerations with Cases of Any Type

enum CompassPoint {
    case north
    case south
    case east
    case west
}

// Enumeration with associated values
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

// Enumeration cases that store associated values can be used as functions
enum Number {
    case integer(Int)
    case real(Double)
}

let f = Number.integer
// f is a function of type (Int) -> Number

// Apply f to create an array of Number instances
let evenInts: [Number] = [0, 2, 4, 6].map(f)

// MARK: - Enumerations with Indirection

// Enumerations can have a recursive structure. To enable indirection for a particular
// enumeration case, mark it with the indirect declaration modifier.

enum Tree<T> {
    case empty
    indirect case node(value: T, left: Tree, right: Tree)
}

// Or mark the entire enumeration
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

// MARK: - Enumerations with Cases of a Raw-Value Type

// Enumeration with integer raw values
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

// Enumeration with string raw values
enum CompassDirection: String {
    case north, south, east, west
}

// Enumeration with explicit raw values
enum ExampleEnum: Int {
    case a, b, c = 5, d
}
// a = 0, b = 1, c = 5, d = 6

// MARK: - Structure Declaration

// A structure declaration introduces a named structure type into your program.

struct Resolution {
    var width = 0
    var height = 0
}

// Structure with methods
struct Point3D {
    var x: Double
    var y: Double
    var z: Double
    
    func distance(from other: Point3D) -> Double {
        let dx = x - other.x
        let dy = y - other.y
        let dz = z - other.z
        return sqrt(dx * dx + dy * dy + dz * dz)
    }
}

// MARK: - Class Declaration

// A class declaration introduces a named class type into your program.

class Vehicle {
    var numberOfWheels: Int
    var maxPassengers: Int
    
    init(numberOfWheels: Int, maxPassengers: Int) {
        self.numberOfWheels = numberOfWheels
        self.maxPassengers = maxPassengers
    }
    
    func description() -> String {
        return "\(numberOfWheels) wheels; up to \(maxPassengers) passengers"
    }
}

class Bicycle: Vehicle {
    override init(numberOfWheels: Int, maxPassengers: Int) {
        super.init(numberOfWheels: 2, maxPassengers: 1)
    }
    
    override func description() -> String {
        return "Bicycle: " + super.description()
    }
}

// MARK: - Actor Declaration

// An actor declaration introduces a named actor type into your program.

actor BankAccount {
    private var balance: Double = 0.0
    
    func deposit(amount: Double) {
        balance += amount
    }
    
    func withdraw(amount: Double) -> Bool {
        if balance >= amount {
            balance -= amount
            return true
        }
        return false
    }
    
    func getBalance() -> Double {
        return balance
    }
}

// MARK: - Protocol Declaration

// A protocol declaration introduces a named protocol type into your program.

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

// Protocol with method requirements
protocol RandomNumberGenerator {
    func random() -> Double
}

// Protocol with initializer requirements
protocol SomeInitializerProtocol {
    init(someParameter: Int)
}

// MARK: - Protocol Property Declaration

// Protocols declare that conforming types must implement a property.

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}

// MARK: - Protocol Method Declaration

// Protocols declare that conforming types must implement a method.

protocol Togglable {
    mutating func toggle()
}

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

// MARK: - Protocol Initializer Declaration

// Protocols declare that conforming types must implement an initializer.

protocol SomeInitializerProtocol2 {
    init()
}

class SomeSuperClass {
    init() {
        // Initializer implementation
    }
}

class SomeSubClass: SomeSuperClass, SomeInitializerProtocol2 {
    // "required" from SomeInitializerProtocol2 conformance; "override" from SomeSuperClass
    required override init() {
        // Initializer implementation
    }
}

// MARK: - Protocol Subscript Declaration

// Protocols declare that conforming types must implement a subscript.

protocol Subscriptable {
    subscript(index: Int) -> Int { get set }
}

struct TimesTable: Subscriptable {
    let multiplier: Int
    
    subscript(index: Int) -> Int {
        get {
            return multiplier * index
        }
        set {
            // Implementation
        }
    }
}

// MARK: - Protocol Associated Type Declaration

// Protocols declare associated types using the associatedtype keyword.

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct IntStack: Container {
    var items: [Int] = []
    
    typealias Item = Int
    
    mutating func append(_ item: Int) {
        items.append(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}

// MARK: - Initializer Declaration

// An initializer declaration introduces an initializer for a class, structure, or enumeration.

// MARK: - Basic Initializers

struct Fahrenheit {
    var temperature: Double
    
    init() {
        temperature = 32.0
    }
}

// MARK: - Designated and Convenience Initializers

class Food {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

// MARK: - Required Initializers

class SomeClass {
    required init() {
        // Initializer implementation
    }
}

class SomeSubclass: SomeClass {
    required init() {
        // Initializer implementation
    }
}

// MARK: - Failable Initializers

// A failable initializer is a type of initializer that produces an optional instance.

struct SomeStruct {
    let property: String
    
    // Produces an optional instance of 'SomeStruct'
    init?(input: String) {
        if input.isEmpty {
            return nil
        }
        property = input
    }
}

// Failable initializer that produces an implicitly unwrapped optional
struct SomeStruct2 {
    let property: String
    
    init!(input: String) {
        if input.isEmpty {
            return nil
        }
        property = input
    }
}

// MARK: - Throwing and Async Initializers

// Initializers can throw errors
struct DataLoader {
    let data: String
    
    init(from file: String) throws {
        // Simulate loading that might fail
        if file.isEmpty {
            throw VendingMachineError.invalidSelection
        }
        self.data = file
    }
}

// Initializers can be asynchronous
actor DataLoader2 {
    let data: String
    
    init(from file: String) async {
        // Simulate async loading
        self.data = file
    }
}

// MARK: - Deinitializer Declaration

// A deinitializer declaration declares a deinitializer for a class type.

class Bank {
    static var coinsInBank = 10_000
    
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}

// MARK: - Extension Declaration

// An extension declaration allows you to extend the behavior of existing types.

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
    
    func times(_ closure: () -> Void) {
        for _ in 0..<self {
            closure()
        }
    }
}

// Extension with protocol conformance
extension Int: CustomStringConvertible {
    public var description: String {
        return "Integer: \(self)"
    }
}

// Extension with where clause
extension Array where Element: Equatable {
    func allEqual() -> Bool {
        guard let first = self.first else { return true }
        return self.allSatisfy { $0 == first }
    }
}

// MARK: - Subscript Declaration

// A subscript declaration allows you to add subscripting support for objects of a particular type.

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

// Read-only subscript
struct TimesTable2 {
    let multiplier: Int
    
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

// Type subscript
enum Planet2: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    
    static subscript(n: Int) -> Planet2 {
        return Planet2(rawValue: n) ?? .mercury
    }
}

// MARK: - Macro Declaration

// A macro declaration introduces a new macro. It begins with the macro keyword.

// Note: Macro declarations are advanced and require SwiftSyntax
// macro myMacro = externalMacro(module: "MyMacros", type: "MyMacro")

// MARK: - Operator Declaration

// An operator declaration introduces a new infix, prefix, or postfix operator into your program.

// Infix operator
infix operator +-: AdditionPrecedence

extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}

// Prefix operator
prefix operator +++

extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}

// Postfix operator
postfix operator ---

extension Int {
    static postfix func --- (value: inout Int) -> Int {
        value -= 1
        return value
    }
}

// MARK: - Precedence Group Declaration

// A precedence group declaration introduces a new grouping for infix operator precedence.

precedencegroup ExponentiationPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

infix operator **: ExponentiationPrecedence

extension Double {
    static func ** (base: Double, exponent: Double) -> Double {
        return pow(base, exponent)
    }
}

// MARK: - Declaration Modifiers

// Declaration modifiers are keywords or context-sensitive keywords that modify the behavior
// or meaning of a declaration.

// MARK: - class modifier

class BaseClass2 {
    class func classMethod() {
        print("Base class method")
    }
    
    static func staticMethod() {
        print("Base static method")
    }
}

// MARK: - final modifier

final class FinalClass {
    final func finalMethod() {
        print("This method cannot be overridden")
    }
}

// MARK: - static modifier

struct SomeStruct3 {
    static var typeProperty = "Some value"
    static func typeMethod() {
        print("Type method")
    }
}

// MARK: - lazy modifier

class DataImporter {
    var filename = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
}

// MARK: - required modifier

class RequiredClass {
    required init() {
        // Required initializer
    }
}

// MARK: - override modifier

class Superclass {
    func someMethod() {
        print("Superclass method")
    }
}

class Subclass: Superclass {
    override func someMethod() {
        print("Subclass method")
        super.someMethod()
    }
}

// MARK: - weak and unowned modifiers

class Person2 {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person2?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

// MARK: - Access Control Levels

// Swift provides five levels of access control: open, public, internal, fileprivate, and private.

// public - can be accessed from any module
public class PublicClass {
    public var publicProperty = "Public"
    internal var internalProperty = "Internal"
    private var privateProperty = "Private"
}

// internal - default access level
internal struct InternalStruct {
    var property = "Internal"
}

// fileprivate - accessible only within the same source file
fileprivate class FilePrivateClass {
    var property = "File Private"
}

// private - accessible only within the enclosing scope
class PrivateExample {
    private var privateProperty = "Private"
    
    func accessPrivate() {
        print(privateProperty)  // OK - same scope
    }
}

// open - can be subclassed from other modules
open class OpenClass {
    open func openMethod() {
        print("Open method")
    }
}

// package - accessible within the same package
// package class PackageClass {
//     package var property = "Package"
// }

// Access control for setters
struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

// MARK: - Additional Examples

// MARK: - Example: Complex Type Declarations

protocol Drawable {
    func draw() -> String
}

struct Line: Drawable {
    var elements: [Drawable]
    func draw() -> String {
        return elements.map { $0.draw() }.joined(separator: "")
    }
}

// MARK: - Example: Generic Declarations

struct Stack<Element> {
    var items: [Element] = []
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

// MARK: - Example Function Demonstrating All Declaration Concepts

func demonstrateDeclarations() {
    print("\n=== Demonstrating Swift Declarations ===\n")
    
    // Constants
    print("1. Constant Declarations:")
    print("   Constant: \(constantName)")
    print("   Tuple: first=\(firstNumber), second=\(secondNumber)")
    
    // Variables
    print("\n2. Variable Declarations:")
    print("   Stored: \(storedVariable)")
    
    // Computed properties
    print("\n3. Computed Properties:")
    var rect = Rectangle(width: 10, height: 5)
    print("   Area: \(rect.area)")
    print("   Perimeter: \(rect.perimeter)")
    
    // Property observers
    print("\n4. Property Observers:")
    let counter = StepCounter()
    counter.totalSteps = 100
    
    // Functions
    print("\n5. Function Declarations:")
    print("   \(greet(name: "Swift"))")
    print("   Mean: \(arithmeticMean(1.0, 2.0, 3.0, 4.0, 5.0))")
    
    // Enumerations
    print("\n6. Enumeration Declarations:")
    let direction = CompassPoint.north
    print("   Direction: \(direction)")
    print("   Planet: \(Planet.earth.rawValue)")
    
    // Structures
    print("\n7. Structure Declarations:")
    let point = Point3D(x: 1, y: 2, z: 3)
    let origin = Point3D(x: 0, y: 0, z: 0)
    print("   Distance: \(point.distance(from: origin))")
    
    // Classes
    print("\n8. Class Declarations:")
    let vehicle = Vehicle(numberOfWheels: 4, maxPassengers: 5)
    print("   \(vehicle.description())")
    
    // Protocols
    print("\n9. Protocol Declarations:")
    let person = Person(fullName: "John Doe")
    print("   Full name: \(person.fullName)")
    
    // Initializers
    print("\n10. Initializer Declarations:")
    if let someStruct = SomeStruct(input: "Hello") {
        print("   Initialized: \(someStruct.property)")
    }
    
    // Subscripts
    print("\n11. Subscript Declarations:")
    var matrix = Matrix(rows: 2, columns: 2)
    matrix[0, 0] = 1.0
    matrix[0, 1] = 2.0
    print("   Matrix[0,0]: \(matrix[0, 0])")
    
    // Extensions
    print("\n12. Extension Declarations:")
    let number = 4
    print("   Is even: \(number.isEven)")
    
    // Operators
    print("\n13. Operator Declarations:")
    let v1 = Vector2D(x: 1.0, y: 2.0)
    let v2 = Vector2D(x: 3.0, y: 4.0)
    let result = v1 +- v2
    print("   Vector +-: (\(result.x), \(result.y))")
    
    print("\n=== End of Demonstration ===\n")
}

// Helper struct for examples
struct Vector2D {
    var x = 0.0, y = 0.0
    
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
    
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}

// Uncomment to run the demonstration
// demonstrateDeclarations()


