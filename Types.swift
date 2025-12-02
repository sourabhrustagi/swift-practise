//
//  Types.swift
//  Swift Language Practice - Types
//
//  This file contains examples demonstrating Swift types, including named types,
//  compound types, type annotations, and type inference.
//

import Foundation

// MARK: - Introduction to Types

// In Swift, there are two kinds of types: named types and compound types. A named type is a type
// that can be given a particular name when it's defined. Named types include classes, structures,
// enumerations, and protocols. For example, instances of a user-defined class named MyClass have
// the type MyClass. In addition to user-defined named types, the Swift standard library defines
// many commonly used named types, including those that represent arrays, dictionaries, and
// optional values.

// Data types that are normally considered basic or primitive in other languages — such as types
// that represent numbers, characters, and strings — are actually named types, defined and
// implemented in the Swift standard library using structures. Because they're named types, you
// can extend their behavior to suit the needs of your program, using an extension declaration.

// A compound type is a type without a name, defined in the Swift language itself. There are two
// compound types: function types and tuple types. A compound type may contain named types and
// other compound types. For example, the tuple type (Int, (Int, Int)) contains two elements:
// The first is the named type Int, and the second is another compound type (Int, Int).

// You can put parentheses around a named type or a compound type. However, adding parentheses
// around a type doesn't have any effect. For example, (Int) is equivalent to Int.

// MARK: - Named Types

// Named types include classes, structures, enumerations, and protocols

// Example: User-defined named type
class MyClass {
    var value: Int = 0
}

struct MyStruct {
    var value: Int = 0
}

enum MyEnum {
    case first
    case second
}

protocol MyProtocol {
    func doSomething()
}

// Example: Standard library named types
let intValue: Int = 42
let stringValue: String = "Hello"
let doubleValue: Double = 3.14

// MARK: - Compound Types

// Compound types include function types and tuple types

// Example: Tuple type (compound type)
let tuple: (Int, String) = (42, "Answer")

// Example: Function type (compound type)
let function: (Int) -> String = { String($0) }

// Example: Compound type containing other compound types
let complexTuple: (Int, (Int, Int)) = (1, (2, 3))

// MARK: - Type Annotation

// A type annotation explicitly specifies the type of a variable or expression. Type annotations
// begin with a colon (:) and end with a type.

let someTuple: (Double, Double) = (3.14159, 2.71828)

func someFunction(a: Int) {
    // Function parameter has type annotation
}

// Type annotations can contain an optional list of type attributes before the type.

// MARK: - Type Identifier

// A type identifier refers to either a named type or a type alias of a named or compound type.

// Most of the time, a type identifier directly refers to a named type with the same name as the
// identifier. For example, Int is a type identifier that directly refers to the named type Int,
// and the type identifier Dictionary<String, Int> directly refers to the named type
// Dictionary<String, Int>.

let directType: Int = 42
let dictionaryType: Dictionary<String, Int> = ["key": 1]

// There are two cases in which a type identifier doesn't refer to a type with the same name.
// In the first case, a type identifier refers to a type alias of a named or compound type.

typealias Point = (Int, Int)
let origin: Point = (0, 0)

// In the second case, a type identifier uses dot (.) syntax to refer to named types declared in
// other modules or nested within other types.

// Example: Nested type
struct Outer {
    struct Inner {
        var value: Int
    }
}

let nested: Outer.Inner = Outer.Inner(value: 10)

// MARK: - Tuple Type

// A tuple type is a comma-separated list of types, enclosed in parentheses.

// You can use a tuple type as the return type of a function to enable the function to return a
// single tuple containing multiple values. You can also name the elements of a tuple type and use
// those names to refer to the values of the individual elements.

// When an element of a tuple type has a name, that name is part of the type.

var someTuple2 = (top: 10, bottom: 12)  // someTuple2 is of type (top: Int, bottom: Int)
someTuple2 = (top: 4, bottom: 42) // OK: Names match.
someTuple2 = (9, 99)              // OK: Names are inferred.
// someTuple2 = (left: 5, right: 5)  // Error: Names don't match.

