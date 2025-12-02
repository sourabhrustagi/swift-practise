//
//  Attributes.swift
//  Swift Language Practice - Attributes
//
//  This file contains examples demonstrating Swift attributes, which provide
//  additional information about declarations and types.
//

import Foundation

// MARK: - Introduction to Attributes

// Attributes provide additional information about declarations and types.
// There are two kinds of attributes in Swift:
// 1. Declaration attributes - apply to declarations
// 2. Type attributes - apply to types

// You specify an attribute by writing the @ symbol followed by the attribute's name
// and any arguments that the attribute accepts:
// @attributeName
// @attributeName(attributeArguments)

// MARK: - @discardableResult

// Suppresses compiler warning when a function that returns a value is called
// without using its result.

@discardableResult
func processData(_ data: String) -> String {
    print("Processing: \(data)")
    return "Processed: \(data)"
}

// No warning even though return value is not used
processData("test")
// Prints: Processing: test

// MARK: - @available

// Indicates a declaration's lifecycle relative to Swift language versions or platforms.

// Available on iOS 13.0 and later
@available(iOS 13.0, *)
class ModernFeature {
    func useModernAPI() {
        print("Using modern API")
    }
}

// Available on iOS 13.0, deprecated in iOS 15.0
@available(iOS 13.0, deprecated: 15.0, message: "Use ModernFeature instead")
class LegacyFeature {
    func useLegacyAPI() {
        print("Using legacy API")
    }
}

// Available on iOS 16.0, obsoleted in iOS 17.0
@available(iOS 16.0, obsoleted: 17.0)
class ObsoleteFeature {
    func useObsoleteAPI() {
        print("This feature is obsolete")
    }
}

// Swift version availability
@available(swift 5.5)
func asyncFunction() async {
    print("This requires Swift 5.5+")
}

// Multiple platform availability
@available(iOS 10.0, macOS 10.12, *)
class CrossPlatformClass {
    // class definition
}

// Unavailable on specific platform
@available(macOS, unavailable)
class iOSOnlyClass {
    // iOS only implementation
}

// MARK: - @available with noasync

// Prevents a symbol from being used directly in an asynchronous context

extension pthread_mutex_t {
    @available(*, noasync, message: "Use withLock instead in async contexts")
    mutating func lock() {
        pthread_mutex_lock(&self)
    }
    
    @available(*, noasync)
    mutating func unlock() {
        pthread_mutex_unlock(&self)
    }
    
    // Synchronous wrapper for safe use in async contexts
    mutating func withLock<T>(_ operation: () throws -> T) rethrows -> T {
        self.lock()
        defer { self.unlock() }
        return try operation()
    }
}

// MARK: - @backDeployed

// Includes a copy of the symbol's implementation in programs that call it
// for backward compatibility

@available(iOS 16, *)
@backDeployed(before: iOS 17)
func backDeployedFunction() {
    print("Available on iOS 16+ via back deployment")
}

// MARK: - @dynamicCallable

// Treats instances of a type as callable functions

@dynamicCallable
struct TelephoneExchange {
    func dynamicallyCall(withArguments phoneNumber: [Int]) {
        if phoneNumber == [4, 1, 1] {
            print("Get Swift help on forums.swift.org")
        } else {
            print("Unrecognized number")
        }
    }
}

let dial = TelephoneExchange()

// Use dynamic method call
dial(4, 1, 1)
// Prints: "Get Swift help on forums.swift.org"

dial(8, 6, 7, 5, 3, 0, 9)
// Prints: "Unrecognized number"

// Call the underlying method directly
dial.dynamicallyCall(withArguments: [4, 1, 1])

// Dynamic callable with keyword arguments
@dynamicCallable
struct Repeater {
    func dynamicallyCall(withKeywordArguments pairs: KeyValuePairs<String, Int>) -> String {
        return pairs
            .map { label, count in
                repeatElement(label, count: count).joined(separator: " ")
            }
            .joined(separator: "\n")
    }
}

let repeatLabels = Repeater()
print(repeatLabels(a: 1, b: 2, c: 3, b: 2, a: 1))
// a
// b b
// c c c
// b b
// a

// MARK: - @dynamicMemberLookup

// Enables members to be looked up by name at runtime

@dynamicMemberLookup
struct DynamicStruct {
    let dictionary = ["someDynamicMember": 325,
                      "someOtherMember": 787]
    
    subscript(dynamicMember member: String) -> Int {
        return dictionary[member] ?? 1054
    }
}

let s = DynamicStruct()

// Use dynamic member lookup
let dynamic = s.someDynamicMember
print(dynamic)
// Prints: "325"

// Call the underlying subscript directly
let equivalent = s[dynamicMember: "someDynamicMember"]
print(dynamic == equivalent)
// Prints: "true"

// Dynamic member lookup with key paths
struct Point {
    var x, y: Int
}

