//
//  Statements.swift
//  Swift Language Practice - Statements
//
//  This file contains examples demonstrating Swift statements, including loop statements,
//  branch statements, control transfer statements, and compiler control statements.
//

import Foundation

// MARK: - Introduction to Statements

// In Swift, there are three kinds of statements: simple statements, compiler control statements,
// and control flow statements. Simple statements are the most common and consist of either an
// expression or a declaration. Compiler control statements allow the program to change aspects
// of the compiler's behavior and include a conditional compilation block and a line control
// statement.

// Control flow statements are used to control the flow of execution in a program. There are
// several types of control flow statements in Swift, including loop statements, branch statements,
// and control transfer statements. Loop statements allow a block of code to be executed repeatedly,
// branch statements allow a certain block of code to be executed only when certain conditions
// are met, and control transfer statements provide a way to alter the order in which code is
// executed.

// A semicolon (;) can optionally appear after any statement and is used to separate multiple
// statements if they appear on the same line.

let statement1 = 10; let statement2 = 20  // Multiple statements on one line

// MARK: - Loop Statements

// Loop statements allow a block of code to be executed repeatedly, depending on the conditions
// specified in the loop. Swift has three loop statements: a for-in statement, a while statement,
// and a repeat-while statement.

// MARK: - For-In Statement

// A for-in statement allows a block of code to be executed once for each item in a collection
// (or any type) that conforms to the Sequence protocol.

// A for-in statement has the following form:
// for <#item#> in <#collection#> {
//    <#statements#>
// }

// Example: Iterating over an array
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}

// Example: Iterating over a range
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

// Example: Iterating over a dictionary
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}

// Example: Using where clause
for number in 1...10 where number % 2 == 0 {
    print("Even number: \(number)")
}

// Example: Using case pattern matching
let someNumbers: [Int?] = [1, 2, nil, 4, 5, nil]
for case let number? in someNumbers {
    print("Number: \(number)")
}

// Example: Iterating with stride
for tickMark in stride(from: 0, to: 60, by: 5) {
    print(tickMark)
}

// MARK: - While Statement

// A while statement allows a block of code to be executed repeatedly, as long as a condition
// remains true.

// A while statement has the following form:
// while <#condition#> {
//    <#statements#>
// }

// A while statement is executed as follows:
// 1. The condition is evaluated.
// 2. If true, execution continues to step 2. If false, the program is finished executing the
//    while statement.
// 3. The program executes the statements, and execution returns to step 1.

var count = 0
while count < 5 {
    print("Count is \(count)")
    count += 1
}

// Example: While with optional binding
var optionalString: String? = "Hello"
while let string = optionalString {
    print(string)
    optionalString = nil  // Exit condition
}

// Example: While with multiple conditions
var x = 0
var y = 10
while x < 5, y > 5 {
    x += 1
    y -= 1
    print("x: \(x), y: \(y)")
}

// Because the value of the condition is evaluated before the statements are executed, the
// statements in a while statement can be executed zero or more times.

// MARK: - Repeat-While Statement

// A repeat-while statement allows a block of code to be executed one or more times, as long as
// a condition remains true.

// A repeat-while statement has the following form:
// repeat {
//    <#statements#>
// } while <#condition#>

// A repeat-while statement is executed as follows:
// 1. The program executes the statements, and execution continues to step 2.
// 2. The condition is evaluated.
// 3. If true, execution returns to step 1. If false, the program is finished executing the
//    repeat-while statement.

var counter = 0
repeat {
    print("Counter is \(counter)")
    counter += 1
} while counter < 5

// Because the value of the condition is evaluated after the statements are executed, the
// statements in a repeat-while statement are executed at least once.

// Example: Repeat-while with game loop
var gameOver = false
var score = 0
repeat {
    score += 10
    print("Score: \(score)")
    if score >= 50 {
        gameOver = true
    }
} while !gameOver

// MARK: - Branch Statements

// Branch statements allow the program to execute certain parts of code depending on the value of
// one or more conditions. The values of the conditions specified in a branch statement control
// how the program branches and, therefore, what block of code is executed. Swift has three
// branch statements: an if statement, a guard statement, and a switch statement.

// MARK: - If Statement

// An if statement is used for executing code based on the evaluation of one or more conditions.

// The first form allows code to be executed only when a condition is true:
// if <#condition#> {
//    <#statements#>
// }

let temperature = 25
if temperature > 20 {
    print("It's warm outside")
}

