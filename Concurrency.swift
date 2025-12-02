//
//  Concurrency.swift
//  Swift Language Practice - Concurrency
//
//  This file contains examples demonstrating Swift concurrency, including
//  async/await, tasks, actors, and structured concurrency.
//

import Foundation

// MARK: - Introduction to Concurrency

// Swift has built-in support for writing asynchronous and parallel code in a structured way.
// Asynchronous code can be suspended and resumed later, although only one piece of the program
// executes at a time. Suspending and resuming code in your program lets it continue to make
// progress on short-term operations like updating its UI while continuing to work on long-running
// operations like fetching data over the network or parsing files.

// Parallel code means multiple pieces of code run simultaneously — for example, a computer with
// a four-core processor can run four pieces of code at the same time, with each core carrying out
// one of the tasks. A program that uses parallel and asynchronous code carries out multiple
// operations at a time, and it suspends operations that are waiting for an external system.

// The additional scheduling flexibility from parallel or asynchronous code also comes with a cost
// of increased complexity. When you write concurrent code, you don't know ahead of time what code
// will run at the same time, and you might not always know the order that code will run. A common
// problem in concurrent code happens when multiple pieces of code try to access some piece of
// shared mutable state — this is known as a data race. When you use the language-level support
// for concurrency, Swift detects and prevents data races, and most data races produce a compile-time
// error.

// Note: If you've written concurrent code before, you might be used to working with threads. The
// concurrency model in Swift is built on top of threads, but you don't interact with them directly.
// An asynchronous function in Swift can give up the thread that it's running on, which lets another
// asynchronous function run on that thread while the first function is blocked.

// MARK: - Defining and Calling Asynchronous Functions

// An asynchronous function or asynchronous method is a special kind of function or method that can
// be suspended while it's partway through execution. This is in contrast to ordinary, synchronous
// functions and methods, which either run to completion, throw an error, or never return. An
// asynchronous function or method still does one of those three things, but it can also pause in
// the middle when it's waiting for something.

// To indicate that a function or method is asynchronous, you write the async keyword in its
// declaration after its parameters, similar to how you use throws to mark a throwing function.
// If the function or method returns a value, you write async before the return arrow (->)

func listPhotos(inGallery name: String) async -> [String] {
    // Simulate asynchronous networking code
    try? await Task.sleep(for: .seconds(0.1))
    return ["IMG001", "IMG99", "IMG0404"]
}

// For a function or method that's both asynchronous and throwing, you write async before throws

func listPhotosWithError(inGallery name: String) async throws -> [String] {
    try await Task.sleep(for: .seconds(2))
    return ["IMG001", "IMG99", "IMG0404"]
}

// When calling an asynchronous method, execution suspends until that method returns. You write
// await in front of the call to mark the possible suspension point. This is like writing try when
// calling a throwing function, to mark the possible change to the program's flow if there's an error.

// For example, the code below fetches the names of all the pictures in a gallery and then shows
// the first picture

func downloadPhoto(named name: String) async -> String {
    // Simulate downloading a photo
    try? await Task.sleep(for: .seconds(0.5))
    return "Photo data for \(name)"
}

func show(_ photo: String) {
    print("Showing photo: \(photo)")
}

// Example of calling asynchronous functions
func exampleAsyncCall() async {
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    let sortedNames = photoNames.sorted()
    let name = sortedNames[0]
    let photo = await downloadPhoto(named: name)
    show(photo)
}

// The Task.sleep(for:tolerance:clock:) method is useful when writing simple code to learn how
// concurrency works. This method suspends the current task for at least the given amount of time

// MARK: - Asynchronous Sequences

// The listPhotos(inGallery:) function in the previous section asynchronously returns the whole
// array at once, after all of the array's elements are ready. Another approach is to wait for one
// element of the collection at a time using an asynchronous sequence.

