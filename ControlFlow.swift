//
//  ControlFlow.swift
//  Swift Language Practice - Control Flow
//
//  This file contains examples demonstrating Swift's control flow statements
//  including loops, conditionals, and control transfer statements.
//

import Foundation

// MARK: - For-In Loops

// You use the for-in loop to iterate over a sequence, such as items in an array,
// ranges of numbers, or characters in a string.

// MARK: - Iterating Over an Array

let names = ["Anna", "Alex", "Brian", "Jack"]
print("Iterating over names array:")
for name in names {
    print("Hello, \(name)!")
}
// Hello, Anna!
// Hello, Alex!
// Hello, Brian!
// Hello, Jack!

// MARK: - Iterating Over a Dictionary

// You can also iterate over a dictionary to access its key-value pairs.
// Each item in the dictionary is returned as a (key, value) tuple when the dictionary is iterated,
// and you can decompose the (key, value) tuple's members as explicitly named constants.

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
print("\nIterating over dictionary:")
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}
// cats have 4 legs
// ants have 6 legs
// spiders have 8 legs

// Note: The contents of a Dictionary are inherently unordered, and iterating over them
// doesn't guarantee the order in which they will be retrieved.

// MARK: - Iterating Over Numeric Ranges

// You can also use for-in loops with numeric ranges.
// This example prints the first few entries in a five-times table:

print("\nFive-times table:")
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
// 1 times 5 is 5
// 2 times 5 is 10
// 3 times 5 is 15
// 4 times 5 is 20
// 5 times 5 is 25

// The sequence being iterated over is a range of numbers from 1 to 5, inclusive,
// as indicated by the use of the closed range operator (...).
// The value of index is a constant whose value is automatically set at the start
// of each iteration of the loop.

// MARK: - Ignoring Values with Underscore

// If you don't need each value from a sequence, you can ignore the values by using
// an underscore in place of a variable name.

let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\n\(base) to the power of \(power) is \(answer)")
// Prints "3 to the power of 10 is 59049"

// The example above calculates the value of one number to the power of another.
// The underscore character (_) used in place of a loop variable causes the individual
// values to be ignored and doesn't provide access to the current value during each iteration.

// MARK: - Half-Open Range Operator

// In some situations, you might not want to use closed ranges, which include both endpoints.
// Consider drawing the tick marks for every minute on a watch face.
// You want to draw 60 tick marks, starting with the 0 minute.
// Use the half-open range operator (..<) to include the lower bound but not the upper bound.

let minutes = 60
print("\nTick marks (0..<60):")
for tickMark in 0..<minutes {
    // render the tick mark each minute (60 times)
    // In this example, we'll just print the tick mark number
    if tickMark % 10 == 0 {
        print("  Tick mark at \(tickMark)")
    }
}

// MARK: - Stride Function

// Some users might want fewer tick marks in their UI. They could prefer one mark every 5 minutes instead.
// Use the stride(from:to:by:) function to skip the unwanted marks.

let minuteInterval = 5
print("\nTick marks every 5 minutes (stride):")
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
    print("  Tick mark at \(tickMark)")
}

// Closed ranges are also available, by using stride(from:through:by:) instead:

let hours = 12
let hourInterval = 3
print("\nTick marks every 3 hours (stride through):")
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
    // render the tick mark every 3 hours (3, 6, 9, 12)
    print("  Tick mark at \(tickMark)")
}

// MARK: - While Loops

// A while loop performs a set of statements until a condition becomes false.
// These kinds of loops are best used when the number of iterations isn't known
// before the first iteration begins. Swift provides two kinds of while loops:
// - while evaluates its condition at the start of each pass through the loop.
// - repeat-while evaluates its condition at the end of each pass through the loop.

// MARK: - While

// A while loop starts by evaluating a single condition.
// If the condition is true, a set of statements is repeated until the condition becomes false.

// Example: Snakes and Ladders game
// The board has 25 squares, and the aim is to land on or beyond square 25.
// The player's starting square is "square zero", which is just off the bottom-left corner of the board.
// Each turn, you roll a six-sided dice and move by that number of squares.
// If your turn ends at the bottom of a ladder, you move up that ladder.
// If your turn ends at the head of a snake, you move down that snake.

let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)

// Some squares are then set to have more specific values for the snakes and ladders.
// Squares with a ladder base have a positive number to move you up the board,
// whereas squares with a snake head have a negative number to move you back down the board.

