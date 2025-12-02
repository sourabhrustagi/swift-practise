// MARK: - Patterns
// Patterns represent the structure of a single value or a composite value.
// They can match and destructure values, extracting parts and binding them to constants or variables.

import Foundation

// MARK: - Wildcard Pattern
// A wildcard pattern matches and ignores any value using an underscore (_)

func demonstrateWildcardPattern() {
    print("=== Wildcard Pattern ===")
    
    // Ignoring values in a loop
    for _ in 1...3 {
        print("Doing something...")
    }
    
    // Ignoring tuple elements
    let tuple = (1, 2, 3)
    let (_, second, _) = tuple
    print("Second element: \(second)")
    
    // Ignoring function return values
    let _ = someFunction()
}

func someFunction() -> Int {
    return 42
}

// MARK: - Identifier Pattern
// An identifier pattern matches any value and binds it to a variable or constant name

func demonstrateIdentifierPattern() {
    print("\n=== Identifier Pattern ===")
    
    // Simple constant binding
    let someValue = 42
    print("someValue: \(someValue)")
    
    // Simple variable binding
    var anotherValue = "Hello"
    print("anotherValue: \(anotherValue)")
    
    // Binding in function parameters
    func greet(name: String) {
        print("Hello, \(name)!")
    }
    greet(name: "Swift")
}

// MARK: - Value-Binding Pattern
// Binds matched values to variable or constant names using let or var

func demonstrateValueBindingPattern() {
    print("\n=== Value-Binding Pattern ===")
    
    // Binding tuple elements
    let point = (3, 2)
    switch point {
    case let (x, y):
        print("The point is at (\(x), \(y)).")
    }
    
    // Using var for mutable binding
    let anotherPoint = (5, 7)
    switch anotherPoint {
    case var (x, y):
        x += 1
        y += 1
        print("Modified point: (\(x), \(y))")
    }
    
    // Equivalent forms
    let coordinate = (10, 20)
    switch coordinate {
    case (let x, let y):
        print("Coordinate: (\(x), \(y))")
    }
    
    // Binding in if statement
    let optionalTuple: (Int, String)? = (42, "Answer")
    if let (number, text) = optionalTuple {
        print("Number: \(number), Text: \(text)")
    }
}

// MARK: - Tuple Pattern
// A comma-separated list of patterns enclosed in parentheses

func demonstrateTuplePattern() {
    print("\n=== Tuple Pattern ===")
    
    // Basic tuple pattern matching
    let point = (1, 2)
    switch point {
    case (0, 0):
        print("At origin")
    case (let x, 0):
        print("On x-axis at \(x)")
    case (0, let y):
        print("On y-axis at \(y)")
    case let (x, y):
        print("At (\(x), \(y))")
    }
    
    // Tuple pattern with type annotation
    let typedPoint: (Int, Int) = (3, 4)
    let (x, y): (Int, Int) = typedPoint
    print("Typed point: (\(x), \(y))")
    
    // Nested tuple patterns
    let nestedTuple = ((1, 2), (3, 4))
    switch nestedTuple {
    case let ((a, b), (c, d)):
        print("Nested: (\(a), \(b)), (\(c), \(d))")
    }
    
    // Single element tuple (parentheses have no effect)
    let a = 2
    let (b) = 2
    let (c): Int = 2
    print("a: \(a), b: \(b), c: \(c)")
    
    // Tuple pattern with labeled elements
    let person = (name: "Alice", age: 30)
    switch person {
    case let (name: n, age: a):
        print("\(n) is \(a) years old")
    }
}

// MARK: - Enumeration Case Pattern
// Matches a case of an existing enumeration type

func demonstrateEnumerationCasePattern() {
    print("\n=== Enumeration Case Pattern ===")
    
    // Basic enum
    enum Direction {
        case north, south, east, west
    }
    
    let direction: Direction = .north
    switch direction {
    case .north:
        print("Heading north")
    case .south:
        print("Heading south")
    case .east:
        print("Heading east")
    case .west:
        print("Heading west")
    }
    
    // Enum with associated values
    enum Result {
        case success(String)
        case failure(Error)
    }
    
    let result: Result = .success("Operation completed")
    switch result {
    case .success(let message):
        print("Success: \(message)")
    case .failure(let error):
        print("Failure: \(error)")
    }
    
    // Enum case pattern with optional
    enum SomeEnum {
        case left, right
    }
    
    let x: SomeEnum? = .left
    switch x {
    case .left:
        print("Turn left")
    case .right:
        print("Turn right")
    case nil:
        print("Keep going straight")
    }
    
    // Using in if statement
    if case .left = x {
        print("It's left!")
    }
    
    // Using in guard statement
    func processDirection(_ dir: SomeEnum?) {
        guard case .left = dir else {
            print("Not left")
            return
        }
        print("Processing left direction")
    }
    processDirection(.left)
}

