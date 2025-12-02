//
//  Expressions.swift
//  Swift Language Practice - Expressions
//
//  This file contains examples demonstrating Swift expressions, including prefix,
//  infix, primary, and postfix expressions.
//

import Foundation

// MARK: - Introduction to Expressions

// In Swift, there are four kinds of expressions: prefix expressions, infix expressions,
// primary expressions, and postfix expressions. Evaluating an expression returns a value,
// causes a side effect, or both.

// Prefix and infix expressions let you apply operators to smaller expressions. Primary
// expressions are conceptually the simplest kind of expression, and they provide a way to
// access values. Postfix expressions, like prefix and infix expressions, let you build up
// more complex expressions using postfixes such as function calls and member access.

// MARK: - Prefix Expressions

// Prefix expressions combine an optional prefix operator with an expression. Prefix operators
// take one argument, the expression that follows them.

let negative = -5
let positive = +5
let notTrue = !true
let bitwiseNot = ~0b1010

// MARK: - In-Out Expression

// An in-out expression marks a variable that's being passed as an in-out argument to a
// function call expression.

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
// someInt is now 107, and anotherInt is now 3

// In-out expressions are also used when providing a non-pointer argument in a context where
// a pointer is needed, as described in Implicit Conversion to a Pointer Type.

func unsafeFunction(pointer: UnsafePointer<Int>) {
    print("Pointer value: \(pointer.pointee)")
}

var myNumber = 1234
unsafeFunction(pointer: &myNumber)

// MARK: - Try Operator

// A try expression consists of the try operator followed by an expression that can throw an
// error. It has the following form: try <#expression#>

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

func someThrowingFunction() throws -> Int {
    return 42
}

func anotherThrowingFunction() throws -> Int {
    return 10
}

// Example: try expression
do {
    let value = try someThrowingFunction()
    print("Value: \(value)")
} catch {
    print("Error: \(error)")
}

// An optional-try expression consists of the try? operator followed by an expression that
// can throw an error. If the expression doesn't throw an error, the value of the optional-try
// expression is an optional containing the value of the expression. Otherwise, the value of
// the optional-try expression is nil.

let optionalValue = try? someThrowingFunction()
// optionalValue is of type Int?

// A forced-try expression consists of the try! operator followed by an expression that can
// throw an error. The value of a forced-try expression is the value of the expression. If the
// expression throws an error, a runtime error is produced.

let forcedValue = try! someThrowingFunction()
// forcedValue is of type Int (not optional)

// When the expression on the left-hand side of an infix operator is marked with try, try?,
// or try!, that operator applies to the whole infix expression.

var sum = try someThrowingFunction() + anotherThrowingFunction()
// Writing 'try' applies to both function calls.

sum = try (someThrowingFunction() + anotherThrowingFunction())
// Writing 'try' applies to both function calls.

// sum = (try someThrowingFunction()) + anotherThrowingFunction()
// Error: Writing 'try' applies only to the first function call.

// A try expression can't appear on the right-hand side of an infix operator, unless the
// infix operator is the assignment operator or the try expression is enclosed in parentheses.

// If an expression includes both the try and await operator, the try operator must appear first.

// MARK: - Await Operator

// An await expression consists of the await operator followed by an expression that uses the
// result of an asynchronous operation. It has the following form: await <#expression#>

func someAsyncFunction() async -> Int {
    return 42
}

func anotherAsyncFunction() async -> Int {
    return 10
}

// Example: await expression (must be in async context)
func exampleAsyncFunction() async {
    let value = await someAsyncFunction()
    print("Async value: \(value)")
    
    // Writing 'await' applies to both function calls.
    sum = await someAsyncFunction() + anotherAsyncFunction()
    
    sum = await (someAsyncFunction() + anotherAsyncFunction())
    
    // sum = (await someAsyncFunction()) + anotherAsyncFunction()
    // Error: Writing 'await' applies only to the first function call.
}

// An expression marked with await is called a potential suspension point. Execution of an
// asynchronous function can be suspended at each expression that's marked with await.

// If an expression includes both the await and try operator, the try operator must appear first.