board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

// Square 3 contains the bottom of a ladder that moves you up to square 11.
// To represent this, board[03] is equal to +08, which is equivalent to an integer value of 8
// (the difference between 3 and 11).

var square = 0
var diceRoll = 0

print("\n=== Snakes and Ladders Game (while loop) ===")
while square < finalSquare {
    // roll the dice
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    // move by the rolled amount
    square += diceRoll
    if square < board.count {
        // if we're still on the board, move up or down for a snake or a ladder
        square += board[square]
    }
    print("  Rolled \(diceRoll), now on square \(square)")
}
print("Game over!")

// The example above uses a very simple approach to dice rolling.
// Instead of generating a random number, it starts with a diceRoll value of 0.
// Each time through the while loop, diceRoll is incremented by one and is then checked
// to see whether it has become too large. Whenever this return value equals 7,
// the dice roll has become too large and is reset to a value of 1.

// MARK: - Repeat-While

// The other variation of the while loop, known as the repeat-while loop,
// performs a single pass through the loop block first, before considering the loop's condition.
// It then continues to repeat the loop until the condition is false.

// Note: The repeat-while loop in Swift is analogous to a do-while loop in other languages.

// Here's the Snakes and Ladders example again, written as a repeat-while loop:

let finalSquare2 = 25
var board2 = [Int](repeating: 0, count: finalSquare2 + 1)
board2[03] = +08; board2[06] = +11; board2[09] = +09; board2[10] = +02
board2[14] = -10; board2[19] = -11; board2[22] = -02; board2[24] = -08
var square2 = 0
var diceRoll2 = 0

print("\n=== Snakes and Ladders Game (repeat-while loop) ===")
repeat {
    // move up or down for a snake or ladder
    square2 += board2[square2]
    // roll the dice
    diceRoll2 += 1
    if diceRoll2 == 7 { diceRoll2 = 1 }
    // move by the rolled amount
    square2 += diceRoll2
    print("  Rolled \(diceRoll2), now on square \(square2)")
} while square2 < finalSquare2
print("Game over!")

// In this version of the game, the first action in the loop is to check for a ladder or a snake.
// No ladder on the board takes the player straight to square 25, and so it isn't possible
// to win the game by moving up a ladder. Therefore, it's safe to check for a snake or a ladder
// as the first action in the loop.

// MARK: - Conditional Statements

// It's often useful to execute different pieces of code based on certain conditions.
// Swift provides two ways to add conditional branches to your code:
// - the if statement (for simple conditions with only a few possible outcomes)
// - the switch statement (for more complex conditions with multiple possible permutations)

// MARK: - If

// In its simplest form, the if statement has a single if condition.
// It executes a set of statements only if that condition is true.

var temperatureInFahrenheit = 30
print("\n=== If Statements ===")
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}
// Prints "It's very cold. Consider wearing a scarf."

// The if statement can provide an alternative set of statements, known as an else clause,
// for situations when the if condition is false.

temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else {
    print("It's not that cold. Wear a T-shirt.")
}
// Prints "It's not that cold. Wear a T-shirt."

// You can chain multiple if statements together to consider additional clauses.

temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a T-shirt.")
}
// Prints "It's really warm. Don't forget to wear sunscreen."

// The final else clause is optional, however, and can be excluded if the set of conditions
// doesn't need to be complete.

temperatureInFahrenheit = 72
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
}
// No message is printed because the temperature doesn't trigger any condition.

// MARK: - If Expression

// Swift provides a shorthand spelling of if that you can use when setting values.
// This is known as an if expression.

let temperatureInCelsius = 25
let weatherAdvice = if temperatureInCelsius <= 0 {
    "It's very cold. Consider wearing a scarf."
} else if temperatureInCelsius >= 30 {
    "It's really warm. Don't forget to wear sunscreen."
} else {
    "It's not that cold. Wear a T-shirt."
}

print("\nIf expression result: \(weatherAdvice)")
// Prints "It's not that cold. Wear a T-shirt."

// In this if expression version, each branch contains a single value.
// If a branch's condition is true, then that branch's value is used as the value
// for the whole if expression in the assignment of weatherAdvice.

// All of the branches of an if expression need to contain values of the same type.
// Because Swift checks the type of each branch separately, values like nil that can be
// used with more than one type prevent Swift from determining the if expression's type automatically.

