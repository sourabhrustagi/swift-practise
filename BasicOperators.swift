//
//  BasicOperators.swift
//  Swift Language Practice - Basic Operators
//
//  This file contains examples demonstrating Swift's basic operators
//  including assignment, arithmetic, comparison, logical, and range operators.
//

import Foundation

// MARK: - Terminology

// Operators are unary, binary, or ternary:
// - Unary operators operate on a single target (such as -a)
// - Binary operators operate on two targets (such as 2 + 3)
// - Ternary operators operate on three targets (a ? b : c)

// MARK: - Assignment Operator

// The assignment operator (a = b) initializes or updates the value of a with the value of b
let b = 10
var a = 5
a = b
// a is now equal to 10
print("Assignment: a = \(a)")

// If the right side of the assignment is a tuple with multiple values,
// its elements can be decomposed into multiple constants or variables at once
let (x, y) = (1, 2)
// x is equal to 1, and y is equal to 2
print("Tuple assignment: x = \(x), y = \(y)")

// Unlike the assignment operator in C and Objective-C, the assignment operator in Swift
// doesn't itself return a value. The following statement isn't valid:
// if x = y { } // This would cause a compile-time error

// MARK: - Arithmetic Operators

// Swift supports the four standard arithmetic operators for all number types:
// Addition (+), Subtraction (-), Multiplication (*), Division (/)

let addition = 1 + 2       // equals 3
let subtraction = 5 - 3    // equals 2
let multiplication = 2 * 3 // equals 6
let division = 10.0 / 2.5  // equals 4.0

print("Arithmetic operators:")
print("  1 + 2 = \(addition)")
print("  5 - 3 = \(subtraction)")
print("  2 * 3 = \(multiplication)")
print("  10.0 / 2.5 = \(division)")

// The addition operator is also supported for String concatenation
let greeting = "hello, " + "world"  // equals "hello, world"
print("String concatenation: \(greeting)")

// MARK: - Remainder Operator

// The remainder operator (a % b) works out how many multiples of b will fit inside a
// and returns the value that's left over (known as the remainder)

let remainder1 = 9 % 4    // equals 1
print("Remainder: 9 % 4 = \(remainder1)")

// To determine the answer for a % b, the % operator calculates:
// a = (b x some multiplier) + remainder
// 9 = (4 x 2) + 1

// The same method is applied when calculating the remainder for a negative value of a
let remainder2 = -9 % 4   // equals -1
print("Remainder with negative: -9 % 4 = \(remainder2)")

// The sign of b is ignored for negative values of b
let remainder3 = 9 % -4   // equals 1 (same as 9 % 4)
print("Remainder with negative divisor: 9 % -4 = \(remainder3)")

// MARK: - Unary Minus Operator

// The sign of a numeric value can be toggled using a prefixed -, known as the unary minus operator
let three = 3
let minusThree = -three       // minusThree equals -3
let plusThree = -minusThree   // plusThree equals 3, or "minus minus three"

print("Unary minus operator:")
print("  three = \(three)")
print("  minusThree = \(minusThree)")
print("  plusThree = \(plusThree)")

// The unary minus operator (-) is prepended directly before the value it operates on,
// without any white space

// MARK: - Unary Plus Operator

// The unary plus operator (+) simply returns the value it operates on, without any change
let minusSix = -6
let alsoMinusSix = +minusSix  // alsoMinusSix equals -6

print("Unary plus operator:")
print("  minusSix = \(minusSix)")
print("  alsoMinusSix = \(alsoMinusSix)")

// Although the unary plus operator doesn't actually do anything, you can use it to provide
// symmetry in your code for positive numbers when also using the unary minus operator

// MARK: - Compound Assignment Operators

// Swift provides compound assignment operators that combine assignment (=) with another operation
var compoundA = 1
compoundA += 2
// compoundA is now equal to 3
print("Compound assignment: compoundA += 2 results in \(compoundA)")

// The expression a += 2 is shorthand for a = a + 2
var compoundB = 5
compoundB -= 3  // compoundB = compoundB - 3
print("Compound assignment: compoundB -= 3 results in \(compoundB)")

var compoundC = 4
compoundC *= 2  // compoundC = compoundC * 2
print("Compound assignment: compoundC *= 2 results in \(compoundC)")