func asyncThrowingFunction() async throws -> Int {
    return 42
}

func exampleAsyncThrowing() async {
    do {
        let value = try await asyncThrowingFunction()
        print("Value: \(value)")
    } catch {
        print("Error: \(error)")
    }
}

// MARK: - Infix Expressions

// Infix expressions combine an infix binary operator with the expression that it takes as its
// left- and right-hand arguments. It has the following form:
// <#left-hand argument#> <#operator#> <#right-hand argument#>

let addition = 2 + 3
let subtraction = 5 - 2
let multiplication = 4 * 6
let division = 10 / 2
let remainder = 10 % 3

// At parse time, an expression made up of infix operators is represented as a flat list. This
// list is transformed into a tree by applying operator precedence. For example, the expression
// 2 + 3 * 5 is initially understood as a flat list of five items, 2, +, 3, *, and 5. This
// process transforms it into the tree (2 + (3 * 5)).

let result = 2 + 3 * 5  // Result is 17, not 25

// MARK: - Assignment Operator

// The assignment operator sets a new value for a given expression. It has the following form:
// <#expression#> = <#value#>

var x = 10
x = 20  // x is now 20

// If the expression is a tuple, the value must be a tuple with the same number of elements.
// (Nested tuples are allowed.) Assignment is performed from each part of the value to the
// corresponding part of the expression.

var a: String
var b: Int
var c: Int

(a, _, (b, c)) = ("test", 9.45, (12, 3))
// a is "test", b is 12, c is 3, and 9.45 is ignored

// The assignment operator doesn't return any value.

// MARK: - Ternary Conditional Operator

// The ternary conditional operator evaluates to one of two given values based on the value
// of a condition. It has the following form:
// <#condition#> ? <#expression used if true#> : <#expression used if false#>

let condition = true
let ternaryResult = condition ? "true" : "false"

// If the condition evaluates to true, the conditional operator evaluates the first expression
// and returns its value. Otherwise, it evaluates the second expression and returns its value.
// The unused expression isn't evaluated.

let maxValue = (a > b) ? a : b

// MARK: - Type-Casting Operators

// There are four type-casting operators: the is operator, the as operator, the as? operator,
// and the as! operator.

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

// The is operator checks at runtime whether the expression can be cast to the specified type.
// It returns true if the expression can be cast to the specified type; otherwise, it returns false.

for item in library {
    if item is Movie {
        print("Movie: \(item.name)")
    } else if item is Song {
        print("Song: \(item.name)")
    }
}

// The as operator performs a cast when it's known at compile time that the cast always succeeds,
// such as upcasting or bridging.

func f(_ any: Any) { print("Function for Any") }
func f(_ int: Int) { print("Function for Int") }

let x2 = 10
f(x2)
// Prints "Function for Int"

let y: Any = x2
f(y)
// Prints "Function for Any"

f(x2 as Any)
// Prints "Function for Any"

// The as? operator performs a conditional cast of the expression to the specified type. The
// as? operator returns an optional of the specified type.

for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), Dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}

// The as! operator performs a forced cast of the expression to the specified type. The as!
// operator returns a value of the specified type, not an optional type. If the cast fails,
// a runtime error is raised.

let movie = library[0] as! Movie
print("Director: \(movie.director)")

// MARK: - Primary Expressions

// Primary expressions are the most basic kind of expression. They can be used as expressions
// on their own, and they can be combined with other tokens to make prefix expressions, infix
// expressions, and postfix expressions.

// MARK: - Literal Expression

// A literal expression consists of either an ordinary literal (such as a string or a number),
// an array or dictionary literal, or a playground literal.

// Example: Ordinary literals
let integerLiteral = 42
let floatLiteral = 3.14159
let stringLiteral = "Hello, world!"
let booleanLiteral = true
let nilLiteral: String? = nil

// An array literal is an ordered collection of values. It has the following form:
// [<#value 1#>, <#value 2#>, <#...#>]

let arrayLiteral = [1, 2, 3, 4, 5]
let emptyArray: [Double] = []

// A dictionary literal is an unordered collection of key-value pairs. It has the following form:
// [<#key 1#>: <#value 1#>, <#key 2#>: <#value 2#>, <#...#>]