let freezeWarning: String? = if temperatureInCelsius <= 0 {
    "It's below freezing. Watch for ice!"
} else {
    nil
}
print("Freeze warning: \(freezeWarning ?? "No warning")")

// An alternate way to provide this type information is to provide an explicit type for nil:

let freezeWarning2 = if temperatureInCelsius <= 0 {
    "It's below freezing. Watch for ice!"
} else {
    nil as String?
}
print("Freeze warning 2: \(freezeWarning2 ?? "No warning")")

// MARK: - Switch

// A switch statement considers a value and compares it against several possible matching patterns.
// It then executes an appropriate block of code, based on the first pattern that matches successfully.
// A switch statement provides an alternative to the if statement for responding to multiple potential states.

// In its simplest form, a switch statement compares a value against one or more values of the same type.

// Every switch statement consists of multiple possible cases, each of which begins with the case keyword.
// Every switch statement must be exhaustive. That is, every possible value of the type being considered
// must be matched by one of the switch cases. If it's not appropriate to provide a case for every
// possible value, you can define a default case to cover any values that aren't addressed explicitly.

let someCharacter: Character = "z"
print("\n=== Switch Statements ===")
switch someCharacter {
case "a":
    print("The first letter of the Latin alphabet")
case "z":
    print("The last letter of the Latin alphabet")
default:
    print("Some other character")
}
// Prints "The last letter of the Latin alphabet".

// Like if statements, switch statements also have an expression form:

let anotherCharacter: Character = "a"
let message = switch anotherCharacter {
case "a":
    "The first letter of the Latin alphabet"
case "z":
    "The last letter of the Latin alphabet"
default:
    "Some other character"
}

print("Switch expression result: \(message)")
// Prints "The first letter of the Latin alphabet".

// MARK: - No Implicit Fallthrough

// In contrast with switch statements in C and Objective-C, switch statements in Swift don't fall through
// the bottom of each case and into the next one by default. Instead, the entire switch statement
// finishes its execution as soon as the first matching switch case is completed, without requiring
// an explicit break statement.

// The body of each case must contain at least one executable statement.
// It isn't valid to write a case with an empty body.

// To make a switch with a single case that matches both "a" and "A", combine the two values
// into a compound case, separating the values with commas.

let anotherCharacter2: Character = "a"
switch anotherCharacter2 {
case "a", "A":
    print("The letter A")
default:
    print("Not the letter A")
}
// Prints "The letter A".

// MARK: - Interval Matching

// Values in switch cases can be checked for their inclusion in an interval.
// This example uses number intervals to provide a natural-language count for numbers of any size:

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
print("\nInterval matching: There are \(naturalCount) \(countedThings).")
// Prints "There are dozens of moons orbiting Saturn."

// MARK: - Tuples

// You can use tuples to test multiple values in the same switch statement.
// Each element of the tuple can be tested against a different value or interval of values.
// Alternatively, use the underscore character (_), also known as the wildcard pattern,
// to match any possible value.

let somePoint = (1, 1)
print("\n=== Tuple Matching ===")
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}
// Prints "(1, 1) is inside the box".

// Unlike C, Swift allows multiple switch cases to consider the same value or values.
// However, if multiple matches are possible, the first matching case is always used.

// MARK: - Value Bindings

// A switch case can name the value or values it matches to temporary constants or variables,
// for use in the body of the case. This behavior is known as value binding.

let anotherPoint = (2, 0)
print("\n=== Value Bindings ===")
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
// Prints "on the x-axis with an x value of 2".

// The three switch cases declare placeholder constants x and y, which temporarily take on
// one or both tuple values from anotherPoint. The first case, case (let x, 0), matches any point
// with a y value of 0 and assigns the point's x value to the temporary constant x.

// MARK: - Where

// A switch case can use a where clause to check for additional conditions.

let yetAnotherPoint = (1, -1)
print("\n=== Where Clause ===")
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}
// Prints "(1, -1) is on the line x == -y".

// The three switch cases declare placeholder constants x and y, which temporarily take on
// the two tuple values from yetAnotherPoint. These constants are used as part of a where clause,
// to create a dynamic filter. The switch case matches the current value of point only if
// the where clause's condition evaluates to true for that value.

// MARK: - Compound Cases

// Multiple switch cases that share the same body can be combined by writing several patterns
// after case, with a comma between each of the patterns. If any of the patterns match,
// then the case is considered to match.

