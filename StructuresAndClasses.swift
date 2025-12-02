//
//  StructuresAndClasses.swift
//  Swift Language Practice - Structures and Classes
//
//  This file contains examples demonstrating Swift structures and classes,
//  including their similarities, differences, and usage patterns.
//

import Foundation

// MARK: - Introduction to Structures and Classes

// Structures and classes are general-purpose, flexible constructs that become the building
// blocks of your program's code. You define properties and methods to add functionality to
// your structures and classes using the same syntax you use to define constants, variables,
// and functions.

// Unlike other programming languages, Swift doesn't require you to create separate interface
// and implementation files for custom structures and classes. In Swift, you define a structure
// or class in a single file, and the external interface to that class or structure is
// automatically made available for other code to use.

// Note: An instance of a class is traditionally known as an object. However, Swift structures
// and classes are much closer in functionality than in other languages, and much of this chapter
// describes functionality that applies to instances of either a class or a structure type.
// Because of this, the more general term instance is used.

// MARK: - Comparing Structures and Classes

// Structures and classes in Swift have many things in common. Both can:
// - Define properties to store values
// - Define methods to provide functionality
// - Define subscripts to provide access to their values using subscript syntax
// - Define initializers to set up their initial state
// - Be extended to expand their functionality beyond a default implementation
// - Conform to protocols to provide standard functionality of a certain kind

// Classes have additional capabilities that structures don't have:
// - Inheritance enables one class to inherit the characteristics of another
// - Type casting enables you to check and interpret the type of a class instance at runtime
// - Deinitializers enable an instance of a class to free up any resources it has assigned
// - Reference counting allows more than one reference to a class instance

// The additional capabilities that classes support come at the cost of increased complexity.
// As a general guideline, prefer structures because they're easier to reason about, and use
// classes when they're appropriate or necessary. In practice, this means most of the custom
// types you define will be structures and enumerations.

// MARK: - Definition Syntax

// Structures and classes have a similar definition syntax. You introduce structures with the
// struct keyword and classes with the class keyword. Both place their entire definition within
// a pair of braces

struct SomeStructure {
    // structure definition goes here
}

class SomeClass {
    // class definition goes here
}

// Note: Whenever you define a new structure or class, you define a new Swift type. Give types
// UpperCamelCase names (such as SomeStructure and SomeClass here) to match the capitalization
// of standard Swift types (such as String, Int, and Bool). Give properties and methods
// lowerCamelCase names (such as frameRate and incrementCount) to differentiate them from type names.

// Here's an example of a structure definition and a class definition

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

// The example above defines a new structure called Resolution, to describe a pixel-based display
// resolution. This structure has two stored properties called width and height. Stored properties
// are constants or variables that are bundled up and stored as part of the structure or class.
// These two properties are inferred to be of type Int by setting them to an initial integer value of 0.

// The example above also defines a new class called VideoMode, to describe a specific video mode
// for video display. This class has four variable stored properties. The first, resolution, is
// initialized with a new Resolution structure instance, which infers a property type of Resolution.
// For the other three properties, new VideoMode instances will be initialized with an interlaced
// setting of false (meaning "noninterlaced video"), a playback frame rate of 0.0, and an optional
// String value called name. The name property is automatically given a default value of nil, or
// "no name value", because it's of an optional type.

// MARK: - Structure and Class Instances

// The Resolution structure definition and the VideoMode class definition only describe what a
// Resolution or VideoMode will look like. They themselves don't describe a specific resolution
// or video mode. To do that, you need to create an instance of the structure or class.

// The syntax for creating instances is very similar for both structures and classes

let someResolution = Resolution()
let someVideoMode = VideoMode()

// Structures and classes both use initializer syntax for new instances. The simplest form of
// initializer syntax uses the type name of the class or structure followed by empty parentheses,
// such as Resolution() or VideoMode(). This creates a new instance of the class or structure,
// with any properties initialized to their default values. Class and structure initialization
// is described in more detail in Initialization.