// MARK: - Optional Pattern
// Matches values wrapped in Optional.some, syntactic sugar for Optional enumeration

func demonstrateOptionalPattern() {
    print("\n=== Optional Pattern ===")
    
    let someOptional: Int? = 42
    
    // Using enumeration case pattern
    if case .some(let x) = someOptional {
        print("Value using enum case: \(x)")
    }
    
    // Using optional pattern (equivalent)
    if case let x? = someOptional {
        print("Value using optional pattern: \(x)")
    }
    
    // Iterating over array of optionals
    let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]
    for case let number? in arrayOfOptionalInts {
        print("Found a \(number)")
    }
    
    // Optional pattern in switch
    let optionalValue: String? = "Hello"
    switch optionalValue {
    case let value?:
        print("Has value: \(value)")
    case nil:
        print("No value")
    }
    
    // Multiple optional patterns
    let optionalPair: (Int?, Int?) = (1, 2)
    switch optionalPair {
    case let (x?, y?):
        print("Both have values: \(x), \(y)")
    case let (x?, nil):
        print("Only first has value: \(x)")
    case let (nil, y?):
        print("Only second has value: \(y)")
    case (nil, nil):
        print("Neither has value")
    }
}

// MARK: - Type-Casting Patterns
// is pattern and as pattern for type checking and casting

func demonstrateTypeCastingPattern() {
    print("\n=== Type-Casting Patterns ===")
    
    // is pattern - type checking
    let value: Any = 42
    
    switch value {
    case is String:
        print("It's a String")
    case is Int:
        print("It's an Int")
    case is Double:
        print("It's a Double")
    default:
        print("Unknown type")
    }
    
    // as pattern - type casting
    let mixedArray: [Any] = [1, "Hello", 3.14, true, "World"]
    
    for item in mixedArray {
        switch item {
        case let str as String:
            print("String: \(str)")
        case let num as Int:
            print("Int: \(num)")
        case let double as Double:
            print("Double: \(double)")
        case let bool as Bool:
            print("Bool: \(bool)")
        default:
            print("Unknown type")
        }
    }
    
    // Combining is and as patterns
    class Animal {
        func makeSound() {
            print("Some sound")
        }
    }
    
    class Dog: Animal {
        override func makeSound() {
            print("Woof!")
        }
        
        func fetch() {
            print("Fetching...")
        }
    }
    
    class Cat: Animal {
        override func makeSound() {
            print("Meow!")
        }
    }
    
    let animals: [Animal] = [Dog(), Cat(), Dog()]
    
    for animal in animals {
        switch animal {
        case let dog as Dog:
            dog.fetch()
            dog.makeSound()
        case is Cat:
            animal.makeSound()
        default:
            animal.makeSound()
        }
    }
}

// MARK: - Expression Pattern
// Represents the value of an expression, compared using the ~= operator