let someCharacter2: Character = "e"
print("\n=== Compound Cases ===")
switch someCharacter2 {
case "a", "e", "i", "o", "u":
    print("\(someCharacter2) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
    "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter2) is a consonant")
default:
    print("\(someCharacter2) isn't a vowel or a consonant")
}
// Prints "e is a vowel".

// Compound cases can also include value bindings. All of the patterns of a compound case
// have to include the same set of value bindings, and each binding has to get a value of
// the same type from all of the patterns in the compound case.

let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}
// Prints "On an axis, 9 from the origin".

// MARK: - Patterns

// In the previous examples, each switch case includes a pattern that indicates what values match that case.
// You can also use a pattern as the condition for an if statement.

let somePoint2 = (12, 100)
print("\n=== Pattern Matching in If ===")
if case (let x, 100) = somePoint2 {
    print("Found a point on the y=100 line, at \(x)")
}
// Prints "Found a point on the y=100 line, at 12".

// In a for-in loop, you can give names to parts of the value using a value binding pattern,
// even without writing case in your code:

let points = [(10, 0), (30, -30), (-20, 0)]
print("\n=== Pattern Matching in For-In ===")
for (x, y) in points {
    if y == 0 {
        print("Found a point on the x-axis at \(x)")
    }
}
// Prints "Found a point on the x-axis at 10".
// Prints "Found a point on the x-axis at -20".

// A more concise way to write this code is to combine the value bindings and condition
// using a for-case-in loop:

for case (let x, 0) in points {
    print("Found a point on the x-axis at \(x)")
}
// Prints "Found a point on the x-axis at 10".
// Prints "Found a point on the x-axis at -20".

// A for-case-in loop can also include a where clause, to check for an additional condition:

for case let (x, y) in points where x == y || x == -y {
    print("Found (\(x), \(y)) along a line through the origin")
}
// Prints "Found (30, -30) along a line through the origin".

// MARK: - Control Transfer Statements

// Control transfer statements change the order in which your code is executed,
// by transferring control from one piece of code to another. Swift has five control transfer statements:
// - continue
// - break
// - fallthrough
// - return
// - throw

// MARK: - Continue

// The continue statement tells a loop to stop what it's doing and start again at the beginning
// of the next iteration through the loop. It says "I am done with the current loop iteration"
// without leaving the loop altogether.

let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
print("\n=== Continue Statement ===")
print("Original: \(puzzleInput)")
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue
    }
    puzzleOutput.append(character)
}
print("After removing vowels and spaces: \(puzzleOutput)")
// Prints "grtmndsthnklk".

// MARK: - Break

// The break statement ends execution of an entire control flow statement immediately.
// The break statement can be used inside a switch or loop statement when you want to terminate
// the execution of the switch or loop statement earlier than would otherwise be the case.

// MARK: - Break in a Loop Statement

// When used inside a loop statement, break ends the loop's execution immediately and transfers
// control to the code after the loop's closing brace (}).

print("\n=== Break in Loop ===")
var number = 1
while number < 10 {
    if number == 5 {
        break
    }
    print("Number: \(number)")
    number += 1
}
print("Loop ended")

// MARK: - Break in a Switch Statement

// When used inside a switch statement, break causes the switch statement to end its execution
// immediately and to transfer control to the code after the switch statement's closing brace (}).

// This behavior can be used to match and ignore one or more cases in a switch statement.
// Because Swift's switch statement is exhaustive and doesn't allow empty cases, it's sometimes
// necessary to deliberately match and ignore a case in order to make your intentions explicit.

let numberSymbol: Character = "三"  // Chinese symbol for the number 3
var possibleIntegerValue: Int?
print("\n=== Break in Switch ===")
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
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value couldn't be found for \(numberSymbol).")
}
// Prints "The integer value of 三 is 3."

// MARK: - Fallthrough

// In Swift, switch statements don't fall through the bottom of each case and into the next one.
// That is, the entire switch statement completes its execution as soon as the first matching case is completed.
// By contrast, C requires you to insert an explicit break statement at the end of every switch case
// to prevent fallthrough.

// If you need C-style fallthrough behavior, you can opt in to this behavior on a case-by-case basis
// with the fallthrough keyword.

let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
print("\n=== Fallthrough ===")
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)
// Prints "The number 5 is a prime number, and also an integer."