// Instead of using an ordinary for-in loop, you write for with await after it. Like when you call
// an asynchronous function or method, writing await indicates a possible suspension point. A
// for-await-in loop potentially suspends execution at the beginning of each iteration, when it's
// waiting for the next element to be available.

// Example with async sequence (simulated)
struct AsyncSequenceExample {
    static func processLines() async throws {
        // Simulated async sequence
        let lines = ["Line 1", "Line 2", "Line 3"]
        for line in lines {
            print(line)
            try? await Task.sleep(for: .milliseconds(100))
        }
    }
}

// MARK: - Calling Asynchronous Functions in Parallel

// Calling an asynchronous function with await runs only one piece of code at a time. While the
// asynchronous code is running, the caller waits for that code to finish before moving on to run
// the next line of code.

// Sequential approach (one at a time)
func downloadPhotosSequentially(photoNames: [String]) async -> [String] {
    var photos: [String] = []
    for name in photoNames.prefix(3) {
        let photo = await downloadPhoto(named: name)
        photos.append(photo)
    }
    return photos
}

// To call an asynchronous function and let it run in parallel with code around it, write async
// in front of let when you define a constant, and then write await each time you use the constant

// Parallel approach (all at once)
func downloadPhotosInParallel(photoNames: [String]) async -> [String] {
    async let firstPhoto = downloadPhoto(named: photoNames[0])
    async let secondPhoto = downloadPhoto(named: photoNames[1])
    async let thirdPhoto = downloadPhoto(named: photoNames[2])
    
    let photos = await [firstPhoto, secondPhoto, thirdPhoto]
    return photos
}

// In this example, all three calls to downloadPhoto(named:) start without waiting for the previous
// one to complete. If there are enough system resources available, they can run at the same time.
// None of these function calls are marked with await because the code doesn't suspend to wait for
// the function's result. Instead, execution continues until the line where photos is defined — at
// that point, the program needs the results from these asynchronous calls, so you write await to
// pause execution until all three photos finish downloading.

// MARK: - Tasks and Task Groups

// A task is a unit of work that can be run asynchronously as part of your program. All asynchronous
// code runs as part of some task. A task itself does only one thing at a time, but when you create
// multiple tasks, Swift can schedule them to run simultaneously.

// The async-let syntax described in the previous section implicitly creates a child task — this
// syntax works well when you already know what tasks your program needs to run. You can also create
// a task group (an instance of TaskGroup) and explicitly add child tasks to that group, which gives
// you more control over priority and cancellation, and lets you create a dynamic number of tasks.

// Tasks are arranged in a hierarchy. Each task in a given task group has the same parent task, and
// each task can have child tasks. Because of the explicit relationship between tasks and task groups,
// this approach is called structured concurrency.

// Here's another version of the code to download photos that handles any number of photos

func downloadAllPhotos(inGallery name: String) async {
    await withTaskGroup(of: String.self) { group in
        let photoNames = await listPhotos(inGallery: name)
        
        for name in photoNames {
            group.addTask {
                return await downloadPhoto(named: name)
            }
        }
        
        for await photo in group {
            show(photo)
        }
    }
}

// The code above creates a new task group, and then creates child tasks to download each photo in
// the gallery. Swift runs as many of these tasks concurrently as conditions allow. As soon as a child
// task finishes downloading a photo, that photo is displayed. There's no guarantee about the order
// that child tasks complete, so the photos from this gallery can be shown in any order.

// For a task group that returns a result, you add code that accumulates its result inside the
// closure you pass to withTaskGroup(of:returning:body:)

func downloadAllPhotosWithResults(inGallery name: String) async -> [String] {
    let photos = await withTaskGroup(of: String.self) { group in
        let photoNames = await listPhotos(inGallery: name)
        
        for name in photoNames {
            group.addTask {
                return await downloadPhoto(named: name)
            }
        }
        
        var results: [String] = []
        for await photo in group {
            results.append(photo)
        }
        
        return results
    }
    return photos
}

// MARK: - Task Cancellation