var compoundD = 10.0
compoundD /= 2.5  // compoundD = compoundD / 2.5
print("Compound assignment: compoundD /= 2.5 results in \(compoundD)")

// Note: The compound assignment operators don't return a value.
// For example, you can't write let b = a += 2

// MARK: - Comparison Operators

// Swift supports the following comparison operators:
// Equal to (a == b)
// Not equal to (a != b)
// Greater than (a > b)
// Less than (a < b)
// Greater than or equal to (a >= b)
// Less than or equal to (a <= b)

print("Comparison operators:")
print("  1 == 1: \(1 == 1)")   // true because 1 is equal to 1
print("  2 != 1: \(2 != 1)")   // true because 2 isn't equal to 1
print("  2 > 1: \(2 > 1)")     // true because 2 is greater than 1
print("  1 < 2: \(1 < 2)")     // true because 1 is less than 2
print("  1 >= 1: \(1 >= 1)")   // true because 1 is greater than or equal to 1
print("  2 <= 1: \(2 <= 1)")   // false because 2 isn't less than or equal to 1

// Comparison operators are often used in conditional statements
let name = "world"
if name == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(name), but I don't recognize you")
}
// Prints "hello, world", because name is indeed equal to "world"

// MARK: - Tuple Comparison

// You can compare two tuples if they have the same type and the same number of values.
// Tuples are compared from left to right, one value at a time, until the comparison
// finds two values that aren't equal.

let tuple1 = (1, "zebra")
let tuple2 = (2, "apple")
let tupleComparison1 = tuple1 < tuple2
// true because 1 is less than 2; "zebra" and "apple" aren't compared
print("Tuple comparison: (1, \"zebra\") < (2, \"apple\") = \(tupleComparison1)")

let tuple3 = (3, "apple")
let tuple4 = (3, "bird")
let tupleComparison2 = tuple3 < tuple4
// true because 3 is equal to 3, and "apple" is less than "bird"
print("Tuple comparison: (3, \"apple\") < (3, \"bird\") = \(tupleComparison2)")

let tuple5 = (4, "dog")
let tuple6 = (4, "dog")
let tupleComparison3 = tuple5 == tuple6
// true because 4 is equal to 4, and "dog" is equal to "dog"
print("Tuple comparison: (4, \"dog\") == (4, \"dog\") = \(tupleComparison3)")

// Tuples can be compared with a given operator only if the operator can be applied
// to each value in the respective tuples
let tuple7 = ("blue", -1)
let tuple8 = ("purple", 1)
let tupleComparison4 = tuple7 < tuple8
// OK: Evaluates to true
print("Tuple comparison: (\"blue\", -1) < (\"purple\", 1) = \(tupleComparison4)")

// Note: The Swift standard library includes tuple comparison operators for tuples
// with fewer than seven elements. To compare tuples with seven or more elements,
// you must implement the comparison operators yourself.

// MARK: - Ternary Conditional Operator

// The ternary conditional operator is a special operator with three parts,
// which takes the form question ? answer1 : answer2

// Example: calculating the height for a table row
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)
// rowHeight is equal to 90
print("Ternary operator: rowHeight = \(rowHeight)")

// The example above is shorthand for:
let contentHeight2 = 40
let hasHeader2 = true
let rowHeight2: Int
if hasHeader2 {
    rowHeight2 = contentHeight2 + 50
} else {
    rowHeight2 = contentHeight2 + 20
}
// rowHeight2 is equal to 90
print("Equivalent if-else: rowHeight2 = \(rowHeight2)")

// Another example
let score = 85
let grade = score >= 90 ? "A" : (score >= 80 ? "B" : "C")
print("Ternary operator: score \(score) = grade \(grade)")

// MARK: - Nil-Coalescing Operator

// The nil-coalescing operator (a ?? b) unwraps an optional a if it contains a value,
// or returns a default value b if a is nil

let defaultColorName = "red"
var userDefinedColorName: String?   // defaults to nil

var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName is nil, so colorNameToUse is set to the default of "red"
print("Nil-coalescing: colorNameToUse = \(colorNameToUse)")