// All tuple types contain two or more types, except for Void which is a type alias for the empty
// tuple type, ().

let voidValue: Void = ()

// Example: Named tuple elements
let namedTuple: (x: Int, y: Int) = (x: 10, y: 20)
print("x: \(namedTuple.x), y: \(namedTuple.y)")

// Example: Unnamed tuple elements
let unnamedTuple: (Int, String) = (42, "Answer")

// Example: Mixed tuple
let mixedTuple: (String, Int, Bool) = ("Hello", 42, true)

// MARK: - Function Type

// A function type represents the type of a function, method, or closure and consists of a
// parameter and return type separated by an arrow (->):

// (<#parameter type#>) -> <#return type#>

// The parameter type is comma-separated list of types. Because the return type can be a tuple
// type, function types support functions and methods that return multiple values.

// Example: Simple function type
let simpleFunction: (Int) -> String = { String($0) }

// Example: Function type with multiple parameters
let multiParamFunction: (Int, String) -> Bool = { _, _ in true }

// Example: Function type with no parameters
let noParamFunction: () -> Int = { 42 }

// Example: Function type with no return value
let noReturnFunction: (String) -> Void = { _ in }

// Example: Function type returning a tuple
let tupleReturnFunction: () -> (Int, String) = { (42, "Answer") }

// A parameter of the function type () -> T (where T is any type) can apply the autoclosure
// attribute to implicitly create a closure at its call sites.

// A function type can have variadic parameters in its parameter type. Syntactically, a variadic
// parameter consists of a base type name followed immediately by three dots (...), as in Int....
// A variadic parameter is treated as an array that contains elements of the base type name.

let variadicFunction: (Int...) -> Int = { numbers in
    numbers.reduce(0, +)
}

// To specify an in-out parameter, prefix the parameter type with the inout keyword.

let inoutFunction: (inout Int) -> Void = { $0 += 1 }

// If a function type has only one parameter and that parameter's type is a tuple type, then the
// tuple type must be parenthesized when writing the function's type.

let singleTupleParam: ((Int, Int)) -> Void = { _ in }
let twoIntParams: (Int, Int) -> Void = { _, _ in }

// Argument names in functions and methods aren't part of the corresponding function type.

func someFunction(left: Int, right: Int) {}
func anotherFunction(left: Int, right: Int) {}
func functionWithDifferentLabels(top: Int, bottom: Int) {}

var f = someFunction // The type of f is (Int, Int) -> Void, not (left: Int, right: Int) -> Void.
f = anotherFunction              // OK
f = functionWithDifferentLabels  // OK

func functionWithDifferentArgumentTypes(left: Int, right: String) {}
// f = functionWithDifferentArgumentTypes     // Error

func functionWithDifferentNumberOfArguments(left: Int, right: Int, top: Int) {}
// f = functionWithDifferentNumberOfArguments // Error

// Because argument labels aren't part of a function's type, you omit them when writing a
// function type.

// var operation: (lhs: Int, rhs: Int) -> Int     // Error
var operation: (_ lhs: Int, _ rhs: Int) -> Int // OK
var operation2: (Int, Int) -> Int               // OK

// If a function type includes more than a single arrow (->), the function types are grouped from
// right to left. For example, the function type (Int) -> (Int) -> Int is understood as
// (Int) -> ((Int) -> Int) — that is, a function that takes an Int and returns another function
// that takes and returns an Int.

let curriedFunction: (Int) -> (Int) -> Int = { a in
    { b in a + b }
}

// Function types for functions that can throw or rethrow an error must include the throws keyword.

let throwingFunction: (String) throws -> Int = { _ in 42 }
let rethrowingFunction: ((String) throws -> Int) rethrows -> Int = { f in try f("") }

// You can include a type after throws in parentheses to specify the type of error that the function
// throws.

enum CustomError: Error {
    case someError
}

let typedThrowingFunction: (String) throws(CustomError) -> Int = { _ in 42 }

