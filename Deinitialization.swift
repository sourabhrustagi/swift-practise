//
//  Deinitialization.swift
//  Swift Language Practice - Deinitialization
//
//  This file contains examples demonstrating Swift deinitializers, including
//  how they work, when they're called, and practical examples.
//

import Foundation

// MARK: - Introduction to Deinitialization

// A deinitializer is called immediately before a class instance is deallocated.
// You write deinitializers with the deinit keyword, similar to how initializers
// are written with the init keyword. Deinitializers are only available on class types.

// MARK: - How Deinitialization Works

// Swift automatically deallocates your instances when they're no longer needed,
// to free up resources. Swift handles the memory management of instances through
// automatic reference counting (ARC), as described in Automatic Reference Counting.
// Typically you don't need to perform manual cleanup when your instances are deallocated.
// However, when you are working with your own resources, you might need to perform
// some additional cleanup yourself. For example, if you create a custom class to open
// a file and write some data to it, you might need to close the file before the class
// instance is deallocated.

// Class definitions can have at most one deinitializer per class. The deinitializer
// doesn't take any parameters and is written without parentheses

class SimpleClass {
    var value: Int
    
    init(value: Int) {
        self.value = value
        print("SimpleClass initialized with value: \(value)")
    }
    
    deinit {
        // perform the deinitialization
        print("SimpleClass deinitialized (value was: \(value))")
    }
}

// Deinitializers are called automatically, just before instance deallocation takes place.
// You aren't allowed to call a deinitializer yourself. Superclass deinitializers are
// inherited by their subclasses, and the superclass deinitializer is called automatically
// at the end of a subclass deinitializer implementation. Superclass deinitializers are
// always called, even if a subclass doesn't provide its own deinitializer.

// Because an instance isn't deallocated until after its deinitializer is called, a
// deinitializer can access all properties of the instance it's called on and can modify
// its behavior based on those properties (such as looking up the name of a file that needs
// to be closed).

// MARK: - Deinitializers in Action

// Here's an example of a deinitializer in action. This example defines two new types,
// Bank and Player, for a simple game. The Bank class manages a made-up currency, which
// can never have more than 10,000 coins in circulation. There can only ever be one Bank
// in the game, and so the Bank is implemented as a class with type properties and methods
// to store and manage its current state

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

// Bank keeps track of the current number of coins it holds with its coinsInBank property.
// It also offers two methods — distribute(coins:) and receive(coins:) — to handle the
// distribution and collection of coins.

// The distribute(coins:) method checks that there are enough coins in the bank before
// distributing them. If there aren't enough coins, Bank returns a smaller number than
// the number that was requested (and returns zero if no coins are left in the bank).
// It returns an integer value to indicate the actual number of coins that were provided.

// The receive(coins:) method simply adds the received number of coins back into the bank's
// coin store.

// The Player class describes a player in the game. Each player has a certain number of
// coins stored in their purse at any time. This is represented by the player's coinsInPurse
// property

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

// Each Player instance is initialized with a starting allowance of a specified number of
// coins from the bank during initialization, although a Player instance may receive fewer
// than that number if not enough coins are available.

// The Player class defines a win(coins:) method, which retrieves a certain number of coins
// from the bank and adds them to the player's purse. The Player class also implements a
// deinitializer, which is called just before a Player instance is deallocated. Here, the
// deinitializer simply returns all of the player's coins to the bank

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// Prints "A new player has joined the game with 100 coins"
print("There are now \(Bank.coinsInBank) coins left in the bank")
// Prints "There are now 9900 coins left in the bank"

// A new Player instance is created, with a request for 100 coins if they're available.
// This Player instance is stored in an optional Player variable called playerOne. An
// optional variable is used here, because players can leave the game at any point. The
// optional lets you track whether there's currently a player in the game.

// Because playerOne is an optional, it's qualified with an exclamation point (!) when its
// coinsInPurse property is accessed to print its default number of coins, and whenever its
// win(coins:) method is called

