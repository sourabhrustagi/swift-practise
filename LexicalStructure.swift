//
//  LexicalStructure.swift
//  Swift Language Practice - Lexical Structure
//
//  This file contains examples demonstrating Swift lexical structure, including
//  whitespace, comments, identifiers, keywords, literals, and operators.
//

import Foundation

// MARK: - Introduction to Lexical Structure

// The lexical structure of Swift describes what sequence of characters form valid tokens of the
// language. These valid tokens form the lowest-level building blocks of the language and are
// used to describe the rest of the language in subsequent chapters. A token consists of an
// identifier, keyword, punctuation, literal, or operator.

// In most cases, tokens are generated from the characters of a Swift source file by considering
// the longest possible substring from the input text, within the constraints of the grammar that
// are specified below. This behavior is referred to as longest match or maximal munch.

// MARK: - Whitespace and Comments

// Whitespace has two uses: to separate tokens in the source file and to distinguish between prefix,
// postfix, and infix operators (see Operators), but is otherwise ignored. The following characters
// are considered whitespace: space (U+0020), line feed (U+000A), carriage return (U+000D),
// horizontal tab (U+0009), vertical tab (U+000B), form feed (U+000C) and null (U+0000).

// Comments are treated as whitespace by the compiler. Single line comments begin with // and
// continue until a line feed (U+000A) or carriage return (U+000D). Multiline comments begin with
// /* and end with */. Nesting multiline comments is allowed, but the comment markers must be
// balanced.

// Single-line comment
// This is a single-line comment that continues until the end of the line

/* This is a multiline comment
   that can span multiple lines */

/* This is a multiline comment
   /* that can be nested */
   with nested comments */

// Comments can contain additional formatting and markup, as described in Markup Formatting
// Reference.

// MARK: - Identifiers

// Identifiers begin with an uppercase or lowercase letter A through Z, an underscore (_), a
// noncombining alphanumeric Unicode character in the Basic Multilingual Plane, or a character
// outside the Basic Multilingual Plane that isn't in a Private Use Area. After the first
// character, digits and combining Unicode characters are also allowed.

// Valid identifiers
let myVariable = 42
let _privateVariable = 10
let variable123 = 20
let π = 3.14159
let 你好 = "Hello"
let café = "coffee"

// Treat identifiers that begin with an underscore, subscripts whose first argument label begins
// with an underscore, and initializers whose first argument label begins with an underscore, as
// internal, even if their declaration has the public access-level modifier. This convention lets
// framework authors mark part of an API that clients must not interact with or depend on, even
// though some limitation requires the declaration to be public. In addition, identifiers that
// begin with two underscores are reserved for the Swift compiler and standard library.

// To use a reserved word as an identifier, put a backtick (`) before and after it. For example,
// class isn't a valid identifier, but `class` is valid. The backticks aren't considered part of
// the identifier; `x` and x have the same meaning.

let `class` = "This is a class name"
let `func` = "This is a function name"
let `let` = "This is a let keyword"

// Inside a closure with no explicit parameter names, the parameters are implicitly named $0, $1,
// $2, and so on. These names are valid identifiers within the scope of the closure.

let numbers = [1, 2, 3, 4, 5]
let doubled = numbers.map { $0 * 2 }  // $0 is an implicit parameter name

// The compiler synthesizes identifiers that begin with a dollar sign ($) for properties that
// have a property wrapper projection. Your code can interact with these identifiers, but you
// can't declare identifiers with that prefix.

// MARK: - Keywords and Punctuation

// The following keywords are reserved and can't be used as identifiers, unless they're escaped
// with backticks, as described above in Identifiers. Keywords other than inout, var, and let can
// be used as parameter names in a function declaration or function call without being escaped
// with backticks.

// Keywords used in declarations: associatedtype, borrowing, class, consuming, deinit, enum,
// extension, fileprivate, func, import, init, inout, internal, let, nonisolated, open, operator,
// precedencegroup, private, protocol, public, rethrows, static, struct, subscript, typealias,
// and var.

