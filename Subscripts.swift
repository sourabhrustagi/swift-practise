//
//  Subscripts.swift
//  Swift Language Practice - Subscripts
//
//  This file contains examples demonstrating Swift subscripts, including
//  instance subscripts, type subscripts, and subscript overloading.
//

import Foundation

// MARK: - Introduction to Subscripts

// Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing
// the member elements of a collection, list, or sequence. You use subscripts to set and retrieve
// values by index without needing separate methods for setting and retrieval. For example, you
// access elements in an Array instance as someArray[index] and elements in a Dictionary instance
// as someDictionary[key].

// You can define multiple subscripts for a single type, and the appropriate subscript overload
// to use is selected based on the type of index value you pass to the subscript. Subscripts aren't
// limited to a single dimension, and you can define subscripts with multiple input parameters
// to suit your custom type's needs.

// MARK: - Subscript Syntax

// Subscripts enable you to query instances of a type by writing one or more values in square
// brackets after the instance name. Their syntax is similar to both instance method syntax and
// computed property syntax. You write subscript definitions with the subscript keyword, and
// specify one or more input parameters and a return type, in the same way as instance methods.
// Unlike instance methods, subscripts can be read-write or read-only. This behavior is communicated
// by a getter and setter in the same way as for computed properties

struct ReadWriteSubscript {
    var values: [Int] = []
    
    subscript(index: Int) -> Int {
        get {
            // Return an appropriate subscript value here
            return values[index]
        }
        set(newValue) {
            // Perform a suitable setting action here
            values[index] = newValue
        }
    }
}

// The type of newValue is the same as the return value of the subscript. As with computed properties,
// you can choose not to specify the setter's (newValue) parameter. A default parameter called
// newValue is provided to your setter if you don't provide one yourself

struct ReadWriteSubscriptShorthand {
    var values: [Int] = []
    
    subscript(index: Int) -> Int {
        get {
            return values[index]
        }
        set {
            // newValue is the default parameter name
            values[index] = newValue
        }
    }
}

// As with read-only computed properties, you can simplify the declaration of a read-only subscript
// by removing the get keyword and its braces

struct ReadOnlySubscript {
    var values: [Int] = []
    
    subscript(index: Int) -> Int {
        // Return an appropriate subscript value here
        return values[index]
    }
}

// Here's an example of a read-only subscript implementation, which defines a TimesTable structure
// to represent an n-times-table of integers

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
// Prints "six times three is 18"

// In this example, a new instance of TimesTable is created to represent the three-times-table.
// This is indicated by passing a value of 3 to the structure's initializer as the value to use
// for the instance's multiplier parameter.

// You can query the threeTimesTable instance by calling its subscript, as shown in the call to
// threeTimesTable[6]. This requests the sixth entry in the three-times-table, which returns a
// value of 18, or 3 times 6.

// Note: An n-times-table is based on a fixed mathematical rule. It isn't appropriate to set
// threeTimesTable[someIndex] to a new value, and so the subscript for TimesTable is defined as
// a read-only subscript.

// MARK: - Subscript Usage

// The exact meaning of "subscript" depends on the context in which it's used. Subscripts are
// typically used as a shortcut for accessing the member elements in a collection, list, or sequence.
// You are free to implement subscripts in the most appropriate way for your particular class or
// structure's functionality.

// For example, Swift's Dictionary type implements a subscript to set and retrieve the values stored
// in a Dictionary instance. You can set a value in a dictionary by providing a key of the dictionary's
// key type within subscript brackets, and assigning a value of the dictionary's value type to the
// subscript

var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2
print("Number of legs: \(numberOfLegs)")

// The example above defines a variable called numberOfLegs and initializes it with a dictionary
// literal containing three key-value pairs. The type of the numberOfLegs dictionary is inferred
// to be [String: Int]. After creating the dictionary, this example uses subscript assignment to
// add a String key of "bird" and an Int value of 2 to the dictionary.

// For more information about Dictionary subscripting, see Accessing and Modifying a Dictionary.

// Note: Swift's Dictionary type implements its key-value subscripting as a subscript that takes and
// returns an optional type. For the numberOfLegs dictionary above, the key-value subscript takes
// and returns a value of type Int?, or "optional int". The Dictionary type uses an optional subscript
// type to model the fact that not every key will have a value, and to give a way to delete a value
// for a key by assigning a nil value for that key.

// Example of dictionary subscript returning optional
if let legs = numberOfLegs["spider"] {
    print("Spider has \(legs) legs")
}

numberOfLegs["spider"] = nil  // Remove the key-value pair
print("After removing spider: \(numberOfLegs)")

// MARK: - Subscript Options

// Subscripts can take any number of input parameters, and these input parameters can be of any type.
// Subscripts can also return a value of any type.

// Like functions, subscripts can take a varying number of parameters and provide default values for
// their parameters, as discussed in Variadic Parameters and Default Parameter Values. However, unlike
// functions, subscripts can't use in-out parameters.