// Swift concurrency uses a cooperative cancellation model. Each task checks whether it has been
// canceled at the appropriate points in its execution, and responds to cancellation appropriately.

// Downloading pictures could take a long time if the pictures are large or the network is slow.
// To let the user stop this work, without waiting for all of the tasks to complete, the tasks
// need to check for cancellation and stop running if they are canceled. There are two ways a task
// can do this: by calling the Task.checkCancellation() type method, or by reading the Task.isCancelled
// type property.

func downloadPhotosWithCancellation(inGallery name: String) async -> [String] {
    let photos = await withTaskGroup(of: String?.self) { group in
        let photoNames = await listPhotos(inGallery: name)
        
        for name in photoNames {
            let added = group.addTaskUnlessCancelled {
                Task.isCancelled ? nil : await downloadPhoto(named: name)
            }
            guard added else { break }
        }
        
        var results: [String] = []
        for await photo in group {
            if let photo {
                results.append(photo)
            }
        }
        return results
    }
    return photos
}

// MARK: - Unstructured Concurrency

// In addition to the structured approaches to concurrency described in the previous sections, Swift
// also supports unstructured concurrency. Unlike tasks that are part of a task group, an unstructured
// task doesn't have a parent task. You have complete flexibility to manage unstructured tasks in
// whatever way your program needs, but you're also completely responsible for their correctness.

// To create an unstructured task that runs similarly to the surrounding code, call the
// Task.init(name:priority:operation:) initializer

func add(_ photo: String, toGalleryNamed name: String) async -> String {
    try? await Task.sleep(for: .seconds(0.1))
    return "Added \(photo) to \(name)"
}

func exampleUnstructuredTask() async {
    let newPhoto = "NewPhoto.jpg"
    let handle = Task {
        return await add(newPhoto, toGalleryNamed: "Spring Adventures")
    }
    let result = await handle.value
    print(result)
}

// MARK: - Isolation

// The previous sections discuss approaches for splitting up concurrent work. That work can involve
// changing shared data, such as an app's UI. If different parts of your code can modify the same
// data at the same time, that risks creating a data race. Swift protects you from data races in
// your code: Whenever you read or modify a piece of data, Swift ensures that no other code is
// modifying it concurrently. This guarantee is called data isolation.

// There are three main ways to isolate data:
// 1. Immutable data is always isolated. Because you can't modify a constant, there's no risk of
//    other code modifying a constant at the same time you're reading it.
// 2. Data that's referenced by only the current task is always isolated. A local variable is safe
//    to read and write because no code outside the task has a reference to that memory.
// 3. Data that's protected by an actor is isolated if the code accessing that data is also isolated
//    to the actor.

// MARK: - The Main Actor

// An actor is an object that protects access to mutable data by forcing code to take turns accessing
// that data. The most important actor in many programs is the main actor. In an app, the main actor
// protects all of the data that's used to show the UI. The main actor takes turns rendering the UI,
// handling UI events, and running code that you write that needs to query or update the UI.

// There are several ways to run work on the main actor. To ensure a function always runs on the main
// actor, mark it with the @MainActor attribute

@MainActor
func showPhoto(_ photo: String) {
    // ... UI code to display the photo ...
    print("Displaying photo on main actor: \(photo)")
}

// In the code above, the @MainActor attribute on the showPhoto(_:) function requires this function
// to run only on the main actor. Within other code that's running on the main actor, you can call
// showPhoto(_:) as a synchronous function. However, to call showPhoto(_:) from code that isn't
// running on the main actor, you have to include await and call it as an asynchronous function

func downloadAndShowPhoto(named name: String) async {
    let photo = await downloadPhoto(named: name)
    await showPhoto(photo)
}

// To ensure that a closure runs on the main actor, you write @MainActor before the capture list and
// before in, at the start of the closure

func exampleMainActorClosure() async {
    let photo = await downloadPhoto(named: "Trees at Sunrise")
    Task { @MainActor in
        showPhoto(photo)
    }
}