@dynamicMemberLookup
struct PassthroughWrapper<Value> {
    var value: Value
    
    subscript<T>(dynamicMember member: KeyPath<Value, T>) -> T {
        get { return value[keyPath: member] }
    }
}

let point = Point(x: 381, y: 431)
let wrapper = PassthroughWrapper(value: point)
print(wrapper.x)  // 381
print(wrapper.y)  // 431

// MARK: - @propertyWrapper

// Creates a custom attribute that wraps access to a property

@propertyWrapper
struct Clamped<Value: Comparable> {
    private var value: Value
    private let range: ClosedRange<Value>
    
    var wrappedValue: Value {
        get { value }
        set { value = min(max(range.lowerBound, newValue), range.upperBound) }
    }
    
    init(wrappedValue: Value, _ range: ClosedRange<Value>) {
        self.range = range
        self.value = min(max(range.lowerBound, wrappedValue), range.upperBound)
    }
}

struct Game {
    @Clamped(0...100) var health: Int = 100
    @Clamped(0...100) var mana: Int = 50
}

var game = Game()
game.health = 150  // Clamped to 100
print(game.health)  // 100
game.health = -10   // Clamped to 0
print(game.health)  // 0

// Property wrapper with projected value
@propertyWrapper
struct WrapperWithProjection {
    var wrappedValue: Int
    var projectedValue: Projection {
        return Projection(wrapper: self)
    }
}

struct Projection {
    var wrapper: WrapperWithProjection
}

struct SomeStruct {
    @WrapperWithProjection var x = 123
}

let structInstance = SomeStruct()
structInstance.x           // Int value: 123
structInstance.$x          // Projection value
structInstance.$x.wrapper  // WrapperWithProjection value

// MARK: - @resultBuilder

// Builds a nested data structure step by step (used for DSLs)

@resultBuilder
struct ArrayBuilder {
    typealias Component = [Int]
    typealias Expression = Int
    
    static func buildExpression(_ element: Expression) -> Component {
        return [element]
    }
    
    static func buildOptional(_ component: Component?) -> Component {
        guard let component = component else { return [] }
        return component
    }
    
    static func buildEither(first component: Component) -> Component {
        return component
    }
    
    static func buildEither(second component: Component) -> Component {
        return component
    }
    
    static func buildArray(_ components: [Component]) -> Component {
        return Array(components.joined())
    }
    
    static func buildBlock(_ components: Component...) -> Component {
        return Array(components.joined())
    }
}

// Using the result builder
@ArrayBuilder var builderNumber: [Int] {
    10
}

@ArrayBuilder var builderBlock: [Int] {
    100
    200
    300
}

let someNumber = 19
@ArrayBuilder var builderConditional: [Int] {
    if someNumber < 12 {
        31
    } else if someNumber == 19 {
        32
    } else {
        33
    }
}

@ArrayBuilder var builderArray: [Int] {
    for i in 5...7 {
        100 + i
    }
}

print(builderBlock)  // [100, 200, 300]
print(builderConditional)  // [32]
print(builderArray)  // [105, 106, 107]

// MARK: - @main

// Indicates the top-level entry point for program flow

@main
struct MyTopLevel {
    static func main() {
        print("This is the entry point")
    }
}

// MARK: - @objc

// Makes a declaration available to Objective-C code

@objc class ExampleClass: NSObject {
    @objc var enabled: Bool {
        @objc(isEnabled) get {
            return true
        }
    }
    
    @objc func exampleMethod() {
        print("Available in Objective-C")
    }
}

// @objc with enumeration
@objc enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}

// MARK: - @objcMembers

// Implicitly applies @objc to all Objective-C compatible members

@objcMembers
class ObjectiveCCompatibleClass: NSObject {
    var property: String = ""
    func method() {}
}

// MARK: - @inlinable

// Exposes the implementation as part of the module's public interface

@inlinable
public func inlinableFunction(_ value: Int) -> Int {
    return value * 2
}

// MARK: - @usableFromInline

// Allows a symbol to be used in inlinable code in the same module

internal struct InternalStruct {
    @usableFromInline
    internal var value: Int
    
    @usableFromInline
    internal init(value: Int) {
        self.value = value
    }
}

@inlinable
public func usesInternalStruct() -> Int {
    let s = InternalStruct(value: 42)
    return s.value
}

// MARK: - @frozen

// Restricts changes to structures and enumerations (library evolution mode)

@frozen
public enum FrozenEnum {
    case first
    case second
    case third
}

// Switch over frozen enum doesn't require default case
func handleFrozenEnum(_ value: FrozenEnum) {
    switch value {
    case .first:
        print("First")
    case .second:
        print("Second")
    case .third:
        print("Third")
    }
}

// MARK: - @globalActor

// Generalizes actor isolation to state spread across code

@globalActor
actor MyGlobalActor {
    static let shared = MyGlobalActor()
}