// Note: The fallthrough keyword doesn't check the case conditions for the switch case that it causes
// execution to fall into. The fallthrough keyword simply causes code execution to move directly to
// the statements inside the next case (or default case) block, as in C's standard switch statement behavior.

// MARK: - Labeled Statements

// In Swift, you can nest loops and conditional statements inside other loops and conditional statements
// to create complex control flow structures. However, loops and conditional statements can both use
// the break statement to end their execution prematurely. Therefore, it's sometimes useful to be explicit
// about which loop or conditional statement you want a break statement to terminate.

// To achieve these aims, you can mark a loop statement or conditional statement with a statement label.
// A labeled statement is indicated by placing a label on the same line as the statement's introducer keyword,
// followed by a colon.

// Example: Snakes and Ladders game with labeled statements
// This version has an extra rule: To win, you must land exactly on square 25.
// If a particular dice roll would take you beyond square 25, you must roll again until
// you roll the exact number needed to land on square 25.

let finalSquare3 = 25
var board3 = [Int](repeating: 0, count: finalSquare3 + 1)
board3[03] = +08; board3[06] = +11; board3[09] = +09; board3[10] = +02
board3[14] = -10; board3[19] = -11; board3[22] = -02; board3[24] = -08
var square3 = 0
var diceRoll3 = 0

print("\n=== Labeled Statements ===")
gameLoop: while square3 != finalSquare3 {
    diceRoll3 += 1
    if diceRoll3 == 7 { diceRoll3 = 1 }
    switch square3 + diceRoll3 {
    case finalSquare3:
        // diceRoll will move us to the final square, so the game is over
        break gameLoop
    case let newSquare where newSquare > finalSquare3:
        // diceRoll will move us beyond the final square, so roll again
        continue gameLoop
    default:
        // this is a valid move, so find out its effect
        square3 += diceRoll3
        square3 += board3[square3]
    }
}
print("Game over!")

// The dice is rolled at the start of each loop. Rather than moving the player immediately,
// the loop uses a switch statement to consider the result of the move and to determine whether the move is allowed:
// - If the dice roll will move the player onto the final square, the game is over.
//   The break gameLoop statement transfers control to the first line of code outside of the while loop.
// - If the dice roll will move the player beyond the final square, the move is invalid
//   and the player needs to roll again. The continue gameLoop statement ends the current while loop
//   iteration and begins the next iteration of the loop.
// - In all other cases, the dice roll is a valid move. The player moves forward by diceRoll squares,
//   and the game logic checks for any snakes and ladders.

// MARK: - Early Exit

// A guard statement, like an if statement, executes statements depending on the Boolean value of an expression.
// You use a guard statement to require that a condition must be true in order for the code after the guard
// statement to be executed. Unlike an if statement, a guard statement always has an else clause —
// the code inside the else clause is executed if the condition isn't true.

func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    
    print("Hello \(name)!")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    
    print("I hope the weather is nice in \(location).")
}

print("\n=== Guard Statement (Early Exit) ===")
greet(person: ["name": "John"])
// Prints "Hello John!"
// Prints "I hope the weather is nice near you."

greet(person: ["name": "Jane", "location": "Cupertino"])
// Prints "Hello Jane!"
// Prints "I hope the weather is nice in Cupertino."

// If the guard statement's condition is met, code execution continues after the guard statement's closing brace.
// Any variables or constants that were assigned values using an optional binding as part of the condition
// are available for the rest of the code block that the guard statement appears in.

// If that condition isn't met, the code inside the else branch is executed. That branch must transfer control
// to exit the code block in which the guard statement appears. It can do this with a control transfer statement
// such as return, break, continue, or throw, or it can call a function or method that doesn't return,
// such as fatalError(_:file:line:).

// MARK: - Deferred Actions

// Unlike control-flow constructs like if and while, which let you control whether part of your code
// is executed or how many times it gets executed, defer controls when a piece of code is executed.
// You use a defer block to write code that will be executed later, when your program reaches the end
// of the current scope.

var score = 1
print("\n=== Defer Statement ===")
if score < 10 {
    defer {
        print(score)
    }
    score += 5
}
// Prints "6".

// In the example above, the code inside of the defer block is executed before exiting the body
// of the if statement. First, the code in the if statement runs, which increments score by five.
// Then, before exiting the if statement's scope, the deferred code is run, which prints score.