let dictionaryLiteral = ["Alex": 31, "Paul": 39]
let emptyDictionary: [String: Double] = [:]

// Note: Prior to Swift 5.9, the following special literals were recognized: #column, #dsohandle,
// #fileID, #filePath, #file, #function, and #line. These are now implemented as macros in the
// Swift standard library: column(), dsohandle(), fileID(), filePath(), file(), function(), and
// line().

print("File: \(#fileID)")
print("Function: \(#function)")
print("Line: \(#line)")

// MARK: - Self Expression

// The self expression is an explicit reference to the current type or instance of the type in
// which it occurs.

class SomeClass {
    var greeting: String
    
    init(greeting: String) {
        self.greeting = greeting  // Using self to disambiguate
    }
    
    func printGreeting() {
        print(self.greeting)  // Explicit self reference
    }
}

// In a mutating method of a value type, you can assign a new instance of that value type to self.

struct Point {
    var x = 0.0, y = 0.0
    
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}

var point = Point(x: 1.0, y: 2.0)
point.moveBy(x: 3.0, y: 4.0)
// point is now (4.0, 6.0)

// MARK: - Superclass Expression

// A superclass expression lets a class interact with its superclass.

class Vehicle {
    var numberOfWheels: Int
    
    init(numberOfWheels: Int) {
        self.numberOfWheels = numberOfWheels
    }
    
    func description() -> String {
        return "\(numberOfWheels) wheel(s)"
    }
}

class Bicycle: Vehicle {
    override init(numberOfWheels: Int) {
        super.init(numberOfWheels: numberOfWheels)  // super.init
    }
    
    override func description() -> String {
        return "Bicycle with \(super.description())"  // super.description
    }
}

// MARK: - Conditional Expression

// A conditional expression evaluates to one of several given values based on the value of a
// condition. It has one the following forms:

// if <#condition 1#> {
//    <#expression used if condition 1 is true#>
// } else if <#condition 2#> {
//    <#expression used if condition 2 is true#>
// } else {
//    <#expression used if both conditions are false#>
// }

let someCondition = true
let number: Double = if someCondition { 10 } else { 12.34 }
let number2 = if someCondition { 10 as Double } else { 12.34 }

// switch <#expression#> {
// case <#pattern 1#>:
//     <#expression 1#>
// case <#pattern 2#> where <#condition#>:
//     <#expression 2#>
// default:
//     <#expression 3#>
// }

let value = 5
let result2 = switch value {
case 1...3:
    "Small"
case 4...6:
    "Medium"
default:
    "Large"
}

// A conditional expression appears only in the following contexts:
// - As the value assigned to a variable
// - As the initial value in a variable or constant declaration
// - As the error thrown by a throw expression
// - As the value returned by a function, closure, or property getter
// - As the value inside a branch of a conditional expression

// The branches of a conditional expression are exhaustive, ensuring that the expression always
// produces a value regardless of the condition. This means each if branch needs a corresponding
// else branch.

// Each branch must produce a value of the same type. Because type checking of each branch is
// independent, you sometimes need to specify the value's type explicitly.

// MARK: - Closure Expression

// A closure expression creates a closure, also known as a lambda or an anonymous function in
// other programming languages. Like a function declaration, a closure contains statements, and
// it captures constants and variables from its enclosing scope.

// Full form:
let fullClosure = { (x: Int, y: Int) -> Int in
    return x + y
}

// Omitting types:
let inferredClosure = { x, y in
    return x + y
}

// Omitting parameter names (using implicit $0, $1, etc.):
let shorthandClosure = { return $0 + $1 }

// Single expression (implicit return):
let singleExpressionClosure = { $0 + $1 }

// Writing throws or async in a closure expression explicitly marks a closure as throwing or
// asynchronous.

let throwingClosure = { (x: Int) throws -> Int in
    if x < 0 {
        throw VendingMachineError.invalidSelection
    }
    return x * 2
}

let asyncClosure = { (x: Int) async -> Int in
    return x * 2
}

// MARK: - Capture Lists