playerOne!.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
// Prints "PlayerOne won 2000 coins & now has 2100 coins"
print("The bank now only has \(Bank.coinsInBank) coins left")
// Prints "The bank now only has 7900 coins left"

// Here, the player has won 2,000 coins. The player's purse now contains 2,100 coins, and
// the bank has only 7,900 coins left.

playerOne = nil
print("PlayerOne has left the game")
// Prints "PlayerOne has left the game"
print("The bank now has \(Bank.coinsInBank) coins")
// Prints "The bank now has 10000 coins"

// The player has now left the game. This is indicated by setting the optional playerOne
// variable to nil, meaning "no Player instance." At the point that this happens, the
// playerOne variable's reference to the Player instance is broken. No other properties or
// variables are still referring to the Player instance, and so it's deallocated in order
// to free up its memory. Just before this happens, its deinitializer is called automatically,
// and its coins are returned to the bank.

// MARK: - Additional Examples

// MARK: - File Handler Example

class FileHandler {
    var filename: String
    var isOpen: Bool = false
    
    init(filename: String) {
        self.filename = filename
        print("FileHandler initialized for: \(filename)")
        // Simulate opening a file
        isOpen = true
        print("File opened: \(filename)")
    }
    
    func write(_ data: String) {
        if isOpen {
            print("Writing to \(filename): \(data)")
        }
    }
    
    deinit {
        // Clean up: close the file
        if isOpen {
            print("Closing file: \(filename)")
            isOpen = false
        }
        print("FileHandler deinitialized for: \(filename)")
    }
}

// Example usage
var fileHandler: FileHandler? = FileHandler(filename: "data.txt")
fileHandler?.write("Some data")
fileHandler = nil  // Deinitializer is called here

// MARK: - Resource Manager Example

class ResourceManager {
    var resourceID: String
    var allocatedResources: [String] = []
    
    init(resourceID: String) {
        self.resourceID = resourceID
        print("ResourceManager initialized: \(resourceID)")
    }
    
    func allocate(_ resource: String) {
        allocatedResources.append(resource)
        print("Allocated resource: \(resource)")
    }
    
    deinit {
        // Release all allocated resources
        print("Releasing \(allocatedResources.count) resources for \(resourceID)")
        for resource in allocatedResources {
            print("  Releasing: \(resource)")
        }
        allocatedResources.removeAll()
        print("ResourceManager deinitialized: \(resourceID)")
    }
}

var resourceManager: ResourceManager? = ResourceManager(resourceID: "RM-001")
resourceManager?.allocate("Memory Block 1")
resourceManager?.allocate("Memory Block 2")
resourceManager?.allocate("Network Connection")
resourceManager = nil  // Deinitializer releases all resources

// MARK: - Inheritance and Deinitializers

class BaseClass {
    var baseValue: String
    
    init(baseValue: String) {
        self.baseValue = baseValue
        print("BaseClass initialized with: \(baseValue)")
    }
    
    deinit {
        print("BaseClass deinitialized (baseValue: \(baseValue))")
    }
}

class DerivedClass: BaseClass {
    var derivedValue: Int
    
    init(baseValue: String, derivedValue: Int) {
        self.derivedValue = derivedValue
        super.init(baseValue: baseValue)
        print("DerivedClass initialized with: \(derivedValue)")
    }
    
    deinit {
        print("DerivedClass deinitialized (derivedValue: \(derivedValue))")
        // Superclass deinitializer is called automatically after this
    }
}

// When a derived class instance is deallocated, the subclass deinitializer is called first,
// then the superclass deinitializer is called automatically
var derived: DerivedClass? = DerivedClass(baseValue: "Base", derivedValue: 42)
derived = nil
// Prints:
// DerivedClass deinitialized (derivedValue: 42)
// BaseClass deinitialized (baseValue: Base)

// MARK: - Network Connection Example

class NetworkConnection {
    var connectionID: String
    var isConnected: Bool = false
    