// Function types for asynchronous functions must be marked with the async keyword.

let asyncFunction: (String) async -> Int = { _ in 42 }
let asyncThrowingFunction: (String) async throws -> Int = { _ in 42 }

// MARK: - Restrictions for Nonescaping Closures

// A parameter that's a nonescaping function can't be stored in a property, variable, or constant
// of type Any, because that might allow the value to escape.

// A parameter that's a nonescaping function can't be passed as an argument to another nonescaping
// function parameter.

let external: (() -> Void) -> Void = { _ in () }

func takesTwoFunctions(first: (() -> Void) -> Void, second: (() -> Void) -> Void) {
    // first { first {} }       // Error
    // second { second {}  }     // Error
    // first { second {} }       // Error
    // second { first {} }       // Error
    
    first { external {} }    // OK
    external { first {} }    // OK
}

// MARK: - Array Type

// The Swift language provides the following syntactic sugar for the Swift standard library
// Array<Element> type: [<#type#>]

// In other words, the following two declarations are equivalent:

let someArray: Array<String> = ["Alex", "Brian", "Dave"]
let someArray2: [String] = ["Alex", "Brian", "Dave"]

// The elements of an array can be accessed through subscripting by specifying a valid index value
// in square brackets: someArray[0] refers to the element at index 0, "Alex".

print("First element: \(someArray[0])")

// You can create multidimensional arrays by nesting pairs of square brackets, where the name of the
// base type of the elements is contained in the innermost pair of square brackets.

var array3D: [[[Int]]] = [[[1, 2], [3, 4]], [[5, 6], [7, 8]]]

// When accessing the elements in a multidimensional array, the left-most subscript index refers
// to the element at that index in the outermost array. The next subscript index to the right
// refers to the element at that index in the array that's nested one level in. And so on.

print("array3D[0]: \(array3D[0])")
print("array3D[0][1]: \(array3D[0][1])")
print("array3D[0][1][1]: \(array3D[0][1][1])")

// MARK: - Dictionary Type

// The Swift language provides the following syntactic sugar for the Swift standard library
// Dictionary<Key, Value> type: [<#key type#>: <#value type#>]

// In other words, the following two declarations are equivalent:

let someDictionary: [String: Int] = ["Alex": 31, "Paul": 39]
let someDictionary2: Dictionary<String, Int> = ["Alex": 31, "Paul": 39]

// The values of a dictionary can be accessed through subscripting by specifying the corresponding
// key in square brackets: someDictionary["Alex"] refers to the value associated with the key
// "Alex". The subscript returns an optional value of the dictionary's value type.

if let alexAge = someDictionary["Alex"] {
    print("Alex is \(alexAge) years old")
}

// If the specified key isn't contained in the dictionary, the subscript returns nil.

let unknownAge = someDictionary["Unknown"]  // nil

// The key type of a dictionary must conform to the Swift standard library Hashable protocol.

// MARK: - Optional Type

// The Swift language defines the postfix ? as syntactic sugar for the named type Optional<Wrapped>,
// which is defined in the Swift standard library. In other words, the following two declarations
// are equivalent:

var optionalInteger: Int?
var optionalInteger2: Optional<Int>

// In both cases, the variable optionalInteger is declared to have the type of an optional integer.
// Note that no whitespace may appear between the type and the ?.

// The type Optional<Wrapped> is an enumeration with two cases, none and some(Wrapped), which are
// used to represent values that may or may not be present. Any type can be explicitly declared
// to be (or implicitly converted to) an optional type. If you don't provide an initial value when
// you declare an optional variable or property, its value automatically defaults to nil.

var optionalString: String?  // Automatically defaults to nil

// If an instance of an optional type contains a value, you can access that value using the postfix
// operator !, as shown below:

optionalInteger = 42
let unwrapped = optionalInteger!  // 42

// Using the ! operator to unwrap an optional that has a value of nil results in a runtime error.

