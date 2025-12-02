//
//  NestedTypes.swift
//  Swift Language Practice - Nested Types
//
//  This file contains examples demonstrating Swift nested types, including
//  nested enumerations, structures, classes, and protocols.
//

import Foundation

// MARK: - Introduction to Nested Types

// Enumerations are often created to support a specific class or structure's functionality. Similarly,
// it can be convenient to define utility structures purely for use within the context of a more
// complex type, and protocols that are normally used in conjunction with a specific type. To
// accomplish this, Swift enables you to define nested types, whereby you nest supporting types
// like enumerations, structures, and protocols within the definition of the type they support.

// To nest a type within another type, write its definition within the outer braces of the type it
// supports. Types can be nested to as many levels as are required.

// MARK: - Nested Types in Action

// The example below defines a structure called BlackjackCard, which models a playing card as used
// in the game of Blackjack. The BlackjackCard structure contains two nested enumeration types
// called Suit and Rank.

// In Blackjack, the Ace cards have a value of either one or eleven. This feature is represented
// by a structure called Values, which is nested within the Rank enumeration

struct BlackjackCard {
    
    // nested Suit enumeration
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
    // nested Rank enumeration
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        
        struct Values {
            let first: Int, second: Int?
        }
        
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard properties and methods
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

// The Suit enumeration describes the four common playing card suits, together with a raw Character
// value to represent their symbol.

// The Rank enumeration describes the thirteen possible playing card ranks, together with a raw Int
// value to represent their face value. (This raw Int value isn't used for the Jack, Queen, King,
// and Ace cards.)

// As mentioned above, the Rank enumeration defines a further nested structure of its own, called
// Values. This structure encapsulates the fact that most cards have one value, but the Ace card
// has two values. The Values structure defines two properties to represent this:
// - first, of type Int
// - second, of type Int?, or "optional Int"

// Rank also defines a computed property, values, which returns an instance of the Values structure.
// This computed property considers the rank of the card and initializes a new Values instance
// with appropriate values based on its rank. It uses special values for jack, queen, king, and
// ace. For the numeric cards, it uses the rank's raw Int value.

// The BlackjackCard structure itself has two properties — rank and suit. It also defines a computed
// property called description, which uses the values stored in rank and suit to build a description
// of the name and value of the card. The description property uses optional binding to check whether
// there's a second value to display, and if so, inserts additional description detail for that second
// value.

// Because BlackjackCard is a structure with no custom initializers, it has an implicit memberwise
// initializer, as described in Memberwise Initializers for Structure Types. You can use this
// initializer to initialize a new constant called theAceOfSpades

let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")
// Prints "theAceOfSpades: suit is ♠, value is 1 or 11"

// Even though Rank and Suit are nested within BlackjackCard, their type can be inferred from context,
// and so the initialization of this instance is able to refer to the enumeration cases by their case
// names (.ace and .spades) alone. In the example above, the description property correctly reports
// that the Ace of Spades has a value of 1 or 11.

// MARK: - Referring to Nested Types

// To use a nested type outside of its definition context, prefix its name with the name of the type
// it's nested within

let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
// heartsSymbol is "♡"

// For the example above, this enables the names of Suit, Rank, and Values to be kept deliberately
// short, because their names are naturally qualified by the context in which they're defined.

// MARK: - Additional Examples

// MARK: - Nested Types in Classes

class Vehicle {
    enum VehicleType {
        case car
        case truck
        case motorcycle
        case bicycle
    }
    
    enum FuelType {
        case gasoline
        case diesel
        case electric
        case hybrid
        case none
    }
    
    struct Engine {
        let type: FuelType
        let horsepower: Int
        let cylinders: Int
        
        var description: String {
            return "\(type) engine with \(horsepower) HP, \(cylinders) cylinders"
        }
    }
    
    let type: VehicleType
    let engine: Engine
    let make: String
    let model: String
    
    init(type: VehicleType, engine: Engine, make: String, model: String) {
        self.type = type
        self.engine = engine
        self.make = make
        self.model = model
    }
    
    var description: String {
        return "\(make) \(model) - \(type) with \(engine.description)"
    }
}

// Using nested types from outside
let carEngine = Vehicle.Engine(type: .gasoline, horsepower: 200, cylinders: 4)
let myCar = Vehicle(type: .car, engine: carEngine, make: "Toyota", model: "Camry")
print(myCar.description)

// MARK: - Nested Types in Enumerations

enum NetworkResponse {
    case success(Data)
    case failure(Error)
    