// By default, a closure expression captures constants and variables from its surrounding scope
// with strong references to those values. You can use a capture list to explicitly control how
// values are captured in a closure.

var a2 = 0
var b2 = 0

let closure = { [a2] in
    print(a2, b2)
}

a2 = 10
b2 = 10
closure()
// Prints "0 10"

// The a in the inner scope is initialized with the value of the a in the outer scope when the
// closure is created, but their values aren't connected in any special way. This means that a
// change to the value of a in the outer scope doesn't affect the value of a in the inner scope,
// nor does a change to a inside the closure affect the value of a outside the closure. In
// contrast, there's only one variable named b — the b in the outer scope — so changes from
// inside or outside the closure are visible in both places.

// This distinction isn't visible when the captured variable's type has reference semantics.

class SimpleClass {
    var value: Int = 0
}

var x3 = SimpleClass()
var y3 = SimpleClass()

let closure2 = { [x3] in
    print(x3.value, y3.value)
}

x3.value = 10
y3.value = 10
closure2()
// Prints "10 10"

// If the type of the expression's value is a class, you can mark the expression in a capture
// list with weak or unowned to capture a weak or unowned reference to the expression's value.

class MyClass {
    var title: String = "Title"
    
    func example() {
        // implicit strong capture
        let closure1 = { print(self.title) }
        
        // explicit strong capture
        let closure2 = { [self] in print(self.title) }
        
        // weak capture
        let closure3 = { [weak self] in print(self?.title ?? "nil") }
        
        // unowned capture
        let closure4 = { [unowned self] in print(self.title) }
    }
}

// You can also bind an arbitrary expression to a named value in a capture list.

class Parent {
    var title: String = "Parent"
}

class Child {
    var parent: Parent?
    
    func example() {
        // Weak capture of "self.parent" as "parent"
        let closure = { [weak parent = self.parent] in
            print(parent?.title ?? "nil")
        }
    }
}

// MARK: - Implicit Member Expression

// An implicit member expression is an abbreviated way to access a member of a type, such as an
// enumeration case or a type method, in a context where type inference can determine the implied
// type.

enum MyEnumeration {
    case someValue
    case anotherValue
}

var x4 = MyEnumeration.someValue
x4 = .anotherValue  // Implicit member expression

// If the inferred type is an optional, you can also use a member of the non-optional type in an
// implicit member expression.

var someOptional: MyEnumeration? = .someValue

// Implicit member expressions can be followed by a postfix operator or other postfix syntax
// listed in Postfix Expressions. This is called a chained implicit member expression.

class SomeClass2 {
    static var shared = SomeClass2()
    static var sharedSubclass = SomeSubclass2()
    var a = AnotherClass2()
}

class SomeSubclass2: SomeClass2 { }

class AnotherClass2 {
    static var s = SomeClass2()
    func f() -> SomeClass2 { return AnotherClass2.s }
}

let x5: SomeClass2 = .shared.a.f()
let y2: SomeClass2? = .shared
let z: SomeClass2 = .sharedSubclass

// MARK: - Parenthesized Expression

// A parenthesized expression consists of an expression surrounded by parentheses. You can use
// parentheses to specify the precedence of operations by explicitly grouping expressions.

let parenthesized = (1 + 2) * 3  // Result is 9, not 7

// Grouping parentheses don't change an expression's type — for example, the type of (1) is
// simply Int.

let grouped = (1)  // Type is Int

// MARK: - Tuple Expression

// A tuple expression consists of a comma-separated list of expressions surrounded by parentheses.
// Each expression can have an optional identifier before it, separated by a colon (:).

let tuple1 = (1, 2, 3)  // Unnamed tuple
let tuple2 = (x: 1, y: 2)  // Named tuple
let tuple3 = (a: 10, b: (x: 1, y: 2))  // Nested tuple

// Each identifier in a tuple expression must be unique within the scope of the tuple expression.
// In a nested tuple expression, identifiers at the same level of nesting must be unique.

// (a: 10, a: 20) is invalid because the label a appears twice at the same level.
// However, (a: 10, b: (a: 1, x: 2)) is valid — although a appears twice, it appears once in
// the outer tuple and once in the inner tuple.