// A class or structure can provide as many subscript implementations as it needs, and the appropriate
// subscript to be used will be inferred based on the types of the value or values that are contained
// within the subscript brackets at the point that the subscript is used. This definition of multiple
// subscripts is known as subscript overloading.

// While it's most common for a subscript to take a single parameter, you can also define a subscript
// with multiple parameters if it's appropriate for your type. The following example defines a Matrix
// structure, which represents a two-dimensional matrix of Double values. The Matrix structure's
// subscript takes two integer parameters

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

// Matrix provides an initializer that takes two parameters called rows and columns, and creates an
// array that's large enough to store rows * columns values of type Double. Each position in the
// matrix is given an initial value of 0.0. To achieve this, the array's size, and an initial cell
// value of 0.0, are passed to an array initializer that creates and initializes a new array of the
// correct size. This initializer is described in more detail in Creating an Array with a Default Value.

// You can construct a new Matrix instance by passing an appropriate row and column count to its initializer

var matrix = Matrix(rows: 2, columns: 2)
print("Matrix created: \(matrix.rows)x\(matrix.columns)")

// The example above creates a new Matrix instance with two rows and two columns. The grid array for
// this Matrix instance is effectively a flattened version of the matrix, as read from top left to
// bottom right.

// Values in the matrix can be set by passing row and column values into the subscript, separated by a comma

matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

print("Matrix[0, 1] = \(matrix[0, 1])")
print("Matrix[1, 0] = \(matrix[1, 0])")

// These two statements call the subscript's setter to set a value of 1.5 in the top right position
// of the matrix (where row is 0 and column is 1), and 3.2 in the bottom left position (where row
// is 1 and column is 0).

// The Matrix subscript's getter and setter both contain an assertion to check that the subscript's
// row and column values are valid. To assist with these assertions, Matrix includes a convenience
// method called indexIsValid(row:column:), which checks whether the requested row and column are
// inside the bounds of the matrix

// An assertion is triggered if you try to access a subscript that's outside of the matrix bounds:
// let someValue = matrix[2, 2]
// This triggers an assert, because [2, 2] is outside of the matrix bounds.

// MARK: - Subscript Overloading

// You can define multiple subscripts for a single type. Swift will select the appropriate subscript
// based on the types of the parameters you pass. This is called subscript overloading

struct MultiSubscript {
    var intValues: [Int] = []
    var stringValues: [String: Int] = [:]
    
    // Subscript with Int index
    subscript(index: Int) -> Int {
        get {
            return intValues[index]
        }
        set {
            intValues[index] = newValue
        }
    }
    
    // Subscript with String key
    subscript(key: String) -> Int? {
        get {
            return stringValues[key]
        }
        set {
            stringValues[key] = newValue
        }
    }
    
    // Subscript with range
    subscript(range: Range<Int>) -> [Int] {
        return Array(intValues[range])
    }
}

var multiSubscript = MultiSubscript()
multiSubscript.intValues = [1, 2, 3, 4, 5]

// Use Int subscript
print("Value at index 2: \(multiSubscript[2])")

// Use String subscript
multiSubscript["first"] = 10
print("Value for key 'first': \(multiSubscript["first"] ?? 0)")

// Use Range subscript
let slice = multiSubscript[1..<4]
print("Slice from 1 to 3: \(slice)")

// MARK: - Subscript with Default Parameters

// Subscripts can have default parameter values, just like functions

struct FlexibleArray {
    private var values: [Int] = []
    
    subscript(index: Int, defaultValue: Int = 0) -> Int {
        get {
            guard index >= 0 && index < values.count else {
                return defaultValue
            }
            return values[index]
        }
        set {
            while values.count <= index {
                values.append(defaultValue)
            }
            values[index] = newValue
        }
    }
    
    mutating func append(_ value: Int) {
        values.append(value)
    }
}

var flexibleArray = FlexibleArray()
flexibleArray.append(1)
flexibleArray.append(2)
flexibleArray.append(3)

print("flexibleArray[1]: \(flexibleArray[1])")
print("flexibleArray[10]: \(flexibleArray[10])")  // Uses default value 0
print("flexibleArray[10, defaultValue: -1]: \(flexibleArray[10, defaultValue: -1])")  // Uses custom default

// MARK: - Type Subscripts

// Instance subscripts, as described above, are subscripts that you call on an instance of a particular
// type. You can also define subscripts that are called on the type itself. This kind of subscript is
// called a type subscript. You indicate a type subscript by writing the static keyword before the
// subscript keyword. Classes can use the class keyword instead, to allow subclasses to override the
// superclass's implementation of that subscript. The example below shows how you define and call a
// type subscript

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}

let mars = Planet[4]
print("Planet[4] = \(mars)")

// MARK: - Type Subscripts in Structures and Classes

// Type subscripts can also be defined in structures and classes