// You can also use optional chaining and optional binding to conditionally perform an operation
// on an optional expression. If the value is nil, no operation is performed and therefore no
// runtime error is produced.

if let value = optionalInteger {
    print("Value is \(value)")
}

// MARK: - Implicitly Unwrapped Optional Type

// The Swift language defines the postfix ! as syntactic sugar for the named type Optional<Wrapped>,
// which is defined in the Swift standard library, with the additional behavior that it's
// automatically unwrapped when it's accessed.

var implicitlyUnwrappedString: String!
var explicitlyUnwrappedString: Optional<String>

// Note that no whitespace may appear between the type and the !.

// Because implicit unwrapping changes the meaning of the declaration that contains that type,
// optional types that are nested inside a tuple type or a generic type — such as the element
// types of a dictionary or array — can't be marked as implicitly unwrapped.

// let tupleOfImplicitlyUnwrappedElements: (Int!, Int!)  // Error
let implicitlyUnwrappedTuple: (Int, Int)!             // OK

// let arrayOfImplicitlyUnwrappedElements: [Int!]        // Error
let implicitlyUnwrappedArray: [Int]!                  // OK

// Because implicitly unwrapped optionals have the same Optional<Wrapped> type as optional values,
// you can use implicitly unwrapped optionals in all the same places in your code that you can use
// optionals.

var optionalValue: String? = "Hello"
var implicitlyUnwrappedValue: String! = "World"

optionalValue = implicitlyUnwrappedValue  // OK
implicitlyUnwrappedValue = optionalValue  // OK

// As with optionals, if you don't provide an initial value when you declare an implicitly unwrapped
// optional variable or property, its value automatically defaults to nil.

var nilImplicitlyUnwrapped: String!  // Automatically defaults to nil

// Use optional chaining to conditionally perform an operation on an implicitly unwrapped optional
// expression. If the value is nil, no operation is performed and therefore no runtime error is
// produced.

if let value = implicitlyUnwrappedString {
    print("Value: \(value)")
}

// MARK: - Protocol Composition Type

// A protocol composition type defines a type that conforms to each protocol in a list of specified
// protocols, or a type that's a subclass of a given class and conforms to each protocol in a list
// of specified protocols.

// Protocol composition types have the following form: <#Protocol 1#> & <#Protocol 2#>

protocol ProtocolA {
    func methodA()
}

protocol ProtocolB {
    func methodB()
}

protocol ProtocolC {
    func methodC()
}

// A protocol composition type allows you to specify a value whose type conforms to the
// requirements of multiple protocols without explicitly defining a new, named protocol that
// inherits from each protocol you want the type to conform to.

struct ConformingType: ProtocolA & ProtocolB & ProtocolC {
    func methodA() {}
    func methodB() {}
    func methodC() {}
}

let composition: ProtocolA & ProtocolB & ProtocolC = ConformingType()

// Each item in a protocol composition list is one of the following; the list can contain at most
// one class:

class SuperClass {
    func superMethod() {}
}

class SubClass: SuperClass, ProtocolA {
    func methodA() {}
}

let classAndProtocol: SuperClass & ProtocolA = SubClass()

// When a protocol composition type contains type aliases, it's possible for the same protocol to
// appear more than once in the definitions — duplicates are ignored.

typealias PQ = ProtocolA & ProtocolB
typealias PQR = PQ & ProtocolB & ProtocolC  // Equivalent to ProtocolA & ProtocolB & ProtocolC

// MARK: - Opaque Type

// An opaque type defines a type that conforms to a protocol or protocol composition, without
// specifying the underlying concrete type.

// Opaque types appear as the return type of a function or subscript, as the type of a parameter
// to a function, subscript, or initializer, or as the type of a property. Opaque types can't
// appear as part of a tuple type or a generic type, such as the element type of an array or the
// wrapped type of an optional.

// Opaque types have the following form: some <#constraint#>

protocol Shape {
    func draw() -> String
}

struct Circle: Shape {
    func draw() -> String { return "Circle" }
}