// If you assign a non-nil value to userDefinedColorName and perform the nil-coalescing
// operator check again, the value wrapped inside userDefinedColorName is used instead
userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName isn't nil, so colorNameToUse is set to "green"
print("Nil-coalescing with value: colorNameToUse = \(colorNameToUse)")

// The nil-coalescing operator is shorthand for: a != nil ? a! : b

// Note: If the value of a is non-nil, the value of b isn't evaluated.
// This is known as short-circuit evaluation.

// MARK: - Range Operators

// Swift includes several range operators, which are shortcuts for expressing a range of values

// MARK: - Closed Range Operator

// The closed range operator (a...b) defines a range that runs from a to b,
// and includes the values a and b. The value of a must not be greater than b.

print("Closed range operator (1...5):")
for index in 1...5 {
    print("  \(index) times 5 is \(index * 5)")
}
// 1 times 5 is 5
// 2 times 5 is 10
// 3 times 5 is 15
// 4 times 5 is 20
// 5 times 5 is 25

// MARK: - Half-Open Range Operator

// The half-open range operator (a..<b) defines a range that runs from a to b,
// but doesn't include b. It's said to be half-open because it contains its first value,
// but not its final value.

let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
print("Half-open range operator (0..<count):")
for i in 0..<count {
    print("  Person \(i + 1) is called \(names[i])")
}
// Person 1 is called Anna
// Person 2 is called Alex
// Person 3 is called Brian
// Person 4 is called Jack

// Note that the array contains four items, but 0..<count only counts as far as 3
// (the index of the last item in the array), because it's a half-open range.

// MARK: - One-Sided Ranges

// The closed range operator has an alternative form for ranges that continue as far as
// possible in one direction

print("One-sided range (names[2...]):")
for name in names[2...] {
    print("  \(name)")
}
// Brian
// Jack

print("One-sided range (names[...2]):")
for name in names[...2] {
    print("  \(name)")
}
// Anna
// Alex
// Brian

// The half-open range operator also has a one-sided form
print("One-sided half-open range (names[..<2]):")
for name in names[..<2] {
    print("  \(name)")
}
// Anna
// Alex

// One-sided ranges can be used in other contexts, not just in subscripts
let range = ...5
print("One-sided range contains:")
print("  range.contains(7): \(range.contains(7))")   // false
print("  range.contains(4): \(range.contains(4))")   // true
print("  range.contains(-1): \(range.contains(-1))") // true

// MARK: - Logical Operators

// Logical operators modify or combine the Boolean logic values true and false.
// Swift supports the three standard logical operators found in C-based languages:
// Logical NOT (!a)
// Logical AND (a && b)
// Logical OR (a || b)

// MARK: - Logical NOT Operator

// The logical NOT operator (!a) inverts a Boolean value so that true becomes false,
// and false becomes true

let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED")
}
// Prints "ACCESS DENIED"

// The phrase if !allowedEntry can be read as "if not allowed entry."
// The subsequent line is only executed if "not allowed entry" is true;
// that is, if allowedEntry is false.

print("Logical NOT:")
print("  !true = \(!true)")
print("  !false = \(!false)")

// MARK: - Logical AND Operator

// The logical AND operator (a && b) creates logical expressions where both values
// must be true for the overall expression to also be true

let enteredDoorCode = true
let passedRetinaScan = false

if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "ACCESS DENIED"

// If either value is false, the overall expression will also be false.
// In fact, if the first value is false, the second value won't even be evaluated,
// because it can't possibly make the overall expression equate to true.
// This is known as short-circuit evaluation.

print("Logical AND:")
print("  true && true = \(true && true)")
print("  true && false = \(true && false)")
print("  false && true = \(false && true)")
print("  false && false = \(false && false)")

// MARK: - Logical OR Operator

// The logical OR operator (a || b) is an infix operator made from two adjacent pipe characters.
// You use it to create logical expressions in which only one of the two values has to be
// true for the overall expression to be true

let hasDoorKey = false
let knowsOverridePassword = true

if hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"

// Like the Logical AND operator above, the Logical OR operator uses short-circuit evaluation.
// If the left side of a Logical OR expression is true, the right side isn't evaluated,
// because it can't change the outcome of the overall expression.