// The second form of an if statement provides an additional else clause:
// if <#condition#> {
//    <#statements to execute if condition is true#>
// } else {
//    <#statements to execute if condition is false#>
// }

if temperature > 30 {
    print("It's hot outside")
} else {
    print("It's not hot outside")
}

// The else clause of an if statement can contain another if statement to test more than one
// condition:
// if <#condition 1#> {
//    <#statements to execute if condition 1 is true#>
// } else if <#condition 2#> {
//    <#statements to execute if condition 2 is true#>
// } else {
//    <#statements to execute if both conditions are false#>
// }

if temperature > 30 {
    print("It's very hot")
} else if temperature > 20 {
    print("It's warm")
} else if temperature > 10 {
    print("It's cool")
} else {
    print("It's cold")
}

// Example: If with optional binding
let possibleNumber = "123"
if let actualNumber = Int(possibleNumber) {
    print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("The string \"\(possibleNumber)\" couldn't be converted to an integer")
}

// Example: If with multiple optional bindings
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber {
    print("\(firstNumber) < \(secondNumber)")
}

// MARK: - Guard Statement

// A guard statement is used to transfer program control out of a scope if one or more conditions
// aren't met.

// A guard statement has the following form:
// guard <#condition#> else {
//    <#statements#>
// }

func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return  // Must exit the scope
    }
    
    print("Hello \(name)!")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    
    print("I hope the weather is nice in \(location).")
}

greet(person: ["name": "John"])
greet(person: ["name": "Jane", "location": "Cupertino"])

// Any constants or variables assigned a value from an optional binding declaration in a guard
// statement condition can be used for the rest of the guard statement's enclosing scope.

func processNumber(_ number: Int?) {
    guard let num = number, num > 0 else {
        print("Invalid number")
        return
    }
    
    // num is available here
    print("Processing number: \(num)")
}

// The else clause of a guard statement is required, and must either call a function with the
// Never return type or transfer program control outside the guard statement's enclosing scope
// using one of the following statements: return, break, continue, throw

func processArray(_ items: [Int]) {
    for item in items {
        guard item > 0 else {
            continue  // Transfer control
        }
        print("Processing: \(item)")
    }
}

// MARK: - Switch Statement

// A switch statement allows certain blocks of code to be executed depending on the value of a
// control expression.

// A switch statement has the following form:
// switch <#control expression#> {
// case <#pattern 1#>:
//     <#statements#>
// case <#pattern 2#> where <#condition#>:
//     <#statements#>
// case <#pattern 3#> where <#condition#>,
//     <#pattern 4#> where <#condition#>:
//     <#statements#>
// default:
//     <#statements#>
// }

let someCharacter: Character = "z"
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
default:
    print("\(someCharacter) isn't a vowel or a consonant")
}

// Example: Switch with interval matching
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")

// Example: Switch with tuples
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0, 0) is at the origin")
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}

// Example: Switch with value bindings
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}

// Example: Switch with where clause
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}

// Example: Switch with compound cases
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}

// Switch Statements Must Be Exhaustive
// In Swift, every possible value of the control expression's type must match the value of at
// least one pattern of a case. When this simply isn't feasible (for example, when the control
// expression's type is Int), you can include a default case to satisfy the requirement.

// Example: Switching over future enumeration cases
// A nonfrozen enumeration is a special kind of enumeration that may gain new enumeration cases
// in the future. When switching over a nonfrozen enumeration value, you always need to include
// a default case, even if every case of the enumeration already has a corresponding switch case.

let representation: Mirror.AncestorRepresentation = .generated
switch representation {
case .customized:
    print("Use the nearest ancestor's implementation.")
case .generated:
    print("Generate a default mirror for all ancestor classes.")
case .suppressed:
    print("Suppress the representation of all ancestor classes.")
@unknown default:
    print("Use a representation that was unknown when this code was compiled.")
}

// Execution Does Not Fall Through Cases Implicitly
// After the code within a matched case has finished executing, the program exits from the switch
// statement. Program execution doesn't continue or "fall through" to the next case or default case.

// MARK: - Labeled Statement

// You can prefix a loop statement, an if statement, a switch statement, or a do statement with
// a statement label, which consists of the name of the label followed immediately by a colon (:).

// Example: Labeled loop
outerLoop: for i in 1...3 {
    innerLoop: for j in 1...3 {
        if j == 2 {
            continue outerLoop  // Continue the outer loop
        }
        print("i: \(i), j: \(j)")
    }
}