// Keywords used in statements: break, case, catch, continue, default, defer, do, else,
// fallthrough, for, guard, if, in, repeat, return, switch, throw, where, and while.

// Keywords used in expressions and types: Any, as, await, catch, false, is, nil, rethrows, self,
// Self, super, throw, throws, true, and try.

// Keywords used in patterns: _.

// Keywords that begin with a number sign (#): #available, #colorLiteral, #else, #elseif, #endif,
// #fileLiteral, #if, #imageLiteral, #keyPath, #selector, #sourceLocation, #unavailable.

// Note: Prior to Swift 5.9, the following keywords were reserved: #column, #dsohandle, #error,
// #fileID, #filePath, #file, #function, #line, and #warning. These are now implemented as macros
// in the Swift standard library: column, dsohandle, error(_:), fileID, filePath, file, function,
// line, and warning(_:).

// Keywords reserved in particular contexts: associativity, async, convenience, didSet, dynamic,
// final, get, indirect, infix, lazy, left, mutating, none, nonmutating, optional, override,
// package, postfix, precedence, prefix, Protocol, required, right, set, some, Type, unowned,
// weak, and willSet. Outside the context in which they appear in the grammar, they can be used
// as identifiers.

// The following tokens are reserved as punctuation and can't be used as custom operators: (, ),
// {, }, [, ], ., ,, :, ;, =, @, #, & (as a prefix operator), ->, `, ?, and ! (as a postfix
// operator).

// MARK: - Literals

// A literal is the source code representation of a value of a type, such as a number or string.

// The following are examples of literals:

42               // Integer literal
3.14159          // Floating-point literal
"Hello, world!"  // String literal
/Hello, .*/      // Regular expression literal
true             // Boolean literal

// A literal doesn't have a type on its own. Instead, a literal is parsed as having infinite
// precision and Swift's type inference attempts to infer a type for the literal. For example,
// in the declaration let x: Int8 = 42, Swift uses the explicit type annotation (: Int8) to infer
// that the type of the integer literal 42 is Int8. If there isn't suitable type information
// available, Swift infers that the literal's type is one of the default literal types defined
// in the Swift standard library.

// MARK: - Integer Literals

// Integer literals represent integer values of unspecified precision. By default, integer literals
// are expressed in decimal; you can specify an alternate base using a prefix. Binary literals
// begin with 0b, octal literals begin with 0o, and hexadecimal literals begin with 0x.

// Decimal literals contain the digits 0 through 9. Binary literals contain 0 and 1, octal literals
// contain 0 through 7, and hexadecimal literals contain 0 through 9 as well as A through F in
// upper- or lowercase.

let decimal = 42
let binary = 0b101010
let octal = 0o52
let hexadecimal = 0x2A

print("Decimal: \(decimal)")
print("Binary: \(binary)")
print("Octal: \(octal)")
print("Hexadecimal: \(hexadecimal)")

// Negative integers literals are expressed by prepending a minus sign (-) to an integer literal,
// as in -42.

let negative = -42

// Underscores (_) are allowed between digits for readability, but they're ignored and therefore
// don't affect the value of the literal. Integer literals can begin with leading zeros (0), but
// they're likewise ignored and don't affect the base or value of the literal.

let million = 1_000_000
let binaryWithUnderscores = 0b1010_1010
let hexWithUnderscores = 0xFF_EC_DE_5E

print("Million: \(million)")
print("Binary with underscores: \(binaryWithUnderscores)")
print("Hex with underscores: \(hexWithUnderscores)")

// Unless otherwise specified, the default inferred type of an integer literal is the Swift
// standard library type Int.

let defaultInt = 42  // Type is Int
let explicitInt8: Int8 = 42  // Type is Int8
let explicitUInt: UInt = 42  // Type is UInt

// MARK: - Floating-Point Literals

// Floating-point literals represent floating-point values of unspecified precision.

// By default, floating-point literals are expressed in decimal (with no prefix), but they can also
// be expressed in hexadecimal (with a 0x prefix).