    enum Error: Swift.Error {
        case networkUnavailable
        case timeout
        case invalidResponse
        case serverError(Int)
        
        struct ErrorDetails {
            let code: Int
            let message: String
            let timestamp: Date
            
            var description: String {
                return "Error \(code): \(message) at \(timestamp)"
            }
        }
        
        var details: ErrorDetails {
            switch self {
            case .networkUnavailable:
                return ErrorDetails(code: 1001, message: "Network unavailable", timestamp: Date())
            case .timeout:
                return ErrorDetails(code: 1002, message: "Request timeout", timestamp: Date())
            case .invalidResponse:
                return ErrorDetails(code: 1003, message: "Invalid response", timestamp: Date())
            case .serverError(let code):
                return ErrorDetails(code: code, message: "Server error", timestamp: Date())
            }
        }
    }
}

// Using nested types
let networkError = NetworkResponse.Error.networkUnavailable
print(networkError.details.description)

// MARK: - Multiple Levels of Nesting

struct Company {
    struct Department {
        enum DepartmentType {
            case engineering
            case sales
            case marketing
            case hr
            
            struct Budget {
                let amount: Double
                let currency: String
                
                enum Allocation {
                    case fixed
                    case variable
                    case projectBased
                }
                
                let allocation: Allocation
            }
        }
        
        let name: String
        let type: DepartmentType
        let budget: DepartmentType.Budget
        
        struct Employee {
            enum Role {
                case manager
                case senior
                case junior
                case intern
            }
            
            let name: String
            let role: Role
            let salary: Double
        }
        
        var employees: [Employee] = []
    }
    
    let name: String
    var departments: [Department] = []
}

// Accessing deeply nested types
let budget = Company.Department.DepartmentType.Budget(
    amount: 1000000,
    currency: "USD",
    allocation: .fixed
)

let dept = Company.Department(
    name: "Engineering",
    type: .engineering,
    budget: budget
)

let employee = Company.Department.Employee(
    name: "John Doe",
    role: .manager,
    salary: 120000
)

// MARK: - Nested Protocols

struct BankAccount {
    enum AccountType {
        case checking
        case savings
        case investment
        
        protocol InterestRate {
            var rate: Double { get }
        }
        
        struct InterestRateInfo: InterestRate {
            let rate: Double
            let compoundingFrequency: CompoundingFrequency
            
            enum CompoundingFrequency {
                case daily
                case monthly
                case quarterly
                case annually
            }
        }
    }
    
    let accountNumber: String
    let type: AccountType
    var balance: Double
    
    func calculateInterest(rateInfo: AccountType.InterestRateInfo) -> Double {
        return balance * rateInfo.rate
    }
}

// MARK: - Nested Types with Associated Values

enum Message {
    enum Priority {
        case low
        case medium
        case high
        case urgent
    }
    
    enum Status {
        case pending
        case sent
        case delivered
        case failed(ErrorInfo)
        
        struct ErrorInfo {
            let code: Int
            let message: String
        }
    }
    
    case text(String, priority: Priority)
    case image(Data, priority: Priority)
    case video(URL, priority: Priority)
    
    var priority: Priority {
        switch self {
        case .text(_, let priority),
             .image(_, let priority),
             .video(_, let priority):
            return priority
        }
    }
}

// MARK: - Nested Types with Generics

struct Container<T> {
    enum ContainerType {
        case array
        case dictionary
        case set
    }
    
    struct Metadata {
        let type: ContainerType
        let count: Int
        let capacity: Int?
        
        enum Storage {
            case memory
            case disk
            case cloud
        }
        
        let storage: Storage
    }
    
    let items: T
    let metadata: Metadata
}

// MARK: - Nested Types in Extensions

extension BlackjackCard {
    enum CardColor {
        case red
        case black
        
        static func color(for suit: Suit) -> CardColor {
            switch suit {
            case .spades, .clubs:
                return .black
            case .hearts, .diamonds:
                return .red
            }
        }
    }
    