// Example: Labeled while loop
gameLoop: while true {
    var diceRoll = Int.random(in: 1...6)
    switch diceRoll {
    case 1, 2, 3:
        continue gameLoop
    case 4, 5, 6:
        print("Rolled a \(diceRoll)")
        break gameLoop
    default:
        break gameLoop
    }
}

// MARK: - Control Transfer Statements

// Control transfer statements can change the order in which code in your program is executed by
// unconditionally transferring program control from one piece of code to another. Swift has five
// control transfer statements: a break statement, a continue statement, a fallthrough statement,
// a return statement, and a throw statement.

// MARK: - Break Statement

// A break statement ends program execution of a loop, an if statement, or a switch statement.

// Example: Break in a loop
for i in 1...10 {
    if i == 5 {
        break  // Exit the loop
    }
    print(i)
}

// Example: Break with label
outerLoop2: for i in 1...3 {
    for j in 1...3 {
        if i == 2 && j == 2 {
            break outerLoop2  // Break out of the outer loop
        }
        print("i: \(i), j: \(j)")
    }
}

// Example: Break in switch
let numberSymbol: Character = "三"
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break  // Do nothing if no match
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value couldn't be found for \(numberSymbol).")
}

// MARK: - Continue Statement

// A continue statement ends program execution of the current iteration of a loop statement but
// doesn't stop execution of the loop statement.

// Example: Continue in a loop
for i in 1...10 {
    if i % 2 == 0 {
        continue  // Skip even numbers
    }
    print(i)  // Only prints odd numbers
}

// Example: Continue with label
outerLoop3: for i in 1...3 {
    for j in 1...3 {
        if j == 2 {
            continue outerLoop3  // Continue the outer loop
        }
        print("i: \(i), j: \(j)")
    }
}

// In a for statement, the increment expression is still evaluated after the continue statement
// is executed, because the increment expression is evaluated after the execution of the loop's
// body.

// MARK: - Fallthrough Statement

// A fallthrough statement consists of the fallthrough keyword and occurs only in a case block
// of a switch statement. A fallthrough statement causes program execution to continue from one
// case in a switch statement to the next case.

let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)
// Prints "The number 5 is a prime number, and also an integer."

// A fallthrough statement can appear anywhere inside a switch statement, not just as the last
// statement of a case block, but it can't be used in the final case block. It also can't
// transfer control into a case block whose pattern contains value binding patterns.

// MARK: - Return Statement

// A return statement occurs in the body of a function or method definition and causes program
// execution to return to the calling function or method.

// Example: Return with value
func greet(name: String) -> String {
    return "Hello, \(name)!"
}

let greeting = greet(name: "Swift")
print(greeting)

// Example: Return without value
func printAndReturn() {
    print("This function returns nothing")
    return  // Optional, but explicit
}

// Example: Early return
func processValue(_ value: Int?) -> String {
    guard let val = value else {
        return "No value"  // Early return
    }
    
    if val < 0 {
        return "Negative value"
    }
    
    return "Value is \(val)"
}

// When a return statement is followed by an expression, the value of the expression is returned
// to the calling function or method. If the value of the expression doesn't match the value of
// the return type declared in the function or method declaration, the expression's value is
// converted to the return type before it's returned to the calling function or method.

// MARK: - Throw Statement

// A throw statement occurs in the body of a throwing function or method, or in the body of a
// closure expression whose type is marked with the throws keyword.

// A throw statement consists of the throw keyword followed by an expression, as shown below:
// throw <#expression#>

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

// MARK: - Defer Statement

// A defer statement is used for executing code just before transferring program control outside
// of the scope that the defer statement appears in.

// A defer statement has the following form:
// defer {
//     <#statements#>
// }

// The statements within the defer statement are executed no matter how program control is
// transferred. This means that a defer statement can be used, for example, to perform manual
// resource management such as closing file descriptors, and to perform actions that need to
// happen even if an error is thrown.

func f(x: Int) {
    defer { print("First defer") }
    
    if x < 10 {
        defer { print("Second defer") }
        print("End of if")
    }
    
    print("End of function")
}

f(x: 5)
// Prints "End of if".
// Prints "Second defer".
// Prints "End of function".
// Prints "First defer".

// In the code above, the defer in the if statement executes before the defer declared in the
// function f because the scope of the if statement ends before the scope of the function.

// If multiple defer statements appear in the same scope, the order they appear is the reverse
// of the order they're executed. Executing the last defer statement in a given scope first
// means that statements inside that last defer statement can refer to resources that will be
// cleaned up by other defer statements.