// The code inside of the defer always runs, regardless of how the program exits that scope.
// That includes code like an early exit from a function, breaking out of a for loop, or throwing an error.

var score2 = 3
if score2 < 100 {
    score2 += 100
    defer {
        score2 -= 100
    }
    // Other code that uses the score with its bonus goes here.
    print("Score with bonus: \(score2)")
}
// Prints "103".

// If you write more than one defer block in the same scope, the first one you specify is the last one to run.

var score3 = 1
if score3 < 10 {
    defer {
        print(score3)
    }
    defer {
        print("The score is:")
    }
    score3 += 5
}
// Prints "The score is:".
// Prints "6".

// MARK: - Checking API Availability

// Swift has built-in support for checking API availability, which ensures that you don't accidentally
// use APIs that are unavailable on a given deployment target.

// The compiler uses availability information in the SDK to verify that all of the APIs used in your code
// are available on the deployment target specified by your project. Swift reports an error at compile time
// if you try to use an API that isn't available.

// You use an availability condition in an if or guard statement to conditionally execute a block of code,
// depending on whether the APIs you want to use are available at runtime.

print("\n=== API Availability Check ===")
if #available(iOS 10, macOS 10.12, *) {
    // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
    print("Using newer APIs")
} else {
    // Fall back to earlier iOS and macOS APIs
    print("Using older APIs")
}

// The availability condition above specifies that in iOS, the body of the if statement executes only
// in iOS 10 and later; in macOS, only in macOS 10.12 and later. The last argument, *, is required
// and specifies that on any other platform, the body of the if executes on the minimum deployment
// target specified by your target.

// When you use an availability condition with a guard statement, it refines the availability information
// that's used for the rest of the code in that code block.

@available(macOS 10.12, *)
struct ColorPreference {
    var bestColor = "blue"
}

func chooseBestColor() -> String {
    guard #available(macOS 10.12, *) else {
        return "gray"
    }
    let colors = ColorPreference()
    return colors.bestColor
}

print("Best color: \(chooseBestColor())")

// In addition to #available, Swift also supports the opposite check using an unavailability condition.

if #unavailable(iOS 10) {
    // Fallback code
    print("iOS 10 not available")
}

// MARK: - Example Function Demonstrating All Control Flow

func demonstrateControlFlow() {
    print("\n=== Demonstrating Swift Control Flow ===\n")
    
    // For-In Loops
    print("1. For-In Loops:")
    let numbers = [1, 2, 3, 4, 5]
    for number in numbers {
        print("   \(number)", terminator: " ")
    }
    print("")
    
    // While Loop
    print("\n2. While Loop:")
    var counter = 0
    while counter < 3 {
        print("   Counter: \(counter)")
        counter += 1
    }
    
    // Repeat-While Loop
    print("\n3. Repeat-While Loop:")
    var counter2 = 0
    repeat {
        print("   Counter: \(counter2)")
        counter2 += 1
    } while counter2 < 3
    
    // If Statement
    print("\n4. If Statement:")
    let value = 10
    if value > 5 {
        print("   Value is greater than 5")
    } else {
        print("   Value is not greater than 5")
    }
    
    // Switch Statement
    print("\n5. Switch Statement:")
    let grade = "A"
    switch grade {
    case "A":
        print("   Excellent!")
    case "B":
        print("   Good!")
    default:
        print("   Keep trying!")
    }
    
    // Guard Statement
    print("\n6. Guard Statement:")
    func checkValue(_ value: Int?) {
        guard let value = value else {
            print("   Value is nil")
            return
        }
        print("   Value is \(value)")
    }
    checkValue(42)
    checkValue(nil)
    
    // Continue Statement
    print("\n7. Continue Statement:")
    for i in 1...5 {
        if i == 3 {
            continue
        }
        print("   \(i)", terminator: " ")
    }
    print("")
    
    // Break Statement
    print("\n8. Break Statement:")
    for i in 1...5 {
        if i == 3 {
            break
        }
        print("   \(i)", terminator: " ")
    }
    print("")
    
    // Defer Statement
    print("\n9. Defer Statement:")
    func testDefer() {
        defer {
            print("   This runs last")
        }
        print("   This runs first")
    }
    testDefer()
    
    print("\n=== End of Demonstration ===\n")
}

// Uncomment to run the demonstration
// demonstrateControlFlow()