struct MathConstants {
    static subscript(index: Int) -> Double {
        switch index {
        case 0:
            return 3.14159  // π
        case 1:
            return 2.71828  // e
        case 2:
            return 1.41421  // √2
        default:
            return 0.0
        }
    }
}

print("π = \(MathConstants[0])")
print("e = \(MathConstants[1])")
print("√2 = \(MathConstants[2])")

// Example with class and class keyword for overrideable type subscripts

class BaseClass {
    class subscript(index: Int) -> String {
        return "BaseClass[\(index)]"
    }
}

class SubClass: BaseClass {
    override class subscript(index: Int) -> String {
        return "SubClass[\(index)]"
    }
}

print("BaseClass[1] = \(BaseClass[1])")
print("SubClass[1] = \(SubClass[1])")

// MARK: - Practical Examples

// MARK: - Custom Array-like Structure

struct CustomArray<T> {
    private var elements: [T] = []
    
    mutating func append(_ element: T) {
        elements.append(element)
    }
    
    subscript(index: Int) -> T {
        get {
            return elements[index]
        }
        set {
            elements[index] = newValue
        }
    }
    
    subscript(safe index: Int) -> T? {
        guard index >= 0 && index < elements.count else {
            return nil
        }
        return elements[index]
    }
}

var customArray = CustomArray<String>()
customArray.append("First")
customArray.append("Second")
customArray.append("Third")

print("customArray[0]: \(customArray[0])")
print("customArray[safe: 10]: \(customArray[safe: 10] ?? "nil")")

// MARK: - Grid Structure with Multiple Subscripts

struct Grid {
    private var cells: [[Int]]
    let rows: Int
    let columns: Int
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.cells = Array(repeating: Array(repeating: 0, count: columns), count: rows)
    }
    
    // Subscript with row and column
    subscript(row: Int, column: Int) -> Int {
        get {
            return cells[row][column]
        }
        set {
            cells[row][column] = newValue
        }
    }
    
    // Subscript with single index (row-major order)
    subscript(index: Int) -> Int {
        get {
            let row = index / columns
            let column = index % columns
            return cells[row][column]
        }
        set {
            let row = index / columns
            let column = index % columns
            cells[row][column] = newValue
        }
    }
}

var grid = Grid(rows: 3, columns: 3)
grid[0, 0] = 1
grid[0, 1] = 2
grid[1, 0] = 3
grid[1, 1] = 4

print("Grid[0, 0] = \(grid[0, 0])")
print("Grid[1] = \(grid[1])")  // Using single index (row-major)

// MARK: - Example Function Demonstrating All Subscript Concepts

func demonstrateSubscripts() {
    print("\n=== Demonstrating Swift Subscripts ===\n")
    
    // Basic read-only subscript
    print("1. Read-Only Subscript (TimesTable):")
    let timesTable = TimesTable(multiplier: 5)
    print("   5 times 7 = \(timesTable[7])")
    
    // Read-write subscript
    print("\n2. Read-Write Subscript:")
    var readWrite = ReadWriteSubscript()
    readWrite.values = [10, 20, 30]
    print("   readWrite[1] = \(readWrite[1])")
    readWrite[1] = 25
    print("   readWrite[1] after change = \(readWrite[1])")
    
    // Dictionary subscript
    print("\n3. Dictionary Subscript:")
    var dict = ["a": 1, "b": 2, "c": 3]
    print("   dict[\"b\"] = \(dict["b"] ?? 0)")
    dict["d"] = 4
    print("   After adding 'd': \(dict)")
    
    // Multi-dimensional subscript
    print("\n4. Multi-Dimensional Subscript (Matrix):")
    var matrix = Matrix(rows: 3, columns: 3)
    matrix[0, 0] = 1.0
    matrix[0, 1] = 2.0
    matrix[1, 0] = 3.0
    matrix[1, 1] = 4.0
    print("   matrix[0, 0] = \(matrix[0, 0])")
    print("   matrix[1, 1] = \(matrix[1, 1])")
    
    // Subscript overloading
    print("\n5. Subscript Overloading:")
    var multi = MultiSubscript()
    multi.intValues = [1, 2, 3, 4, 5]
    print("   multi[2] = \(multi[2])")
    multi["key"] = 100
    print("   multi[\"key\"] = \(multi["key"] ?? 0)")
    print("   multi[1..<4] = \(multi[1..<4])")
    
    // Type subscript
    print("\n6. Type Subscript:")
    let planet = Planet[3]
    print("   Planet[3] = \(planet)")
    print("   MathConstants[0] = \(MathConstants[0])")
    
    // Custom array with safe subscript
    print("\n7. Safe Subscript:")
    var custom = CustomArray<Int>()
    custom.append(10)
    custom.append(20)
    print("   custom[0] = \(custom[0])")
    print("   custom[safe: 5] = \(custom[safe: 5] ?? -1)")
    
    print("\n=== End of Demonstration ===\n")
}

// Uncomment to run the demonstration
// demonstrateSubscripts()