// You can also write @MainActor on a structure, class, or enumeration to ensure all of its methods
// and all access to its properties run on the main actor

@MainActor
struct PhotoGallery {
    var photoNames: [String]
    
    func drawUI() {
        // ... other UI code ...
        print("Drawing UI with \(photoNames.count) photos")
    }
}

// For more fine-grained control, you can write @MainActor on just the properties or methods that
// need to be accessed or run on the main thread

struct PhotoGalleryFineGrained {
    @MainActor var photoNames: [String]
    var hasCachedPhotos = false
    
    @MainActor func drawUI() {
        // ... UI code ...
        print("Drawing UI")
    }
    
    func cachePhotos() {
        // ... networking code ...
        print("Caching photos")
    }
}

// MARK: - Actors

// Swift provides the main actor for you — you can also define your own actors. Actors let you safely
// share information between concurrent code.

// Like classes, actors are reference types, so the comparison of value types and reference types
// in Classes Are Reference Types applies to actors as well as classes. Unlike classes, actors allow
// only one task to access their mutable state at a time, which makes it safe for code in multiple
// tasks to interact with the same instance of an actor.

// For example, here's an actor that records temperatures

actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int
    
    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}

// You introduce an actor with the actor keyword, followed by its definition in a pair of braces.
// The TemperatureLogger actor has properties that other code outside the actor can access, and
// restricts the max property so only code inside the actor can update the maximum value.

// You create an instance of an actor using the same initializer syntax as structures and classes.
// When you access a property or method of an actor, you use await to mark the potential suspension
// point

func exampleActorAccess() async {
    let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
    print(await logger.max)
    // Prints "25"
}

// In this example, accessing logger.max is a possible suspension point. Because the actor allows
// only one task at a time to access its mutable state, if code from another task is already
// interacting with the logger, this code suspends while it waits to access the property.

// In contrast, code that's part of the actor doesn't write await when accessing the actor's
// properties. For example, here's a method that updates a TemperatureLogger with a new temperature

extension TemperatureLogger {
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}

// The update(with:) method is already running on the actor, so it doesn't mark its access to
// properties like max with await. This method also shows one of the reasons why actors allow only
// one task at a time to interact with their mutable state: Some updates to an actor's state
// temporarily break invariants.

// If code outside the actor tries to access those properties directly, like accessing a structure
// or class's properties, you'll get a compile-time error. For example:
// print(logger.max)  // Error - must use await

// Code that interacts with an actor's local state runs only on that actor. An actor runs only one
// piece of code at a time. Because of these guarantees, code that doesn't include await and that's
// inside an actor can make the updates without a risk of other places in your program observing the
// temporarily invalid state.

extension TemperatureLogger {
    func convertFahrenheitToCelsius() {
        for i in measurements.indices {
            measurements[i] = (measurements[i] - 32) * 5 / 9
        }
    }
}

// The code above converts the array of measurements, one at a time. While the conversion operation
// is in progress, some temperatures are in Fahrenheit and others are in Celsius. However, because
// none of the code includes await, there are no potential suspension points in this method. The
// state that this method modifies belongs to the actor, which protects it against code reading or
// modifying it except when that code runs on the actor.

// MARK: - Sendable Types

// Tasks and actors let you divide a program into pieces that can safely run concurrently. Inside of
// a task or an instance of an actor, the part of a program that contains mutable state, like
// variables and properties, is called a concurrency domain. Some kinds of data can't be shared
// between concurrency domains, because that data contains mutable state, but it doesn't protect
// against overlapping access.

// A type that can be shared from one concurrency domain to another is known as a sendable type.
// For example, it can be passed as an argument when calling an actor method or be returned as the
// result of a task.

// You mark a type as being sendable by declaring conformance to the Sendable protocol. That protocol
// doesn't have any code requirements, but it does have semantic requirements that Swift enforces.