struct Square: Shape {
    func draw() -> String { return "Square" }
}

// Example: Opaque type as return type
func makeShape() -> some Shape {
    return Circle()
}

// Example: Opaque type as parameter type
func processShape(_ shape: some Shape) {
    print(shape.draw())
}

// Writing an opaque type for a parameter is syntactic sugar for using a generic type, without
// specifying a name for the generic type parameter.

func someFunction(x: some ProtocolA, y: some ProtocolA) { }
// Equivalent to:
// func someFunction<T1: ProtocolA, T2: ProtocolA>(x: T1, y: T2) { }

// You can't use an opaque type in the type of a variadic parameter.

// You can't use an opaque type as a parameter to a function type being returned, or as a parameter
// in a parameter type that's a function type.

// func badFunction() -> (some ProtocolA) -> Void { }  // Error
// func anotherBadFunction(callback: (some ProtocolA) -> Void) { }  // Error

// MARK: - Boxed Protocol Type

// A boxed protocol type defines a type that conforms to a protocol or protocol composition, with
// the ability for that conforming type to vary while the program is running.

// Boxed protocol types have the following form: any <#constraint#>

// At runtime, an instance of a boxed protocol type can contain a value of any type that satisfies
// the constraint. This behavior contrasts with how an opaque types work, where there is some
// specific conforming type known at compile time.

var boxedShape: any Shape = Circle()
boxedShape = Square()  // Can change at runtime

// The additional level of indirection that's used when working with a boxed protocol type is
// called boxing. Boxing typically requires a separate memory allocation for storage and an
// additional level of indirection for access, which incurs a performance cost at runtime.

// Applying any to the Any or AnyObject types has no effect, because those types are already
// boxed protocol types.

let anyValue: any Any = 42
let anyObjectValue: any AnyObject = NSObject()

// MARK: - Metatype Type

// A metatype type refers to the type of any type, including class types, structure types,
// enumeration types, and protocol types.

// The metatype of a class, structure, or enumeration type is the name of that type followed by
// .Type. The metatype of a protocol type — not the concrete type that conforms to the protocol
// at runtime — is the name of that protocol followed by .Protocol.

class SomeClass {
    class func printClassName() {
        print("SomeClass")
    }
}

struct SomeStruct {
    static func printStructName() {
        print("SomeStruct")
    }
}

enum SomeEnum {
    static func printEnumName() {
        print("SomeEnum")
    }
}

// Example: Metatype of a class
let classMetatype: SomeClass.Type = SomeClass.self
classMetatype.printClassName()

// Example: Metatype of a struct
let structMetatype: SomeStruct.Type = SomeStruct.self
structMetatype.printStructName()

// Example: Metatype of an enum
let enumMetatype: SomeEnum.Type = SomeEnum.self
enumMetatype.printEnumName()

// Example: Metatype of a protocol
let protocolMetatype: ProtocolA.Protocol = ProtocolA.self

// You can use the postfix self expression to access a type as a value.

let classType = SomeClass.self
let structType = SomeStruct.self

// You can call the type(of:) function with an instance of a type to access that instance's
// dynamic, runtime type as a value.

class SomeBaseClass {
    class func printClassName() {
        print("SomeBaseClass")
    }
}

class SomeSubClass: SomeBaseClass {
    override class func printClassName() {
        print("SomeSubClass")
    }
}

let someInstance: SomeBaseClass = SomeSubClass()
// The compile-time type of someInstance is SomeBaseClass,
// and the runtime type of someInstance is SomeSubClass
type(of: someInstance).printClassName()
// Prints "SomeSubClass"

// Use an initializer expression to construct an instance of a type from that type's metatype value.

class AnotherSubClass: SomeBaseClass {
    let string: String
    
    required init(string: String) {
        self.string = string
    }
    
    override class func printClassName() {
        print("AnotherSubClass")
    }
}

let metatype: AnotherSubClass.Type = AnotherSubClass.self
let anotherInstance = metatype.init(string: "some string")

// MARK: - Any Type