func demonstrateExpressionPattern() {
    print("\n=== Expression Pattern ===")
    
    // Basic expression pattern
    let point = (1, 2)
    switch point {
    case (0, 0):
        print("(0, 0) is at the origin.")
    case (-2...2, -2...2):
        print("(\(point.0), \(point.1)) is near the origin.")
    default:
        print("The point is at (\(point.0), \(point.1)).")
    }
    
    // Range matching
    let score = 85
    switch score {
    case 0..<60:
        print("F")
    case 60..<70:
        print("D")
    case 70..<80:
        print("C")
    case 80..<90:
        print("B")
    case 90...100:
        print("A")
    default:
        print("Invalid score")
    }
    
    // String matching
    let name = "Alice"
    switch name {
    case "Alice":
        print("Hello, Alice!")
    case "Bob":
        print("Hello, Bob!")
    default:
        print("Hello, stranger!")
    }
    
    // Custom ~= operator for expression matching
    struct Point {
        let x: Int
        let y: Int
    }
    
    // Overload ~= to match Point with a string
    func ~= (pattern: String, value: Point) -> Bool {
        return pattern == "\(value.x),\(value.y)"
    }
    
    let customPoint = Point(x: 1, y: 2)
    switch customPoint {
    case "1,2":
        print("Point matches pattern '1,2'")
    case "0,0":
        print("Point is at origin")
    default:
        print("Point doesn't match any pattern")
    }
    
    // Matching with custom types
    enum HTTPStatus {
        case ok
        case notFound
        case serverError(Int)
    }
    
    let status = HTTPStatus.serverError(500)
    switch status {
    case .ok:
        print("OK")
    case .notFound:
        print("Not Found")
    case .serverError(500):
        print("Internal Server Error")
    case .serverError(let code):
        print("Server error with code: \(code)")
    }
}

// MARK: - Complex Pattern Combinations

func demonstrateComplexPatterns() {
    print("\n=== Complex Pattern Combinations ===")
    
    // Combining multiple pattern types
    let data: [(String?, Int?)] = [
        ("Alice", 25),
        ("Bob", nil),
        (nil, 30),
        ("Charlie", 35)
    ]
    
    for case let (name?, age?) in data {
        print("\(name) is \(age) years old")
    }
    
    // Pattern matching with where clause
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    for number in numbers {
        switch number {
        case let n where n % 2 == 0:
            print("\(n) is even")
        case let n where n % 2 != 0:
            print("\(n) is odd")
        default:
            break
        }
    }
    
    // Nested pattern matching
    let complexData: [(String, (Int, Int?))] = [
        ("point1", (1, 2)),
        ("point2", (3, nil)),
        ("point3", (5, 6))
    ]
    
    for case let (label, (x, y?)) in complexData {
        print("\(label): (\(x), \(y))")
    }
    
    // Pattern matching with type casting and optional
    let mixed: [Any?] = [1, "Hello", nil, 3.14, "World", nil]
    
    for item in mixed {
        switch item {
        case let str as String:
            print("String: \(str)")
        case let num as Int:
            print("Int: \(num)")
        case let double as Double:
            print("Double: \(double)")
        case nil:
            print("nil value")
        default:
            print("Unknown")
        }
    }
}

// MARK: - Pattern Matching in Different Contexts

func demonstratePatternMatchingContexts() {
    print("\n=== Pattern Matching in Different Contexts ===")
    
    // In if statement
    let value: Int? = 42
    if case let x? = value, x > 40 {
        print("Value is \(x) and greater than 40")
    }
    
    // In while statement
    var iterator = [1, 2, 3, nil, 5].makeIterator()
    while case let number? = iterator.next() {
        print("Processing: \(number)")
    }
    
    // In guard statement
    func processOptional(_ value: Int?) {
        guard case let x? = value else {
            print("No value to process")
            return
        }
        print("Processing value: \(x)")
    }
    processOptional(42)
    processOptional(nil)
    
    // In for-in statement
    let points = [(0, 0), (1, 0), (1, 1), (2, 0)]
    for case let (x, 0) in points {
        print("Point on x-axis: (\(x), 0)")
    }
    
    // In catch clause
    enum CustomError: Error {
        case invalidInput(String)
        case networkError(Int)
    }
    
    do {
        throw CustomError.invalidInput("Invalid data")
    } catch CustomError.invalidInput(let message) {
        print("Invalid input error: \(message)")
    } catch CustomError.networkError(let code) {
        print("Network error code: \(code)")
    } catch {
        print("Unknown error: \(error)")
    }
}

// MARK: - Run All Demonstrations

func runPatternExamples() {
    demonstrateWildcardPattern()
    demonstrateIdentifierPattern()
    demonstrateValueBindingPattern()
    demonstrateTuplePattern()
    demonstrateEnumerationCasePattern()
    demonstrateOptionalPattern()
    demonstrateTypeCastingPattern()
    demonstrateExpressionPattern()
    demonstrateComplexPatterns()
    demonstratePatternMatchingContexts()
}

// Uncomment to run examples:
// runPatternExamples()