print("someResolution: width=\(someResolution.width), height=\(someResolution.height)")
print("someVideoMode: resolution=\(someVideoMode.resolution.width)x\(someVideoMode.resolution.height), interlaced=\(someVideoMode.interlaced)")

// MARK: - Accessing Properties

// You can access the properties of an instance using dot syntax. In dot syntax, you write the
// property name immediately after the instance name, separated by a period (.), without any spaces

print("The width of someResolution is \(someResolution.width)")
// Prints "The width of someResolution is 0"

// In this example, someResolution.width refers to the width property of someResolution, and
// returns its default initial value of 0.

// You can drill down into subproperties, such as the width property in the resolution property
// of a VideoMode

print("The width of someVideoMode is \(someVideoMode.resolution.width)")
// Prints "The width of someVideoMode is 0"

// You can also use dot syntax to assign a new value to a variable property

someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
// Prints "The width of someVideoMode is now 1280"

// MARK: - Memberwise Initializers for Structure Types

// All structures have an automatically generated memberwise initializer, which you can use to
// initialize the member properties of new structure instances. Initial values for the properties
// of the new instance can be passed to the memberwise initializer by name

let vga = Resolution(width: 640, height: 480)
print("VGA resolution: \(vga.width)x\(vga.height)")

// Unlike structures, class instances don't receive a default memberwise initializer.
// Initializers are described in more detail in Initialization.

// MARK: - Structures and Enumerations Are Value Types

// A value type is a type whose value is copied when it's assigned to a variable or constant,
// or when it's passed to a function.

// You've actually been using value types extensively throughout the previous chapters. In fact,
// all of the basic types in Swift — integers, floating-point numbers, Booleans, strings, arrays
// and dictionaries — are value types, and are implemented as structures behind the scenes.

// All structures and enumerations are value types in Swift. This means that any structure and
// enumeration instances you create — and any value types they have as properties — are always
// copied when they're passed around in your code.

// Note: Collections defined by the Swift standard library like arrays, dictionaries, and strings
// use an optimization to reduce the performance cost of copying. Instead of making a copy immediately,
// these collections share the memory where the elements are stored between the original instance
// and any copies. If one of the copies of the collection is modified, the elements are copied just
// before the modification. The behavior you see in your code is always as if a copy took place
// immediately.

// Consider this example, which uses the Resolution structure from the previous example

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd

// This example declares a constant called hd and sets it to a Resolution instance initialized
// with the width and height of full HD video (1920 pixels wide by 1080 pixels high).

// It then declares a variable called cinema and sets it to the current value of hd. Because
// Resolution is a structure, a copy of the existing instance is made, and this new copy is
// assigned to cinema. Even though hd and cinema now have the same width and height, they're
// two completely different instances behind the scenes.

print("hd: \(hd.width)x\(hd.height)")
print("cinema: \(cinema.width)x\(cinema.height)")

// Next, the width property of cinema is amended to be the width of the slightly wider 2K standard
// used for digital cinema projection (2048 pixels wide and 1080 pixels high)

cinema.width = 2048

// Checking the width property of cinema shows that it has indeed changed to be 2048

print("cinema is now \(cinema.width) pixels wide")
// Prints "cinema is now 2048 pixels wide"

// However, the width property of the original hd instance still has the old value of 1920

print("hd is still \(hd.width) pixels wide")
// Prints "hd is still 1920 pixels wide"

// When cinema was given the current value of hd, the values stored in hd were copied into the
// new cinema instance. The end result was two completely separate instances that contained the
// same numeric values. However, because they're separate instances, setting the width of cinema
// to 2048 doesn't affect the width stored in hd.

// The same behavior applies to enumerations

enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}

var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")
// Prints "The current direction is north"
// Prints "The remembered direction is west"

// When rememberedDirection is assigned the value of currentDirection, it's actually set to a copy
// of that value. Changing the value of currentDirection thereafter doesn't affect the copy of the
// original value that was stored in rememberedDirection.