    var color: CardColor {
        return CardColor.color(for: suit)
    }
}

// MARK: - Practical Examples

// MARK: - Game Board Example

struct GameBoard {
    enum Piece {
        case empty
        case player(Player)
        case obstacle
        
        enum Player {
            case red
            case blue
            case green
            case yellow
        }
    }
    
    struct Position {
        let row: Int
        let column: Int
        
        enum Direction {
            case up
            case down
            case left
            case right
        }
        
        func move(_ direction: Direction) -> Position {
            switch direction {
            case .up:
                return Position(row: row - 1, column: column)
            case .down:
                return Position(row: row + 1, column: column)
            case .left:
                return Position(row: row, column: column - 1)
            case .right:
                return Position(row: row, column: column + 1)
            }
        }
    }
    
    var grid: [[Piece]] = []
    let size: Int
    
    init(size: Int) {
        self.size = size
        self.grid = Array(repeating: Array(repeating: .empty, count: size), count: size)
    }
}

// MARK: - API Client Example

class APIClient {
    enum HTTPMethod {
        case get
        case post
        case put
        case delete
        case patch
    }
    
    enum StatusCode {
        case success(Int)
        case clientError(Int)
        case serverError(Int)
        case unknown(Int)
        
        struct Response {
            let statusCode: Int
            let headers: [String: String]
            let body: Data?
        }
    }
    
    struct Request {
        let method: HTTPMethod
        let url: URL
        let headers: [String: String]?
        let body: Data?
        
        enum ContentType {
            case json
            case xml
            case formData
            case binary
        }
        
        let contentType: ContentType
    }
    
    func makeRequest(_ request: Request) -> StatusCode.Response {
        // Implementation would go here
        return StatusCode.Response(statusCode: 200, headers: [:], body: nil)
    }
}

// MARK: - Example Function Demonstrating All Nested Types Concepts

func demonstrateNestedTypes() {
    print("\n=== Demonstrating Swift Nested Types ===\n")
    
    // BlackjackCard example
    print("1. BlackjackCard with Nested Types:")
    let aceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
    print("   \(aceOfSpades.description)")
    
    let kingOfHearts = BlackjackCard(rank: .king, suit: .hearts)
    print("   \(kingOfHearts.description)")
    
    // Referring to nested types
    print("\n2. Referring to Nested Types:")
    let suitSymbol = BlackjackCard.Suit.diamonds.rawValue
    print("   Diamond suit symbol: \(suitSymbol)")
    
    let rankValue = BlackjackCard.Rank.queen.values.first
    print("   Queen value: \(rankValue)")
    
    // Vehicle example
    print("\n3. Nested Types in Classes:")
    let engine = Vehicle.Engine(type: .electric, horsepower: 300, cylinders: 0)
    let vehicle = Vehicle(type: .car, engine: engine, make: "Tesla", model: "Model 3")
    print("   \(vehicle.description)")
    
    // NetworkResponse example
    print("\n4. Nested Types in Enumerations:")
    let error = NetworkResponse.Error.timeout
    print("   Error details: \(error.details.description)")
    
    // Multiple levels of nesting
    print("\n5. Multiple Levels of Nesting:")
    let budget = Company.Department.DepartmentType.Budget(
        amount: 500000,
        currency: "USD",
        allocation: .projectBased
    )
    print("   Budget: \(budget.amount) \(budget.currency)")
    
    // Card color extension
    print("\n6. Nested Types in Extensions:")
    let card = BlackjackCard(rank: .ace, suit: .hearts)
    print("   Card color: \(card.color)")
    
    // Game board example
    print("\n7. Game Board with Nested Types:")
    var board = GameBoard(size: 8)
    let position = GameBoard.Position(row: 3, column: 4)
    let newPosition = position.move(.up)
    print("   Position: (\(position.row), \(position.column))")
    print("   Moved up: (\(newPosition.row), \(newPosition.column))")
    
    // API Client example
    print("\n8. API Client with Nested Types:")
    let request = APIClient.Request(
        method: .get,
        url: URL(string: "https://api.example.com")!,
        headers: ["Authorization": "Bearer token"],
        body: nil,
        contentType: .json
    )
    print("   Request method: \(request.method)")
    print("   Content type: \(request.contentType)")
    
    print("\n=== End of Demonstration ===\n")
}

// Uncomment to run the demonstration
// demonstrateNestedTypes()