@MyGlobalActor
var globalState: Int = 0

@MyGlobalActor
func updateGlobalState() {
    globalState += 1
}

// MARK: - @preconcurrency

// Suppresses strict concurrency checking

@preconcurrency
import SomeModule

@preconcurrency
func legacyFunction() {
    // Legacy code that doesn't fully support concurrency
}

// MARK: - @warn_unqualified_access

// Triggers warnings when function is used without a qualifier

@warn_unqualified_access
func min(_ a: Int, _ b: Int) -> Int {
    return a < b ? a : b
}

extension Array where Element: Comparable {
    func min() -> Element? {
        return self.min(by: <)
    }
}

// MARK: - Type Attributes

// MARK: - @autoclosure

// Delays evaluation by automatically wrapping expression in a closure

func logIfTrue(_ predicate: @autoclosure () -> Bool) {
    if predicate() {
        print("Condition is true")
    }
}

let condition = true
logIfTrue(condition)  // condition is automatically wrapped in a closure
logIfTrue(2 > 1)      // expression is automatically wrapped

// MARK: - @convention

// Specifies function calling conventions

// Swift function reference (default)
let swiftFunction: @convention(swift) (Int) -> Int = { $0 * 2 }

// C function reference
let cFunction: @convention(c) (Int32) -> Int32 = { $0 * 2 }

// Objective-C block reference
let blockFunction: @convention(block) (Int) -> Int = { $0 * 2 }

// MARK: - @escaping

// Indicates a closure parameter can be stored for later execution

func performAsyncOperation(completion: @escaping () -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
        completion()  // completion escapes the function scope
    }
}

class AsyncHandler {
    var completion: (() -> Void)?
    
    func setup(completion: @escaping () -> Void) {
        self.completion = completion
    }
}

// MARK: - @Sendable

// Indicates a function or closure is sendable

func sendableFunction() -> @Sendable (Int) -> Int {
    return { $0 * 2 }
}

let sendableClosure: @Sendable (String) -> Void = { message in
    print(message)
}

// MARK: - Switch Case Attributes

// MARK: - @unknown

// Indicates a switch case isn't expected to be matched at compile time

enum FutureEnum {
    case known
    case anotherKnown
}

func handleEnum(_ value: FutureEnum) {
    switch value {
    case .known:
        print("Known case")
    case .anotherKnown:
        print("Another known case")
    @unknown default:
        print("Future case not yet known")
    }
}

// MARK: - @attached (Macros)

// Apply to macro declarations to indicate the macro's role

// Example macro roles (these would be defined elsewhere):
// @attached(peer, names: named(helper))
// @attached(member, names: arbitrary)
// @attached(memberAttribute)
// @attached(accessor, names: named(get), named(set))
// @attached(extension, conformances: Equatable, Hashable)

// MARK: - @freestanding (Macros)

// Apply to freestanding macro declarations

// Example (would be defined elsewhere):
// @freestanding(expression)
// macro myMacro() -> String

// MARK: - Property Wrapper Examples

// UserDefaults wrapper
@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct Settings {
    @UserDefault(key: "username", defaultValue: "Guest")
    var username: String
    
    @UserDefault(key: "isFirstLaunch", defaultValue: true)
    var isFirstLaunch: Bool
}

// MARK: - Result Builder Example: HTML Builder

protocol HTMLNode {
    func render() -> String
}

struct TextNode: HTMLNode {
    let content: String
    func render() -> String { content }
}

struct ElementNode: HTMLNode {
    let tag: String
    let children: [HTMLNode]
    
    func render() -> String {
        let childrenHTML = children.map { $0.render() }.joined()
        return "<\(tag)>\(childrenHTML)</\(tag)>"
    }
}

@resultBuilder
struct HTMLBuilder {
    static func buildBlock(_ components: HTMLNode...) -> [HTMLNode] {
        Array(components)
    }
    
    static func buildExpression(_ expression: String) -> HTMLNode {
        TextNode(content: expression)
    }
    
    static func buildExpression(_ expression: HTMLNode) -> HTMLNode {
        expression
    }
    
    static func buildArray(_ components: [[HTMLNode]]) -> [HTMLNode] {
        Array(components.joined())
    }
}

func html(@HTMLBuilder content: () -> [HTMLNode]) -> String {
    let nodes = content()
    return nodes.map { $0.render() }.joined(separator: "\n")
}

// Usage example:
let htmlContent = html {
    "Hello, "
    "World!"
    ElementNode(tag: "div", children: [
        TextNode(content: "Nested content")
    ])
}

// MARK: - Summary

// Attributes in Swift provide metadata and behavior modifications:
// - Declaration attributes modify how declarations work
// - Type attributes modify type behavior
// - Switch case attributes provide additional information about cases
// - Attributes can accept arguments to customize their behavior
// - Some attributes are used by the compiler, others by frameworks