// MARK: - Classes Are Reference Types

// Unlike value types, reference types are not copied when they're assigned to a variable or
// constant, or when they're passed to a function. Rather than a copy, a reference to the same
// existing instance is used.

// Here's an example, using the VideoMode class defined above

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

// This example declares a new constant called tenEighty and sets it to refer to a new instance
// of the VideoMode class. The video mode is assigned a copy of the HD resolution of 1920 by 1080
// from before. It's set to be interlaced, its name is set to "1080i", and its frame rate is set
// to 25.0 frames per second.

print("tenEighty: \(tenEighty.name ?? "unnamed"), frameRate=\(tenEighty.frameRate)")

// Next, tenEighty is assigned to a new constant, called alsoTenEighty, and the frame rate of
// alsoTenEighty is modified

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

// Because classes are reference types, tenEighty and alsoTenEighty actually both refer to the
// same VideoMode instance. Effectively, they're just two different names for the same single
// instance.

// Checking the frameRate property of tenEighty shows that it correctly reports the new frame
// rate of 30.0 from the underlying VideoMode instance

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// Prints "The frameRate property of tenEighty is now 30.0"

// This example also shows how reference types can be harder to reason about. If tenEighty and
// alsoTenEighty were far apart in your program's code, it could be difficult to find all the
// ways that the video mode is changed. Wherever you use tenEighty, you also have to think about
// the code that uses alsoTenEighty, and vice versa. In contrast, value types are easier to reason
// about because all of the code that interacts with the same value is close together in your
// source files.

// Note that tenEighty and alsoTenEighty are declared as constants, rather than variables.
// However, you can still change tenEighty.frameRate and alsoTenEighty.frameRate because the
// values of the tenEighty and alsoTenEighty constants themselves don't actually change.
// tenEighty and alsoTenEighty themselves don't "store" the VideoMode instance — instead, they
// both refer to a VideoMode instance behind the scenes. It's the frameRate property of the
// underlying VideoMode that's changed, not the values of the constant references to that VideoMode.

// MARK: - Identity Operators

// Because classes are reference types, it's possible for multiple constants and variables to refer
// to the same single instance of a class behind the scenes. (The same isn't true for structures
// and enumerations, because they're always copied when they're assigned to a constant or variable,
// or passed to a function.)

// It can sometimes be useful to find out whether two constants or variables refer to exactly the
// same instance of a class. To enable this, Swift provides two identity operators:
// - Identical to (===)
// - Not identical to (!==)

// Use these operators to check whether two constants or variables refer to the same single instance

if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
// Prints "tenEighty and alsoTenEighty refer to the same VideoMode instance."

// Note that identical to (represented by three equal signs, or ===) doesn't mean the same thing
// as equal to (represented by two equal signs, or ==). Identical to means that two constants or
// variables of class type refer to exactly the same class instance. Equal to means that two
// instances are considered equal or equivalent in value, for some appropriate meaning of equal,
// as defined by the type's designer.

// When you define your own custom structures and classes, it's your responsibility to decide what
// qualifies as two instances being equal. The process of defining your own implementations of
// the == and != operators is described in Equivalence Operators.

// Example with different instances
let anotherVideoMode = VideoMode()
anotherVideoMode.name = "720p"
anotherVideoMode.frameRate = 60.0

if tenEighty !== anotherVideoMode {
    print("tenEighty and anotherVideoMode refer to different VideoMode instances.")
}
// Prints "tenEighty and anotherVideoMode refer to different VideoMode instances."

// MARK: - Pointers

// If you have experience with C, C++, or Objective-C, you may know that these languages use
// pointers to refer to addresses in memory. A Swift constant or variable that refers to an
// instance of some reference type is similar to a pointer in C, but isn't a direct pointer to
// an address in memory, and doesn't require you to write an asterisk (*) to indicate that you
// are creating a reference. Instead, these references are defined like any other constant or
// variable in Swift. The Swift standard library provides pointer and buffer types that you can
// use if you need to interact with pointers directly — see Manual Memory Management.