    init(connectionID: String) {
        self.connectionID = connectionID
        print("NetworkConnection initialized: \(connectionID)")
        // Simulate connection
        isConnected = true
        print("Connected: \(connectionID)")
    }
    
    func send(_ data: String) {
        if isConnected {
            print("Sending data via \(connectionID): \(data)")
        }
    }
    
    deinit {
        // Clean up: disconnect
        if isConnected {
            print("Disconnecting: \(connectionID)")
            isConnected = false
        }
        print("NetworkConnection deinitialized: \(connectionID)")
    }
}

var connection: NetworkConnection? = NetworkConnection(connectionID: "CONN-123")
connection?.send("Hello, World!")
connection = nil  // Deinitializer disconnects

// MARK: - Counter Example

class Counter {
    var count: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
        print("Counter '\(name)' initialized")
    }
    
    func increment() {
        count += 1
    }
    
    deinit {
        print("Counter '\(name)' deinitialized with final count: \(count)")
    }
}

var counter1: Counter? = Counter(name: "Counter1")
counter1?.increment()
counter1?.increment()
counter1?.increment()
counter1 = nil  // Deinitializer shows final count

// MARK: - Multiple References Example

class SharedResource {
    var resourceName: String
    
    init(resourceName: String) {
        self.resourceName = resourceName
        print("SharedResource '\(resourceName)' initialized")
    }
    
    deinit {
        print("SharedResource '\(resourceName)' deinitialized")
    }
}

// Multiple references to the same instance
var resource1: SharedResource? = SharedResource(resourceName: "Resource1")
var resource2: SharedResource? = resource1  // Same instance
var resource3: SharedResource? = resource1  // Same instance

print("Setting resource1 to nil")
resource1 = nil  // Deinitializer NOT called yet (still referenced by resource2 and resource3)

print("Setting resource2 to nil")
resource2 = nil  // Deinitializer NOT called yet (still referenced by resource3)

print("Setting resource3 to nil")
resource3 = nil  // Deinitializer IS called now (no more references)

// MARK: - Example Function Demonstrating All Deinitialization Concepts

func demonstrateDeinitialization() {
    print("\n=== Demonstrating Swift Deinitialization ===\n")
    
    // Simple deinitializer
    print("1. Simple Deinitializer:")
    var simple: SimpleClass? = SimpleClass(value: 100)
    simple = nil
    
    // Bank and Player example
    print("\n2. Bank and Player Example:")
    Bank.coinsInBank = 10_000  // Reset bank
    var player: Player? = Player(coins: 500)
    print("   Player has \(player!.coinsInPurse) coins")
    player!.win(coins: 1000)
    print("   Player now has \(player!.coinsInPurse) coins")
    print("   Bank has \(Bank.coinsInBank) coins")
    player = nil
    print("   Bank has \(Bank.coinsInBank) coins after player left")
    
    // File handler example
    print("\n3. File Handler Example:")
    var file: FileHandler? = FileHandler(filename: "example.txt")
    file?.write("Test data")
    file = nil
    
    // Resource manager example
    print("\n4. Resource Manager Example:")
    var manager: ResourceManager? = ResourceManager(resourceID: "MGR-001")
    manager?.allocate("Resource A")
    manager?.allocate("Resource B")
    manager = nil
    
    // Inheritance example
    print("\n5. Inheritance Example:")
    var derived: DerivedClass? = DerivedClass(baseValue: "Test", derivedValue: 10)
    derived = nil
    
    // Network connection example
    print("\n6. Network Connection Example:")
    var conn: NetworkConnection? = NetworkConnection(connectionID: "NET-001")
    conn?.send("Data packet")
    conn = nil
    
    // Counter example
    print("\n7. Counter Example:")
    var counter: Counter? = Counter(name: "MyCounter")
    for _ in 1...5 {
        counter?.increment()
    }
    counter = nil
    
    print("\n=== End of Demonstration ===\n")
}

// Uncomment to run the demonstration
// demonstrateDeinitialization()