let validNested = (a: 10, b: (a: 1, x: 2))  // Valid

// A tuple expression can contain zero expressions, or it can contain two or more expressions.
// A single expression inside parentheses is a parenthesized expression.

let emptyTuple = ()  // Empty tuple

// MARK: - Wildcard Expression

// A wildcard expression is used to explicitly ignore a value during an assignment.

let (x6, _) = (10, 20)
// x6 is 10, and 20 is ignored

let (_, y3) = (10, 20)
// y3 is 20, and 10 is ignored

// MARK: - Macro-Expansion Expression

// A macro-expansion expression consists of a macro name followed by a comma-separated list of
// the macro's arguments in parentheses. The macro is expanded at compile time.

// Example: Using standard library macros
print("File: \(#fileID)")
print("Function: \(#function)")
print("Line: \(#line)")

// A macro-expansion expression can appear as the default value for a parameter.

func f(a: Int = #line, b: Int = (#line), c: Int = 100 + #line) {
    print(a, b, c)
}

// MARK: - Key-Path Expression

// A key-path expression refers to a property or subscript of a type. You use key-path expressions
// in dynamic programming tasks, such as key-value observing.

struct SomeStructure {
    var someValue: Int
}

let s = SomeStructure(someValue: 12)
let pathToProperty = \SomeStructure.someValue

let value = s[keyPath: pathToProperty]
// value is 12

// The type name can be omitted in contexts where type inference can determine the implied type.

class SomeClass3: NSObject {
    @objc dynamic var someProperty: Int
    
    init(someProperty: Int) {
        self.someProperty = someProperty
    }
}

let c = SomeClass3(someProperty: 10)
// c.observe(\.someProperty) { object, change in
//     // ...
// }

// The path can refer to self to create the identity key path (\.self). The identity key path
// refers to a whole instance.

var compoundValue = (a: 1, b: 2)
// Equivalent to compoundValue = (a: 10, b: 20)
compoundValue[keyPath: \.self] = (a: 10, b: 20)

// The path can contain multiple property names, separated by periods, to refer to a property of
// a property's value.

struct OuterStructure {
    var outer: SomeStructure
    
    init(someValue: Int) {
        self.outer = SomeStructure(someValue: someValue)
    }
}

let nested = OuterStructure(someValue: 24)
let nestedKeyPath = \OuterStructure.outer.someValue

let nestedValue = nested[keyPath: nestedKeyPath]
// nestedValue is 24

// The path can include subscripts using brackets, as long as the subscript's parameter type
// conforms to the Hashable protocol.

let greetings = ["hello", "hola", "bonjour", "안녕"]
let myGreeting = greetings[keyPath: \[String].[1]]
// myGreeting is 'hola'

// The path can use optional chaining and forced unwrapping.

let firstGreeting: String? = greetings.first
let count = greetings[keyPath: \[String].first?.count]

// MARK: - Selector Expression

// A selector expression lets you access the selector used to refer to a method or to a property's
// getter or setter in Objective-C.

class SomeClass4: NSObject {
    @objc let property: String
    
    @objc(doSomethingWithInt:)
    func doSomething(_ x: Int) { }
    
    init(property: String) {
        self.property = property
    }
}

let selectorForMethod = #selector(SomeClass4.doSomething(_:))
let selectorForPropertyGetter = #selector(getter: SomeClass4.property)

// MARK: - Key-Path String Expression

// A key-path string expression lets you access the string used to refer to a property in
// Objective-C, for use in key-value coding and key-value observing APIs.

class SomeClass5: NSObject {
    @objc var someProperty: Int
    
    init(someProperty: Int) {
        self.someProperty = someProperty
    }
}

let c2 = SomeClass5(someProperty: 12)
let keyPath = #keyPath(SomeClass5.someProperty)

if let value2 = c2.value(forKey: keyPath) {
    print(value2)
}
// Prints "12"

// MARK: - Postfix Expressions

// Postfix expressions are formed by applying a postfix operator or other postfix syntax to an
// expression. Syntactically, every primary expression is also a postfix expression.