// MARK: - Additional Examples

// MARK: - Structure with Methods

struct Rectangle {
    var width: Double
    var height: Double
    
    func area() -> Double {
        return width * height
    }
    
    mutating func scale(by factor: Double) {
        width *= factor
        height *= factor
    }
}

var rect = Rectangle(width: 10.0, height: 5.0)
print("Rectangle area: \(rect.area())")
rect.scale(by: 2.0)
print("Scaled rectangle: \(rect.width)x\(rect.height)")

// MARK: - Class with Methods

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

let counter = Counter()
counter.increment()
print("Counter: \(counter.count)")
counter.increment(by: 5)
print("Counter after increment by 5: \(counter.count)")
counter.reset()
print("Counter after reset: \(counter.count)")

// MARK: - Structure with Computed Properties

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
print("Square center: (\(initialSquareCenter.x), \(initialSquareCenter.y))")
square.center = Point(x: 15.0, y: 15.0)
print("Square origin after moving center: (\(square.origin.x), \(square.origin.y))")

// MARK: - Value Type vs Reference Type Comparison

// Demonstrating value type behavior with structures
struct ValueTypeExample {
    var value: Int
}

var struct1 = ValueTypeExample(value: 10)
var struct2 = struct1
struct2.value = 20

print("struct1.value: \(struct1.value)")  // Prints 10
print("struct2.value: \(struct2.value)")  // Prints 20
// struct1 and struct2 are independent copies

// Demonstrating reference type behavior with classes
class ReferenceTypeExample {
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
}

var class1 = ReferenceTypeExample(value: 10)
var class2 = class1
class2.value = 20

print("class1.value: \(class1.value)")  // Prints 20
print("class2.value: \(class2.value)")  // Prints 20
// class1 and class2 refer to the same instance

if class1 === class2 {
    print("class1 and class2 refer to the same instance")
}

// MARK: - Example Function Demonstrating All Concepts

func demonstrateStructuresAndClasses() {
    print("\n=== Demonstrating Swift Structures and Classes ===\n")
    
    // Structure instance
    print("1. Structure Instance:")
    let resolution = Resolution(width: 1920, height: 1080)
    print("   Resolution: \(resolution.width)x\(resolution.height)")
    
    // Class instance
    print("\n2. Class Instance:")
    let videoMode = VideoMode()
    videoMode.name = "HD"
    videoMode.frameRate = 30.0
    print("   VideoMode: \(videoMode.name ?? "unnamed"), \(videoMode.frameRate) fps")
    
    // Value type behavior
    print("\n3. Value Type Behavior (Structure):")
    var structA = Resolution(width: 100, height: 100)
    var structB = structA
    structB.width = 200
    print("   structA.width: \(structA.width)")
    print("   structB.width: \(structB.width)")
    
    // Reference type behavior
    print("\n4. Reference Type Behavior (Class):")
    var classA = VideoMode()
    classA.frameRate = 25.0
    var classB = classA
    classB.frameRate = 30.0
    print("   classA.frameRate: \(classA.frameRate)")
    print("   classB.frameRate: \(classB.frameRate)")
    
    // Identity operators
    print("\n5. Identity Operators:")
    if classA === classB {
        print("   classA and classB refer to the same instance")
    }
    
    let classC = VideoMode()
    if classA !== classC {
        print("   classA and classC refer to different instances")
    }
    
    // Memberwise initializer
    print("\n6. Memberwise Initializer:")
    let customResolution = Resolution(width: 800, height: 600)
    print("   Custom resolution: \(customResolution.width)x\(customResolution.height)")
    
    // Property access
    print("\n7. Property Access:")
    videoMode.resolution = customResolution
    print("   videoMode.resolution.width: \(videoMode.resolution.width)")
    
    print("\n=== End of Demonstration ===\n")
}

// Uncomment to run the demonstration
// demonstrateStructuresAndClasses()