// Decimal floating-point literals consist of a sequence of decimal digits followed by either a
// decimal fraction, a decimal exponent, or both. The decimal fraction consists of a decimal point
// (.) followed by a sequence of decimal digits. The exponent consists of an upper- or lowercase
// e prefix followed by a sequence of decimal digits that indicates what power of 10 the value
// preceding the e is multiplied by. For example, 1.25e2 represents 1.25 x 10², which evaluates
// to 125.0. Similarly, 1.25e-2 represents 1.25 x 10⁻², which evaluates to 0.0125.

let decimalFloat = 3.14159
let floatWithExponent = 1.25e2  // 125.0
let floatWithNegativeExponent = 1.25e-2  // 0.0125
let floatWithExponent2 = 1.25E2  // uppercase E also works

print("Decimal float: \(decimalFloat)")
print("With exponent: \(floatWithExponent)")
print("With negative exponent: \(floatWithNegativeExponent)")

// Hexadecimal floating-point literals consist of a 0x prefix, followed by an optional
// hexadecimal fraction, followed by a hexadecimal exponent. The hexadecimal fraction consists
// of a decimal point followed by a sequence of hexadecimal digits. The exponent consists of an
// upper- or lowercase p prefix followed by a sequence of decimal digits that indicates what
// power of 2 the value preceding the p is multiplied by. For example, 0xFp2 represents 15 x 2²,
// which evaluates to 60. Similarly, 0xFp-2 represents 15 x 2⁻², which evaluates to 3.75.

let hexFloat = 0xFp2  // 60.0
let hexFloatNegative = 0xFp-2  // 3.75
let hexFloatWithFraction = 0xC.3p0  // 12.1875

print("Hex float: \(hexFloat)")
print("Hex float negative: \(hexFloatNegative)")
print("Hex float with fraction: \(hexFloatWithFraction)")

// Negative floating-point literals are expressed by prepending a minus sign (-) to a
// floating-point literal, as in -42.5.

let negativeFloat = -42.5

// Underscores (_) are allowed between digits for readability, but they're ignored and therefore
// don't affect the value of the literal. Floating-point literals can begin with leading zeros (0),
// but they're likewise ignored and don't affect the base or value of the literal.

let floatWithUnderscores = 1_000.5_000

// Unless otherwise specified, the default inferred type of a floating-point literal is the Swift
// standard library type Double, which represents a 64-bit floating-point number. The Swift
// standard library also defines a Float type, which represents a 32-bit floating-point number.

let defaultDouble = 3.14159  // Type is Double
let explicitFloat: Float = 3.14159  // Type is Float

// MARK: - String Literals

// A string literal is a sequence of characters surrounded by quotation marks. A single-line string
// literal is surrounded by double quotation marks and has the following form:

let singleLine = "Hello, world!"

// String literals can't contain an unescaped double quotation mark ("), an unescaped backslash
// (\), a carriage return, or a line feed.

// A multiline string literal is surrounded by three double quotation marks and has the following
// form:

let multiline = """
    This is a multiline
    string literal that
    can span multiple lines
    """

// Unlike a single-line string literal, a multiline string literal can contain unescaped double
// quotation marks ("), carriage returns, and line feeds. It can't contain three unescaped
// double quotation marks next to each other.

let multilineWithQuotes = """
    This string contains "quotes"
    and can span multiple lines
    """

// The line break after the """ that begins the multiline string literal isn't part of the string.
// The line break before the """ that ends the literal is also not part of the string. To make a
// multiline string literal that begins or ends with a line feed, write a blank line as its first
// or last line.

let multilineWithBlankLines = """

    This string starts with a blank line
    and ends with a blank line

    """

// A multiline string literal can be indented using any combination of spaces and tabs; this
// indentation isn't included in the string. The """ that ends the literal determines the
// indentation: Every nonblank line in the literal must begin with exactly the same indentation
// that appears before the closing """; there's no conversion between tabs and spaces.

let indentedMultiline = """
        This line is indented
        This line is also indented
        """

// Line breaks in a multiline string literal are normalized to use the line feed character. Even
// if your source file has a mix of carriage returns and line feeds, all of the line breaks in
// the string will be the same.