// The Any type can contain values from all other types. Any can be used as the concrete type for
// an instance of any of the following types:
// - A class, structure, or enumeration
// - A metatype, such as Int.self
// - A tuple with any types of components
// - A closure or function type

let mixed: [Any] = ["one", 2, true, (4, 5.3), { () -> Int in return 6 }]

// When you use Any as a concrete type for an instance, you need to cast the instance to a known
// type before you can access its properties or methods. Instances with a concrete type of Any
// maintain their original dynamic type and can be cast to that type using one of the type-cast
// operators — as, as?, or as!.

if let first = mixed.first as? String {
    print("The first item, '\(first)', is a string.")
}
// Prints "The first item, 'one', is a string."

// The AnyObject protocol is similar to the Any type. All classes implicitly conform to AnyObject.
// Unlike Any, which is defined by the language, AnyObject is defined by the Swift standard library.

let anyObjectArray: [AnyObject] = [NSObject(), NSString()]

// MARK: - Self Type

// The Self type isn't a specific type, but rather lets you conveniently refer to the current type
// without repeating or knowing that type's name.

// In a protocol declaration or a protocol member declaration, the Self type refers to the
// eventual type that conforms to the protocol.

protocol Copyable {
    func copy() -> Self
}

class CopyableClass: Copyable {
    func copy() -> Self {
        return type(of: self).init()
    }
    
    required init() {}
}

// In a structure, class, or enumeration declaration, the Self type refers to the type introduced
// by the declaration. Inside the declaration for a member of a type, the Self type refers to that
// type. In the members of a class declaration, Self can appear only as follows:
// - As the return type of a method
// - As the return type of a read-only subscript
// - As the type of a read-only computed property
// - In the body of a method

class Superclass {
    func f() -> Self { return self }
}

let x = Superclass()
print(type(of: x.f()))
// Prints "Superclass"

class Subclass: Superclass { }

let y = Subclass()
print(type(of: y.f()))
// Prints "Subclass"

let z: Superclass = Subclass()
print(type(of: z.f()))
// Prints "Subclass"

// The last part of the example above shows that Self refers to the runtime type Subclass of the
// value of z, not the compile-time type Superclass of the variable itself.

// Inside a nested type declaration, the Self type refers to the type introduced by the innermost
// type declaration.

// The Self type refers to the same type as the type(of:) function in the Swift standard library.
// Writing Self.someStaticMember to access a member of the current type is the same as writing
// type(of: self).someStaticMember.

// MARK: - Type Inheritance Clause

// A type inheritance clause is used to specify which class a named type inherits from and which
// protocols a named type conforms to. A type inheritance clause begins with a colon (:), followed
// by a list of type identifiers.

// Class types can inherit from a single superclass and conform to any number of protocols.

class MyClass2: SuperClass, ProtocolA, ProtocolB {
    func methodA() {}
    func methodB() {}
}

// Other named types can only inherit from or conform to a list of protocols. Protocol types can
// inherit from any number of other protocols.

protocol ProtocolD: ProtocolA, ProtocolB {
    func methodD()
}

// A type inheritance clause in an enumeration definition can be either a list of protocols, or
// in the case of an enumeration that assigns raw values to its cases, a single, named type that
// specifies the type of those raw values.

enum RawValueEnum: Int {
    case first = 1
    case second = 2
}

enum ProtocolEnum: ProtocolA {
    case first
    case second
}

// MARK: - Type Inference

// Swift uses type inference extensively, allowing you to omit the type or part of the type of
// many variables and expressions in your code.

// Example: Type inference from literal
var x2 = 0  // Type is inferred as Int
var y2 = "Hello"  // Type is inferred as String

// Example: Type inference from context
let dict: Dictionary = ["A": 1]  // Type is inferred as Dictionary<String, Int>

// In both of the examples above, the type information is passed up from the leaves of the
// expression tree to its root. That is, the type of x in var x: Int = 0 is inferred by first
// checking the type of 0 and then passing this type information up to the root (the variable x).