func f2() {
    defer { print("First defer") }
    defer { print("Second defer") }
    print("End of function")
}

f2()
// Prints "End of function".
// Prints "Second defer".
// Prints "First defer".

// Example: Defer for cleanup
func processFile(filename: String) throws {
    print("Opening file: \(filename)")
    defer {
        print("Closing file: \(filename)")
    }
    
    print("Processing file...")
    // File processing code would go here
}

// MARK: - Do Statement

// The do statement is used to introduce a new scope and can optionally contain one or more catch
// clauses, which contain patterns that match against defined error conditions.

// A do statement has the following form:
// do {
//     try <#expression#>
//     <#statements#>
// } catch <#pattern 1#> {
//     <#statements#>
// } catch <#pattern 2#> where <#condition#> {
//     <#statements#>
// } catch <#pattern 3#>, <#pattern 4#> where <#condition#> {
//     <#statements#>
// } catch {
//     <#statements#>
// }

let vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8

do {
    try vendingMachine.vend(itemNamed: "Candy Bar")
    // Enjoy delicious snack
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}

// Example: Do statement with typed throws
enum CustomError: Error {
    case error1
    case error2
}

do throws(CustomError) {
    throw CustomError.error1
} catch CustomError.error1 {
    print("Caught error1")
} catch CustomError.error2 {
    print("Caught error2")
} catch {
    print("Unexpected error")
}

// A do statement in Swift is similar to curly braces ({}) in C used to delimit a code block,
// and doesn't incur a performance cost at runtime.

// Example: Do statement for scope
do {
    let x = 10
    let y = 20
    print("x: \(x), y: \(y)")
}
// x and y are not accessible here

// MARK: - Compiler Control Statements

// Compiler control statements allow the program to change aspects of the compiler's behavior.
// Swift has three compiler control statements: a conditional compilation block, a line control
// statement, and a compile-time diagnostic statement.

// MARK: - Conditional Compilation Block

// A conditional compilation block allows code to be conditionally compiled depending on the value
// of one or more compilation conditions.

// Every conditional compilation block begins with the #if compilation directive and ends with
// the #endif compilation directive. A simple conditional compilation block has the following form:
// #if <#compilation condition#>
//     <#statements#>
// #endif

#if os(macOS)
    print("Running on macOS")
#elseif os(iOS)
    print("Running on iOS")
#else
    print("Running on another platform")
#endif

// Example: Platform conditions
#if os(macOS) || os(iOS)
    print("Apple platform")
#endif

#if arch(x86_64)
    print("64-bit architecture")
#endif

#if swift(>=5.0)
    print("Using Swift 5.0 or later")
#endif

#if compiler(>=5.0)
    print("Compiled with Swift 5.0 compiler or later")
#endif

#if canImport(UIKit)
    import UIKit
    print("UIKit is available")
#endif

#if targetEnvironment(simulator)
    print("Running in simulator")
#else
    print("Running on device")
#endif

// Example: Combining compilation conditions
#if os(macOS) && arch(x86_64)
    print("macOS on x86_64")
#endif

#if !os(Linux)
    print("Not running on Linux")
#endif

// Example: Multiple branches
#if DEBUG
    print("Debug mode")
#elseif RELEASE
    print("Release mode")
#else
    print("Other mode")
#endif

// Note: Each statement in the body of a conditional compilation block is parsed even if it's
// not compiled. However, there's an exception if the compilation condition includes a swift()
// or compiler() platform condition: The statements are parsed only if the language or compiler
// version matches what is specified in the platform condition.

// MARK: - Line Control Statement

// A line control statement is used to specify a line number and filename that can be different
// from the line number and filename of the source code being compiled.

// A line control statement has the following forms:
// #sourceLocation(file: <#file path#>, line: <#line number#>)
// #sourceLocation()

#sourceLocation(file: "CustomFile.swift", line: 1)
// This code will appear to be from CustomFile.swift at line 1

#sourceLocation()
// Reset to default line numbering and file path

// MARK: - Compile-Time Diagnostic Statement

// Prior to Swift 5.9, the #warning and #error statements emit a diagnostic during compilation.
// This behavior is now provided by the warning(_:) and error(_:) macros in the Swift standard
// library.

// Example: Using macros for diagnostics
// #warning("This is a warning")
// #error("This is an error")

// MARK: - Availability Condition

// An availability condition is used as a condition of an if, while, and guard statement to query
// the availability of APIs at runtime, based on specified platforms arguments.