// In a multiline string literal, writing a backslash (\) at the end of a line omits that line
// break from the string. Any whitespace between the backslash and the line break is also omitted.
// You can use this syntax to hard wrap a multiline string literal in your source code, without
// changing the value of the resulting string.

let hardWrapped = """
    This is a long line that is \
    hard wrapped in the source code \
    but appears as a single line
    """

// Special characters can be included in string literals of both the single-line and multiline
// forms using the following escape sequences:
// - Null character (\0)
// - Backslash (\\)
// - Horizontal tab (\t)
// - Line feed (\n)
// - Carriage return (\r)
// - Double quotation mark (\")
// - Single quotation mark (\')
// - Unicode scalar (\u{n}), where n is a hexadecimal number that has one to eight digits

let escapedString = "This string contains:\nNewline\n\tTab\n\"Quotes\"\n\\Backslash\n\u{1F600}"

// The value of an expression can be inserted into a string literal by placing the expression in
// parentheses after a backslash (\). The interpolated expression can contain a string literal,
// but can't contain an unescaped backslash, a carriage return, or a line feed.

let name = "Swift"
let interpolated = "Hello, \(name)!"
let interpolatedNumber = "The answer is \(42)"
let interpolatedExpression = "The sum is \(1 + 2)"

// For example, all of the following string literals have the same value:
let x = 3
let same1 = "1 2 3"
let same2 = "1 2 \("3")"
let same3 = "1 2 \(3)"
let same4 = "1 2 \(1 + 2)"
let same5 = "1 2 \(x)"

// A string delimited by extended delimiters is a sequence of characters surrounded by quotation
// marks and a balanced set of one or more number signs (#). A string delimited by extended
// delimiters has the following forms:

let extendedDelimiter = #"This string contains \(x) and \n literally"#
let extendedDelimiter2 = #"""
    This is a multiline string
    with extended delimiters
    """#

// Special characters in a string delimited by extended delimiters appear in the resulting string
// as normal characters rather than as special characters. You can use extended delimiters to
// create strings with characters that would ordinarily have a special effect such as generating
// a string interpolation, starting an escape sequence, or terminating the string.

let string = #"\(x) \ " \u{2603}"#
let escaped = "\\(x) \\ \" \\u{2603}"
print(string)
// Prints "\(x) \ " \u{2603}"
print(string == escaped)
// Prints "true"

// If you use more than one number sign to form a string delimited by extended delimiters, don't
// place whitespace in between the number signs:

let tripleHash = ###"Line 1\###nLine 2"###  // OK
// let invalid = # # #"Line 1\# # #nLine 2"# # #  // Error

// Multiline string literals that you create using extended delimiters have the same indentation
// requirements as regular multiline string literals.

// The default inferred type of a string literal is String. For more information about the String
// type, see Strings and Characters and String.

// String literals that are concatenated by the + operator are concatenated at compile time. For
// example, the values of textA and textB in the example below are identical — no runtime
// concatenation is performed.

let textA = "Hello " + "world"
let textB = "Hello world"
print(textA == textB)  // true

// MARK: - Regular Expression Literals

// A regular expression literal is a sequence of characters surrounded by slashes (/) with the
// following form:

let regex1 = /Hello, .*/
let regex2 = /\d+/
let regex3 = /[a-z]+/

// Regular expression literals must not begin with an unescaped tab or space, and they can't
// contain an unescaped slash (/), a carriage return, or a line feed.

// Within a regular expression literal, a backslash is understood as a part of that regular
// expression, not just as an escape character like in string literals. It indicates that the
// following special character should be interpreted literally, or that the following nonspecial
// character should be interpreted in a special way. For example, /\(/ matches a single left
// parenthesis and /\d/ matches a single digit.

let parenRegex = /\(/
let digitRegex = /\d/

// A regular expression literal delimited by extended delimiters is a sequence of characters
// surrounded by slashes (/) and a balanced set of one or more number signs (#). A regular
// expression literal delimited by extended delimiters has the following forms:

let extendedRegex1 = #/abc/#
let extendedRegex2 = #/
    abc
    /#

// A regular expression literal that uses extended delimiters can begin with an unescaped space or
// tab, contain unescaped slashes (/), and span across multiple lines. For a multiline regular
// expression literal, the opening delimiter must be at the end of a line, and the closing
// delimiter must be on its own line. Inside a multiline regular expression literal, the extended
// regular expression syntax is enabled by default — specifically, whitespace is ignored and
// comments are allowed.

let multilineRegex = #/
    abc  # This is a comment
    def
/#

// If you use more than one number sign to form a regular expression literal delimited by extended
// delimiters, don't place whitespace in between the number signs:

let regex1_valid = ##/abc/##  // OK
// let regex2_invalid = # #/abc/# #  // Error

// If you need to make an empty regular expression literal, you must use the extended delimiter
// syntax.

let emptyRegex = #//#

// MARK: - Boolean Literals

// Boolean literals represent the boolean values true and false.

let isTrue = true
let isFalse = false

// MARK: - Nil Literal

// The nil literal represents the absence of a value for an optional type.

let optionalValue: Int? = nil

// MARK: - Operators

// The Swift standard library defines a number of operators for your use, many of which are
// discussed in Basic Operators and Advanced Operators. The present section describes which
// characters can be used to define custom operators.

// Custom operators can begin with one of the ASCII characters /, =, -, +, !, *, %, <, >, &, |,
// ^, ?, or ~, or one of the Unicode characters defined in the grammar below (which include
// characters from the Mathematical Operators, Miscellaneous Symbols, and Dingbats Unicode blocks,
// among others). After the first character, combining Unicode characters are also allowed.

// You can also define custom operators that begin with a dot (.). These operators can contain
// additional dots. For example, .+. is treated as a single operator. If an operator doesn't
// begin with a dot, it can't contain a dot elsewhere. For example, +.+ is treated as the +
// operator followed by the .+ operator.

// Although you can define custom operators that contain a question mark (?), they can't consist
// of a single question mark character only. Additionally, although operators can contain an
// exclamation point (!), postfix operators can't begin with either a question mark or an
// exclamation point.

// Note: The tokens =, ->, //, /*, */, ., the prefix operators <, &, and ?, the infix operator ?,
// and the postfix operators >, !, and ? are reserved. These tokens can't be overloaded, nor can
// they be used as custom operators.

// The whitespace around an operator is used to determine whether an operator is used as a prefix
// operator, a postfix operator, or an infix operator. This behavior has the following rules:

// If an operator has whitespace around both sides or around neither side, it's treated as an infix
// operator. As an example, the +++ operator in a+++b and a +++ b is treated as an infix operator.

// If an operator has whitespace on the left side only, it's treated as a prefix unary operator.
// As an example, the +++ operator in a +++b is treated as a prefix unary operator.

// If an operator has whitespace on the right side only, it's treated as a postfix unary operator.
// As an example, the +++ operator in a+++ b is treated as a postfix unary operator.

// If an operator has no whitespace on the left but is followed immediately by a dot (.), it's
// treated as a postfix unary operator. As an example, the +++ operator in a+++.b is treated as a
// postfix unary operator (a+++ .b rather than a +++ .b).

// For the purposes of these rules, the characters (, [, and { before an operator, the characters
// ), ], and } after an operator, and the characters ,, ;, and : are also considered whitespace.

// If the ! or ? predefined operator has no whitespace on the left, it's treated as a postfix
// operator, regardless of whether it has whitespace on the right. To use the ? as the
// optional-chaining operator, it must not have whitespace on the left. To use it in the ternary
// conditional (? :) operator, it must have whitespace around both sides.

// If one of the arguments to an infix operator is a regular expression literal, then the operator
// must have whitespace around both sides.

// In certain constructs, operators with a leading < or > may be split into two or more tokens.
// The remainder is treated the same way and may be split again. As a result, you don't need to
// add whitespace to disambiguate between the closing > characters in constructs like
// Dictionary<String, Array<Int>>. In this example, the closing > characters aren't treated as a
// single token that may then be misinterpreted as a bit shift >> operator.

let dictionary: Dictionary<String, Array<Int>> = ["key": [1, 2, 3]]

// MARK: - Additional Examples

// MARK: - Example: Unicode Identifiers

let café = "coffee"
let π = 3.14159
let 你好 = "Hello"
let 🎉 = "celebration"
let résumé = "resume"

// MARK: - Example: Reserved Words as Identifiers

let `return` = "This is a return keyword"
let `switch` = "This is a switch keyword"
let `if` = "This is an if keyword"

// MARK: - Example: Implicit Parameter Names

let numbers2 = [1, 2, 3, 4, 5]
let sum = numbers2.reduce(0) { $0 + $1 }  // $0 and $1 are implicit parameter names
let mapped = numbers2.map { $0 * 2 }

// MARK: - Example: Different Number Bases

let decimalNumber = 100
let binaryNumber = 0b1100100
let octalNumber = 0o144
let hexNumber = 0x64

print("All represent 100:")
print("  Decimal: \(decimalNumber)")
print("  Binary: \(binaryNumber)")
print("  Octal: \(octalNumber)")
print("  Hex: \(hexNumber)")

// MARK: - Example: String Interpolation

let age = 25
let name2 = "Alice"
let message = "My name is \(name2) and I am \(age) years old"
let calculation = "2 + 2 = \(2 + 2)"

// MARK: - Example: Extended String Delimiters

let path = #"C:\Users\Documents\file.txt"#
let json = #"{"name": "John", "age": 30}"#
let regexInString = #"The pattern is \d+"#

// MARK: - Example: Multiline String Formatting

let formattedText = """
    Line 1
    Line 2
        Indented line
    Line 3
    """

// MARK: - Example: Regular Expression Patterns

let emailPattern = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i
let phonePattern = /^\d{3}-\d{3}-\d{4}$/
let urlPattern = /^https?:\/\/.+/

// MARK: - Example Function Demonstrating All Lexical Structure Concepts

func demonstrateLexicalStructure() {
    print("\n=== Demonstrating Swift Lexical Structure ===\n")
    
    // Comments
    print("1. Comments:")
    print("   Single-line and multiline comments are supported")
    
    // Identifiers
    print("\n2. Identifiers:")
    print("   Regular: \(myVariable)")
    print("   With underscore: \(_privateVariable)")
    print("   With numbers: \(variable123)")
    print("   Unicode: \(π), \(你好)")
    
    // Reserved words
    print("\n3. Reserved Words as Identifiers:")
    print("   Using backticks: \(`class`)")
    
    // Integer literals
    print("\n4. Integer Literals:")
    print("   Decimal: \(decimal)")
    print("   Binary: \(binary) (0b101010)")
    print("   Octal: \(octal) (0o52)")
    print("   Hex: \(hexadecimal) (0x2A)")
    print("   With underscores: \(million)")
    
    // Floating-point literals
    print("\n5. Floating-Point Literals:")
    print("   Decimal: \(decimalFloat)")
    print("   With exponent: \(floatWithExponent)")
    print("   Hex: \(hexFloat)")
    
    // String literals
    print("\n6. String Literals:")
    print("   Single-line: \(singleLine)")
    print("   Multiline: \(multiline)")
    print("   Interpolated: \(interpolated)")
    print("   Extended delimiter: \(extendedDelimiter)")
    
    // Regular expression literals
    print("\n7. Regular Expression Literals:")
    print("   Simple: \(regex1)")
    print("   Extended: \(extendedRegex1)")
    
    // Boolean and nil literals
    print("\n8. Boolean and Nil Literals:")
    print("   True: \(isTrue)")
    print("   False: \(isFalse)")
    print("   Nil: \(optionalValue == nil)")
    
    // Operators
    print("\n9. Operators:")
    print("   Whitespace determines operator type (prefix, infix, postfix)")
    
    // Unicode identifiers
    print("\n10. Unicode Identifiers:")
    print("    Café: \(café)")
    print("    Pi: \(π)")
    print("    Chinese: \(你好)")
    
    print("\n=== End of Demonstration ===\n")
}

// Uncomment to run the demonstration
// demonstrateLexicalStructure()