// Some types are always sendable, like structures that have only sendable properties and enumerations
// that have only sendable associated values

struct TemperatureReading: Sendable {
    var measurement: Int
}

extension TemperatureLogger {
    func addReading(from reading: TemperatureReading) {
        measurements.append(reading.measurement)
    }
}

// Because TemperatureReading is a structure that has only sendable properties, and the structure
// isn't marked public or @usableFromInline, it's implicitly sendable. Here's a version of the
// structure where conformance to the Sendable protocol is implied

struct TemperatureReadingImplicit {
    var measurement: Int
    // Implicitly Sendable
}

// To explicitly mark a type as not being sendable, write an unavailable conformance to Sendable

struct FileDescriptor {
    let rawValue: Int
}

@available(*, unavailable)
extension FileDescriptor: Sendable {}

// MARK: - Additional Examples

// MARK: - Throwing Task Group

func downloadPhotosWithThrowingTaskGroup(inGallery name: String) async throws -> [String] {
    let photos = try await withThrowingTaskGroup(of: String.self) { group in
        let photoNames = try await listPhotosWithError(inGallery: name)
        
        for name in photoNames {
            group.addTask {
                return await downloadPhoto(named: name)
            }
        }
        
        var results: [String] = []
        for try await photo in group {
            results.append(photo)
        }
        
        return results
    }
    return photos
}

// MARK: - Task with Cancellation Handler

func exampleTaskWithCancellationHandler() async {
    let task = await Task.withTaskCancellationHandler {
        // Some work
        try? await Task.sleep(for: .seconds(1))
        return "Task completed"
    } onCancel: {
        print("Task was canceled!")
    }
    
    // Later, you could cancel it:
    // task.cancel()
    let result = await task.value
    print(result)
}

// MARK: - Detached Task

func exampleDetachedTask() async {
    let detachedTask = Task.detached {
        return await downloadPhoto(named: "DetachedPhoto")
    }
    
    let result = await detachedTask.value
    print("Detached task result: \(result)")
}

// MARK: - Example Function Demonstrating All Concurrency Concepts

func demonstrateConcurrency() async {
    print("\n=== Demonstrating Swift Concurrency ===\n")
    
    // Basic async function
    print("1. Basic Async Function:")
    let photos = await listPhotos(inGallery: "Vacation")
    print("   Photos: \(photos)")
    
    // Async with throwing
    print("\n2. Async Throwing Function:")
    do {
        let photosWithError = try await listPhotosWithError(inGallery: "Summer")
        print("   Photos: \(photosWithError)")
    } catch {
        print("   Error: \(error)")
    }
    
    // Parallel downloads
    print("\n3. Parallel Downloads (async let):")
    if photos.count >= 3 {
        async let photo1 = downloadPhoto(named: photos[0])
        async let photo2 = downloadPhoto(named: photos[1])
        async let photo3 = downloadPhoto(named: photos[2])
        
        let downloadedPhotos = await [photo1, photo2, photo3]
        print("   Downloaded \(downloadedPhotos.count) photos in parallel")
    }
    
    // Task group
    print("\n4. Task Group:")
    await downloadAllPhotos(inGallery: "Vacation")
    
    // Actor
    print("\n5. Actor:")
    let logger = TemperatureLogger(label: "Kitchen", measurement: 20)
    print("   Initial max: \(await logger.max)")
    await logger.update(with: 25)
    print("   Updated max: \(await logger.max)")
    
    // Main actor
    print("\n6. Main Actor:")
    await downloadAndShowPhoto(named: "Sunset")
    
    // Sendable type
    print("\n7. Sendable Type:")
    let reading = TemperatureReading(measurement: 30)
    await logger.addReading(from: reading)
    print("   Added reading: \(reading.measurement)")
    
    print("\n=== End of Demonstration ===\n")
}

// Uncomment to run the demonstration
// Task {
//     await demonstrateConcurrency()
// }