// An availability condition has the following form:
// if #available(<#platform name#> <#version#>, <#...#>, *) {
//     <#statements to execute if the APIs are available#>
// } else {
//     <#fallback statements to execute if the APIs are unavailable#>
// }

if #available(iOS 10, macOS 10.12, *) {
    // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
    print("Using newer APIs")
} else {
    // Fall back to earlier iOS and macOS APIs
    print("Using older APIs")
}

// Example: Unavailability condition
if #unavailable(iOS 10) {
    // Fallback for iOS versions earlier than 10
    print("Using older iOS APIs")
} else {
    // Use iOS 10 APIs
    print("Using iOS 10 APIs")
}

// Example: Availability in guard statement
func useNewAPI() {
    guard #available(iOS 10, *) else {
        print("iOS 10 is required")
        return
    }
    // Use iOS 10 APIs
    print("Using iOS 10 APIs")
}

// Example: Availability in while statement
var version = 9
while #available(iOS 10, *), version < 10 {
    version += 1
    print("Checking version: \(version)")
}

// MARK: - Additional Examples

// MARK: - Example: Nested Control Flow

func processNumbers(_ numbers: [Int]) {
    outer: for number in numbers {
        inner: for i in 1...number {
            if i == 3 {
                continue outer  // Continue outer loop
            }
            if number > 10 && i == 5 {
                break outer  // Break outer loop
            }
            print("Number: \(number), i: \(i)")
        }
    }
}

// MARK: - Example: Complex Switch Statement

enum Direction {
    case north, south, east, west
}

func describeDirection(_ direction: Direction, distance: Int) -> String {
    switch (direction, distance) {
    case (.north, let d) where d > 100:
        return "Far north"
    case (.north, _):
        return "North"
    case (.south, let d) where d > 100:
        return "Far south"
    case (.south, _):
        return "South"
    case (.east, let d), (.west, let d) where d > 50:
        return "Long distance \(direction == .east ? "east" : "west")"
    case (.east, _), (.west, _):
        return direction == .east ? "East" : "West"
    }
}

// MARK: - Example Function Demonstrating All Statement Concepts

func demonstrateStatements() {
    print("\n=== Demonstrating Swift Statements ===\n")
    
    // Loop statements
    print("1. Loop Statements:")
    print("   For-in:")
    for i in 1...3 {
        print("     \(i)")
    }
    
    print("\n   While:")
    var w = 0
    while w < 3 {
        print("     \(w)")
        w += 1
    }
    
    print("\n   Repeat-while:")
    var r = 0
    repeat {
        print("     \(r)")
        r += 1
    } while r < 3
    
    // Branch statements
    print("\n2. Branch Statements:")
    print("   If statement:")
    if true {
        print("     Condition is true")
    }
    
    print("\n   Guard statement:")
    func testGuard(_ value: Int?) {
        guard let v = value else {
            print("     Value is nil")
            return
        }
        print("     Value is \(v)")
    }
    testGuard(42)
    testGuard(nil)
    
    print("\n   Switch statement:")
    let value = 2
    switch value {
    case 1:
        print("     One")
    case 2:
        print("     Two")
    default:
        print("     Other")
    }
    
    // Control transfer statements
    print("\n3. Control Transfer Statements:")
    print("   Break:")
    for i in 1...5 {
        if i == 3 {
            break
        }
        print("     \(i)")
    }
    
    print("\n   Continue:")
    for i in 1...5 {
        if i == 3 {
            continue
        }
        print("     \(i)")
    }
    
    print("\n   Return:")
    func testReturn() -> String {
        return "Returned value"
    }
    print("     \(testReturn())")
    
    // Defer statement
    print("\n4. Defer Statement:")
    func testDefer() {
        defer { print("     Defer executed") }
        print("     Function body")
    }
    testDefer()
    
    // Do statement
    print("\n5. Do Statement:")
    do {
        let x = 10
        print("     x = \(x)")
    }
    
    // Conditional compilation
    print("\n6. Conditional Compilation:")
    #if os(macOS)
        print("     Running on macOS")
    #else
        print("     Running on another platform")
    #endif
    
    // Availability
    print("\n7. Availability Condition:")
    if #available(macOS 10.12, *) {
        print("     macOS 10.12+ APIs available")
    } else {
        print("     Using older APIs")
    }
    
    print("\n=== End of Demonstration ===\n")
}

// Uncomment to run the demonstration
// demonstrateStatements()