// MARK: - Function Call Expression

// A function call expression consists of a function name followed by a comma-separated list of
// the function's arguments in parentheses.

func greet(name: String, age: Int) -> String {
    return "Hello, \(name)! You are \(age) years old."
}

let greeting = greet(name: "Alice", age: 30)

// A function call expression can include trailing closures in the form of closure expressions
// immediately after the closing parenthesis.

func someFunction(x: Int, f: (Int) -> Bool) {
    print(f(x))
}

someFunction(x: 10, f: { $0 == 13 })
someFunction(x: 10) { $0 == 13 }  // Trailing closure

// If the trailing closure is the function's only argument, you can omit the parentheses.

func someMethod(f: (Int) -> Bool) {
    print(f(10))
}

someMethod() { $0 == 13 }
someMethod { $0 == 13 }  // Parentheses omitted

// MARK: - Initializer Expression

// An initializer expression provides access to a type's initializer. It has the following form:
// <#expression#>.init(<#initializer arguments#>)

class SomeSubClass: SomeSuperClass {
    override init() {
        // subclass initialization goes here
        super.init()
    }
}

class SomeSuperClass {
    init() {}
}

// Like a function, an initializer can be used as a value.

// Type annotation is required because String has multiple initializers.
let initializer: (Int) -> String = String.init
let oneTwoThree = [1, 2, 3].map(initializer).reduce("", +)
print(oneTwoThree)
// Prints "123"

// MARK: - Explicit Member Expression

// An explicit member expression allows access to the members of a named type, a tuple, or a module.

class SomeClass6 {
    var someProperty = 42
}

let c3 = SomeClass6()
let y4 = c3.someProperty  // Member access

// The members of a tuple are implicitly named using integers in the order they appear, starting
// from zero.

var t = (10, 20, 30)
t.0 = t.1
// Now t is (20, 20, 30)

// To distinguish between methods or initializers whose names differ only by the names of their
// arguments, include the argument names in parentheses.

class SomeClass7 {
    func someMethod(x: Int, y: Int) {}
    func someMethod(x: Int, z: Int) {}
    func overloadedMethod(x: Int, y: Int) {}
    func overloadedMethod(x: Int, y: Bool) {}
}

let instance = SomeClass7()

let a3 = instance.someMethod(x:y:)  // Unambiguous
let d: (Int, Bool) -> Void = instance.overloadedMethod(x:y:)  // Unambiguous

// MARK: - Postfix Self Expression

// A postfix self expression consists of an expression or the name of a type, immediately followed
// by .self.

let x7 = 10
let x7Self = x7.self  // x7Self evaluates to x7

let typeSelf = SomeClass7.self  // typeSelf evaluates to the SomeClass7 type itself

// MARK: - Subscript Expression

// A subscript expression provides subscript access using the getter and setter of the corresponding
// subscript declaration.

let array = [1, 2, 3, 4, 5]
let firstElement = array[0]  // Subscript access

var mutableArray = [1, 2, 3]
mutableArray[0] = 10  // Subscript assignment

// MARK: - Forced-Value Expression

// A forced-value expression unwraps an optional value that you are certain isn't nil. It has
// the following form: <#expression#>!

var x8: Int? = 0
x8! += 1
// x8 is now 1

var someDictionary = ["a": [1, 2, 3], "b": [10, 20]]
someDictionary["a"]![0] = 100
// someDictionary is now ["a": [100, 2, 3], "b": [10, 20]]

// MARK: - Optional-Chaining Expression

// An optional-chaining expression provides a simplified syntax for using optional values in postfix
// expressions. It has the following form: <#expression#>?

class SomeClass8 {
    var property: SomeProperty?
}

class SomeProperty {
    func performAction() -> Bool {
        return true
    }
}

var c4: SomeClass8?
var result3: Bool? = c4?.property?.performAction()

// The following example shows the behavior of the example above without using optional chaining.

var result4: Bool?
if let unwrappedC = c4 {
    result4 = unwrappedC.property?.performAction()
}

// The unwrapped value of an optional-chaining expression can be modified, either by mutating the
// value itself, or by assigning to one of the value's members.