// In Swift, type information can also flow in the opposite direction — from the root down to the
// leaves. In the following example, for instance, the explicit type annotation (: Float) on the
// constant eFloat causes the numeric literal 2.71828 to have an inferred type of Float instead
// of Double.

let e = 2.71828 // The type of e is inferred to be Double.
let eFloat: Float = 2.71828 // The type of eFloat is Float.

// Type inference in Swift operates at the level of a single expression or statement. This means
// that all of the information needed to infer an omitted type or part of a type in an expression
// must be accessible from type-checking the expression or one of its subexpressions.

// MARK: - Additional Examples

// MARK: - Example: Type Aliases

typealias StringDictionary = Dictionary<String, String>
typealias IntFunction = (Int) -> Int
typealias Point2D = (x: Double, y: Double)

let point: Point2D = (x: 1.0, y: 2.0)

// MARK: - Example: Complex Function Types

let complexFunction: ((Int) -> String) -> (String) -> Int = { f in
    { s in Int(s) ?? 0 }
}

// MARK: - Example: Optional Chaining with Types

let optionalArray: [Int]? = [1, 2, 3]
let firstElement = optionalArray?[0]

// MARK: - Example: Type Casting

let anyValue2: Any = 42
if let intValue = anyValue2 as? Int {
    print("It's an Int: \(intValue)")
}

// MARK: - Example Function Demonstrating All Type Concepts

func demonstrateTypes() {
    print("\n=== Demonstrating Swift Types ===\n")
    
    // Named types
    print("1. Named Types:")
    print("   Int: \(intValue)")
    print("   String: \(stringValue)")
    print("   Custom class: \(MyClass())")
    
    // Compound types
    print("\n2. Compound Types:")
    print("   Tuple: \(tuple)")
    print("   Function result: \(function(42))")
    
    // Type annotations
    print("\n3. Type Annotations:")
    print("   Tuple: \(someTuple)")
    
    // Tuple types
    print("\n4. Tuple Types:")
    print("   Named: \(namedTuple)")
    print("   Unnamed: \(unnamedTuple)")
    
    // Function types
    print("\n5. Function Types:")
    print("   Simple: \(simpleFunction(42))")
    print("   Curried: \(curriedFunction(1)(2))")
    
    // Array types
    print("\n6. Array Types:")
    print("   Simple: \(someArray)")
    print("   3D: \(array3D[0][1][1])")
    
    // Dictionary types
    print("\n7. Dictionary Types:")
    print("   Dictionary: \(someDictionary)")
    if let age = someDictionary["Alex"] {
        print("   Alex's age: \(age)")
    }
    
    // Optional types
    print("\n8. Optional Types:")
    print("   Optional: \(optionalInteger ?? 0)")
    print("   Implicitly unwrapped: \(implicitlyUnwrappedString ?? "nil")")
    
    // Protocol composition
    print("\n9. Protocol Composition:")
    print("   Composition type works")
    
    // Opaque types
    print("\n10. Opaque Types:")
    let shape = makeShape()
    print("   Shape: \(shape.draw())")
    
    // Boxed protocol types
    print("\n11. Boxed Protocol Types:")
    print("   Boxed shape: \(boxedShape.draw())")
    
    // Metatype types
    print("\n12. Metatype Types:")
    print("   Class metatype: \(classMetatype)")
    
    // Any type
    print("\n13. Any Type:")
    print("   Mixed array count: \(mixed.count)")
    
    // Self type
    print("\n14. Self Type:")
    let copyable = CopyableClass()
    let copied = copyable.copy()
    print("   Copied type: \(type(of: copied))")
    
    // Type inference
    print("\n15. Type Inference:")
    print("   Inferred Int: \(x2)")
    print("   Inferred String: \(y2)")
    print("   Inferred Double: \(e)")
    print("   Explicit Float: \(eFloat)")
    
    print("\n=== End of Demonstration ===\n")
}

// Uncomment to run the demonstration
// demonstrateTypes()