print("Logical OR:")
print("  true || true = \(true || true)")
print("  true || false = \(true || false)")
print("  false || true = \(false || true)")
print("  false || false = \(false || false)")

// MARK: - Combining Logical Operators

// You can combine multiple logical operators to create longer compound expressions

let enteredDoorCode2 = true
let passedRetinaScan2 = false
let hasDoorKey2 = false
let knowsOverridePassword2 = true

if enteredDoorCode2 && passedRetinaScan2 || hasDoorKey2 || knowsOverridePassword2 {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"

// This example uses multiple && and || operators to create a longer compound expression.
// However, the && and || operators still operate on only two values, so this is actually
// three smaller expressions chained together.

// Note: The Swift logical operators && and || are left-associative, meaning that compound
// expressions with multiple logical operators evaluate the leftmost subexpression first.

// MARK: - Explicit Parentheses

// It's sometimes useful to include parentheses when they're not strictly needed,
// to make the intention of a complex expression easier to read

if (enteredDoorCode2 && passedRetinaScan2) || hasDoorKey2 || knowsOverridePassword2 {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"

// The parentheses make it clear that the first two values are considered as part of
// a separate possible state in the overall logic. The output of the compound expression
// doesn't change, but the overall intention is clearer to the reader.
// Readability is always preferred over brevity; use parentheses where they help to
// make your intentions clear.

// MARK: - Example Function Demonstrating All Operators

func demonstrateBasicOperators() {
    print("\n=== Demonstrating Swift Basic Operators ===\n")
    
    // Assignment
    print("1. Assignment Operator:")
    var value = 10
    let (first, second) = (5, 15)
    print("   value = \(value)")
    print("   Tuple assignment: first = \(first), second = \(second)")
    
    // Arithmetic
    print("\n2. Arithmetic Operators:")
    print("   10 + 5 = \(10 + 5)")
    print("   10 - 5 = \(10 - 5)")
    print("   10 * 5 = \(10 * 5)")
    print("   10.0 / 3.0 = \(10.0 / 3.0)")
    print("   \"Hello\" + \" World\" = \"\("Hello" + " World")\"")
    
    // Remainder
    print("\n3. Remainder Operator:")
    print("   9 % 4 = \(9 % 4)")
    print("   -9 % 4 = \(-9 % 4)")
    
    // Unary
    print("\n4. Unary Operators:")
    let num = 5
    print("   +\(num) = \(+num)")
    print("   -\(num) = \(-num)")
    
    // Compound Assignment
    print("\n5. Compound Assignment Operators:")
    var comp = 10
    comp += 5
    print("   comp += 5 results in \(comp)")
    comp -= 3
    print("   comp -= 3 results in \(comp)")
    comp *= 2
    print("   comp *= 2 results in \(comp)")
    comp /= 4
    print("   comp /= 4 results in \(comp)")
    
    // Comparison
    print("\n6. Comparison Operators:")
    print("   5 == 5: \(5 == 5)")
    print("   5 != 3: \(5 != 3)")
    print("   5 > 3: \(5 > 3)")
    print("   3 < 5: \(3 < 5)")
    print("   5 >= 5: \(5 >= 5)")
    print("   3 <= 5: \(3 <= 5)")
    
    // Ternary
    print("\n7. Ternary Conditional Operator:")
    let age = 20
    let canVote = age >= 18 ? "Yes" : "No"
    print("   Can vote at age \(age)? \(canVote)")
    
    // Nil-Coalescing
    print("\n8. Nil-Coalescing Operator:")
    let optionalValue: String? = nil
    let result = optionalValue ?? "Default"
    print("   nil ?? \"Default\" = \(result)")
    
    // Range
    print("\n9. Range Operators:")
    print("   Closed range (1...3):")
    for i in 1...3 {
        print("     \(i)")
    }
    print("   Half-open range (1..<3):")
    for i in 1..<3 {
        print("     \(i)")
    }
    
    // Logical
    print("\n10. Logical Operators:")
    print("    !true = \(!true)")
    print("    true && false = \(true && false)")
    print("    true || false = \(true || false)")
    
    print("\n=== End of Demonstration ===\n")
}

// Uncomment to run the demonstration
// demonstrateBasicOperators()