func someFunctionWithSideEffects() -> Int {
    return 42  // No actual side effects.
}

var someDictionary2 = ["a": [1, 2, 3], "b": [10, 20]]

someDictionary2["not here"]?[0] = someFunctionWithSideEffects()
// someFunctionWithSideEffects isn't evaluated
// someDictionary2 is still ["a": [1, 2, 3], "b": [10, 20]]

someDictionary2["a"]?[0] = someFunctionWithSideEffects()
// someFunctionWithSideEffects is evaluated and returns 42
// someDictionary2 is now ["a": [42, 2, 3], "b": [10, 20]]

// MARK: - Additional Examples

// MARK: - Example: Complex Expression with Multiple Operators

let complex = (2 + 3) * 4 - 1  // Result is 19

// MARK: - Example: Nested Function Calls

func outerFunction(_ inner: (Int) -> Int) -> Int {
    return inner(10)
}

let nestedResult = outerFunction { $0 * 2 }  // Result is 20

// MARK: - Example: Multiple Trailing Closures

func multipleClosures(first: (Int) -> Int, second: (Int) -> Int) -> Int {
    return second(first(10))
}

let multipleResult = multipleClosures { $0 * 2 } second: { $0 + 5 }
// Result is 25

// MARK: - Example Function Demonstrating All Expression Concepts

func demonstrateExpressions() {
    print("\n=== Demonstrating Swift Expressions ===\n")
    
    // Prefix expressions
    print("1. Prefix Expressions:")
    print("   Negative: \(negative)")
    print("   Not: \(notTrue)")
    
    // In-out expressions
    print("\n2. In-Out Expressions:")
    print("   someInt: \(someInt), anotherInt: \(anotherInt)")
    
    // Try expressions
    print("\n3. Try Expressions:")
    if let value = optionalValue {
        print("   Optional try: \(value)")
    }
    print("   Forced try: \(forcedValue)")
    
    // Infix expressions
    print("\n4. Infix Expressions:")
    print("   Addition: \(addition)")
    print("   Result with precedence: \(result)")
    
    // Assignment operator
    print("\n5. Assignment Operator:")
    print("   a: \(a), b: \(b), c: \(c)")
    
    // Ternary conditional
    print("\n6. Ternary Conditional Operator:")
    print("   Result: \(ternaryResult)")
    
    // Type casting
    print("\n7. Type-Casting Operators:")
    var movieCount = 0
    var songCount = 0
    for item in library {
        if item is Movie {
            movieCount += 1
        } else if item is Song {
            songCount += 1
        }
    }
    print("   Movies: \(movieCount), Songs: \(songCount)")
    
    // Literal expressions
    print("\n8. Literal Expressions:")
    print("   Array: \(arrayLiteral)")
    print("   Dictionary: \(dictionaryLiteral)")
    
    // Self expression
    print("\n9. Self Expression:")
    let instance = SomeClass(greeting: "Hello")
    instance.printGreeting()
    
    // Conditional expression
    print("\n10. Conditional Expression:")
    print("    Number: \(number)")
    print("    Switch result: \(result2)")
    
    // Closure expressions
    print("\n11. Closure Expressions:")
    print("    Full: \(fullClosure(5, 3))")
    print("    Shorthand: \(shorthandClosure(5, 3))")
    
    // Implicit member expression
    print("\n12. Implicit Member Expression:")
    print("    Enum value: \(x4)")
    
    // Tuple expression
    print("\n13. Tuple Expression:")
    print("    Tuple: \(tuple2)")
    
    // Key-path expression
    print("\n14. Key-Path Expression:")
    print("    Value from key path: \(value)")
    
    // Function call
    print("\n15. Function Call Expression:")
    print("    Greeting: \(greeting)")
    
    // Subscript expression
    print("\n16. Subscript Expression:")
    print("    First element: \(firstElement)")
    
    // Optional chaining
    print("\n17. Optional-Chaining Expression:")
    print("    Result: \(result3 ?? false)")
    
    print("\n=== End of Demonstration ===\n")
}

// Uncomment to run the demonstration
// demonstrateExpressions()


