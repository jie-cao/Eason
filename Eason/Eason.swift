//
//  Eason.swift
//  Eason
//
//  Created by Jie Cao on 11/29/15.
//  Copyright © 2015 Jie Cao. All rights reserved.
//

import Foundation

// Protocol for an ojbect that can be initialized from an instance of JSONObject
public protocol JSONSerialization {
    init?(jsonObject: JSONObject)
}

// JSONObject structure and init function
public struct JSONObject {
    
    /// The internal object to convert desired type as needed
    private let object: AnyObject?
    
    /*
    Initialize an instance of JSONObject from an instance of AnyObject.
    
    - parameter object: An instance of AnyObject?
    
    - returns: the initialized JSONObject
    */
    public init(_ object: AnyObject?) {
        self.object = object
    }
    
    /*
    Initialize an instance of JSONObject from an instance of String.
    
    - parameter object: An instance of String?
    
    - returns: the initialized JSONObject
    */
    public init(string: String?) {
        if let stringValue = string,
            let data = stringValue.dataUsingEncoding(NSUTF8StringEncoding){
                self.init(data:data)
        } else {
            self.init(nil)
        }
    }
    
    /*
    Initialize an instance of JSONObjec from an instance of NSData.
    
    - parameter data: An instance of NSData
    
    - returns: the initialized JSONObject
    */
    public init(data: NSData?) {
        var objectfromData:AnyObject? = nil
        if let dataValue = data {
            do {
                objectfromData = try NSJSONSerialization.JSONObjectWithData(dataValue, options: [])
            } catch _ {
            }
        }
        self.object = objectfromData
    }
}

// Get an instance of Int, Double, Float, Int8, Int16, Int32, Int64, Bool, Dictionary, JSONDictionary, Array, JSONArray, NSURL from an instance of JSONObject
public extension JSONObject {
    
    /*
    subscript for dictionary access
    */
    public subscript(key: String) -> JSONObject {
        if object == nil { return self }
        
        if let dictionary = jsonDictionary,
            let jsonObject = dictionary[key]{
            return jsonObject
        }
        
        return JSONObject(nil)
    }
    
    /*
    subscript for array access
    */
    public subscript(index: Int) -> JSONObject {
        if object == nil { return self }
        
        if let jsonArray = jsonArray where index < jsonArray.count{
            return jsonArray[index]
        }
        
        return JSONObject(nil)
    }

    /// returns the value as an instance of String?
    public var string: String? {
        return object as? String
    }
    
    /// returns the value as an instance of String or the default value
    public var stringValue: String {
        return string ?? JSONObject.defaultValueForType(String)!
    }
    
    /// returns the value as an instance of NSURL?
    public var URL: NSURL? {
        if let urlString = self.string{
            return NSURL(string: urlString)
        }
        return nil
    }
    
    /// returns the value as an instance of NSURL or the default value
    public var URLValue: NSURL {
        return URL ?? JSONObject.defaultValueForType(NSURL)!
    }

    /// returns the value as an instance of Int?
    public var int: Int? {
        return object as? Int
    }
    
    /// returns the value as an instance of Int or the default value
    public var intValue: Int {
        return int ?? JSONObject.defaultValueForType(Int)!
    }
    
    /// returns the value as an instance of UInt?
    public var uInt: UInt? {
        return object?.unsignedLongValue
    }
    
    /// returns the value as an instance of UInt or the default value
    public var uIntValue: UInt {
        return uInt ?? JSONObject.defaultValueForType(UInt)!
    }
    
    /// returns the value as an instance of Int8?
    public var int8: Int8? {
        get {
            if let uIntValue = self.object as? Int{
                return Int8(uIntValue)
            } else {
                return nil
            }
        }
    }

    /// returns the value as an instance of Int8 or the default value
    public var int8Value: Int8 {
        return int8 ?? JSONObject.defaultValueForType(Int8)!
    }
    
    /// returns the value as an instance of UInt8?
    public var uInt8: UInt8? {
        get {
            if let uIntValue = self.object as? Int{
                return UInt8(uIntValue)
            } else {
                return nil
            }
        }
    }
    
    /// returns the value as an instance of UInt8 or the default value
    public var uInt8Value: UInt8 {
        return uInt8 ?? JSONObject.defaultValueForType(UInt8)!
    }
    
    /// returns the value as an instance of Int16?
    public var int16: Int16? {
        get {
            if let uIntValue = self.object as? Int{
                return Int16(uIntValue)
            } else {
                return nil
            }
        }
    }
    
    /// returns the value as an instance of Int16 or the default value
    public var int16Value: Int16 {
        return int16 ??  JSONObject.defaultValueForType(Int16)!
    }
    
    /// returns the value as an instance of UInt16?
    public var uInt16: UInt16? {
        get {
            if let _ = self.object as? Int{
                return self.object?.unsignedShortValue
            } else {
                return nil
            }
        }
    }
    
    /// returns the value as an instance of UInt16 or the default value
    public var uInt16Value: UInt16 {
        return uInt16 ?? JSONObject.defaultValueForType(UInt16)!
    }
    
    /// returns the value as an instance of Int32
    public var int32: Int32? {
        get {
            if let _ = self.object as? Int{
                return self.object?.intValue
            } else {
                return nil
            }
        }
    }
    
    /// returns the value as an instance of Int32 or the default value
    public var int32Value: Int32 {
        return int32 ?? JSONObject.defaultValueForType(Int32)!
    }
    
    /// returns the value as an instance of UInt32?
    public var uInt32: UInt32? {
        get {
            if let _ = self.object as? Int{
                return self.object?.unsignedIntValue
            } else {
                return nil
            }
        }
    }
    
    /// returns the value as an instance of UInt32 or the default value
    public var uInt32Value: UInt32 {
        return uInt32 ?? JSONObject.defaultValueForType(UInt32)!
    }
    
    /// returns the value as an instance of Int64?
    public var int64: Int64? {
        get {
            if let _ = self.object as? Int{
                return self.object?.longLongValue
            } else {
                return nil
            }
        }
    }
    
    /// returns the value as an instance of UInt64 or the default value
    public var int64Value: Int64 {
        return int64 ?? JSONObject.defaultValueForType(Int64)!
    }
    
    /// returns the value as an instance of UInt64?
    public var uInt64: UInt64? {
        get {
            if let _ = self.object as? Int{
                return self.object?.unsignedLongLongValue
            } else {
                return nil
            }
        }
    }

    /// returns the value as an instance of UInt64 or the default value
    public var uInt64Value: UInt64 {
        return uInt64 ?? JSONObject.defaultValueForType(UInt64)!
    }

    /// returns the value as an instance of Double?
    public var double: Double? {
        return object as? Double
    }
    
    /// returns the value as an instance of Double or the default value
    public var doubleValue: Double {
        return double ?? JSONObject.defaultValueForType(Double)!
    }
    
    /// returns the value as an instance of Float? or the default value
    public var float: Float? {
        return object as? Float
    }
    
    /// returns the value as an instance of Float or the default value
    public var floatValue: Float {
        return float ?? JSONObject.defaultValueForType(Float)!
    }

    /// returns the value as an instance of Bool?
    public var bool: Bool? {
        return object as? Bool
    }
    
    /// returns the value as an instance of Bool or the default value
    public var boolValue: Bool {
        return bool ?? JSONObject.defaultValueForType(Bool)!
    }

    /// returns the value as an instance of optional [String:AnyObject] Dicionary
    public var dictionary: [String: AnyObject]? {
        return object as? [String: AnyObject]
    }
    
    /// returns the value as an instance of [String:AnyObject] Dicionary or the default empty Dictionary
    public var dictionaryValue: [String: AnyObject] {
        return dictionary ?? JSONObject.defaultValueForType([String:AnyObject])!
    }

    /// returns the value as an instance of optional [String:JSONObject] Dicionary
    public var jsonDictionary: [String: JSONObject]? {
        return dictionary?.reduce([String: JSONObject]()) { (var dict, pair) in
            dict[pair.0] = JSONObject(pair.1)
            return dict
        }
    }
    
    /// returns the value as an instance of [String:JSONObject] Dicionary or the default empty Dictionary
    public var jsonDictionaryValue: [String: JSONObject] {
        return jsonDictionary ?? JSONObject.defaultValueForType([String:JSONObject])!
    }
    
    /// returns the value as an instance of optional [AnyObject] Array
    public var array: [AnyObject]? {
        return object as? [AnyObject]
    }
    
    /// returns the value as an instance of [AnyObject] Array or the default empty Array
    public var arrayValue: [AnyObject] {
        return array ?? JSONObject.defaultValueForType([AnyObject])!
    }

    /// returns the value as an instance of optional [JSONObject] Array
    public var jsonArray: [JSONObject]? {
        return array?.map{ JSONObject($0) }
    }
    
    /// returns the value as an instance of [JSONObject] Array or the default empty Array
    public var jsonArrayValue: [JSONObject] {
        return jsonArray ?? JSONObject.defaultValueForType([JSONObject])!
    }
}


//custom operators: =~ =? =!

/* 
=~ operator
If the JSONObject instance can be converted to the given class, assign the instance object with class with the converted value.
The operator will do nothing if the JSONObject instance cannot be converted to an object with the given class.
Use the operator to convert the JSONOjbect instance to non-optional type T
*/
infix operator =~ {
associativity right
precedence 90
}

// Converts the JSONObject to an instance custom objects. The custom objects must conforms to JSONSerialization protocol(can be initialized from an instance of JSONObject)
public func =~ <T:JSONSerialization>(inout lhs:T, jsonObject: JSONObject) {
    let object = T(jsonObject: jsonObject)
    if object != nil {
        lhs = object!
    }
}

// Converts the JSONObject to an array of custom objects. The custom objects must conforms to JSONSerialization protocol(can be initialized from an instance of JSONObject)
public func =~ <T:JSONSerialization>(inout lhs:[T], jsonObject: JSONObject) {
    // differentiate between empty and non-existent array
    if jsonObject.array != nil {
        var transformedObjectsArray: [T] = []
        for element in jsonObject {
            if let newelement = T(jsonObject: element) {
                transformedObjectsArray.append(newelement)
            }
        }
        
        lhs = transformedObjectsArray
    }
}

/// If the JSONObject instance can be converted to the given class T, assign the instance object with class T with the converted value.
/// The operator will do nothing if the JSONObject instance cannot be converted to an object with the given class.
public func =~ <T: Any>(inout lhs: T, jsonObject: JSONObject) {
    if let value = jsonObject.object as? T {
        lhs = value
    }
}

/* 
=? operator
If the JSONObject instance can be converted to the given class, assign the instance object with class with the converted value.
The operator will assign the the left hand side objet to nil if the JSONObject instance cannot be converted to an object with the given class.
Use this operator to covert the JSONObject instance to optional Type T?
*/
infix operator =? {
associativity right
precedence 90
}

// Converts the JSONObject to an instance custom objects. The custom objects must conforms to JSONSerialization protocol(can be initialized from an instance of JSONObject)
public func =? <T:JSONSerialization>(inout lhs:T?, jsonObject: JSONObject) {
    lhs = T(jsonObject: jsonObject)
}

// Converts the JSONObject to an array of custom objects. The custom objects must conforms to JSONSerialization protocol(can be initialized from an instance of JSONObject)
public func =? <T:JSONSerialization>(inout lhs:[T]?, jsonObject: JSONObject) {
    // differentiate between empty and non-existent array
    if jsonObject.array == nil {
        lhs = nil
    }
    
    var transformedObjectsArray: [T] = []
    for element in jsonObject {
        if let newelement = T(jsonObject: element) {
            transformedObjectsArray.append(newelement)
        } else {
            lhs = nil
        }
    }
    
    lhs = transformedObjectsArray
}

/// If the JSONObject instance can be converted to the given class T?, assign the instance object with class T with the converted value.
/// The operator will do nothing if the JSONObject instance cannot be converted to an object with the given class.
public func =? <T: Any>(inout lhs: T?, jsonObject: JSONObject) {
    lhs = jsonObject.object as? T
}

/*
=! operator
If the JSONObject instance can be converted to the given class, assign the instance object with class with the converted value.
The operator will assign the the left hand side objet to the default value of for the given class. If the JSONObject instance cannot be converted to an object with the given class.
This operator can be used to convert the JSONObject intance to type T, T? or T!
*/
infix operator =! {
associativity right
precedence 90
}

/*
If the JSONObject instance can be converted to the given class T, assign the instance object with class with the converted value.
The operator will assign the the left hand side objet to the default value of for the given class T. If the JSONObject instance cannot be converted to an object with the given class T.
*/
public func =! <T: Any>(inout lhs: T, jsonObject: JSONObject) {
    if let value = jsonObject.object as? T ?? JSONObject.defaultValueForType(T.self) {
        lhs = value
    }
}

/*
If the JSONObject instance can be converted to the given class T?, assign the instance object with class with the converted value.
The operator will assign the the left hand side objet to the default value of for the given class T?. If the JSONObject instance cannot be converted to an object with the given class T?.
*/
public func =! <T: Any>(inout lhs: T?, jsonObject: JSONObject) {
    if let value = jsonObject.object as? T ?? JSONObject.defaultValueForType(T.self) {
        lhs = value
    }
}

/*
If the JSONObject instance can be converted to the given class T!, assign the instance object with class with the converted value.
The operator will assign the the left hand side objet to the default value of for the given class T!. If the JSONObject instance cannot be converted to an object with the given class T!.
*/
public func =! <T: Any>(inout lhs: T!, jsonObject: JSONObject) {
    if let value = jsonObject.object as? T ?? JSONObject.defaultValueForType(T.self) {
        lhs = value
    }
}

// MARK: SequenceType
extension JSONObject: SequenceType {
    public func generate() -> AnyGenerator<JSONObject> {
        guard let array = jsonArray else {
            return anyGenerator { nil }
        }
        
        var index = 0
        
        return anyGenerator {
            if index < array.count {
                return array[index++]
            } else {
                return nil
            }
        }
    }
}

// MARK: RawRepresentable
extension JSONObject: RawRepresentable {
    
    public init?(rawValue: AnyObject) {
        self.init(rawValue)
    }
    
    public var rawValue: AnyObject {
        return self.object ?? NSNull()
    }
    
    public func rawData(options options: NSJSONWritingOptions = NSJSONWritingOptions(rawValue: 0)) throws -> NSData {
        return try NSJSONSerialization.dataWithJSONObject(self.object ?? NSNull(), options: options)
    }
    
    public func rawString() -> String? {
        return self.object?.stringValue
    }
}

// MARK: CustomStringConvertible, CustomDebugStringConvertible
extension JSONObject: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        if let string = self.rawString() {
            return string
        } else {
            return JSONObject.defaultValueForType(String)!
        }
    }
    
    public var debugDescription: String {
        return description
    }
}


// MARK: LiteralConvertible
extension JSONObject: StringLiteralConvertible {
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
    
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
        self.init(value)
    }
    
    public init(unicodeScalarLiteral value: StringLiteralType) {
        self.init(value)
    }
}

// MARK: IntegerLiteralConvertible
extension JSONObject: IntegerLiteralConvertible {
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(value)
    }
}

// MARK: FloatLiteralConvertible
extension JSONObject: FloatLiteralConvertible {
    public init(floatLiteral value: FloatLiteralType) {
        self.init(value)
    }
}

// MARK: BooleanLiteralConvertible
extension JSONObject: BooleanLiteralConvertible {
    public init(booleanLiteral value: BooleanLiteralType) {
        self.init(value)
    }
}

// MARK: DictionaryLiteralConvertible
extension JSONObject: DictionaryLiteralConvertible {
    public init(dictionaryLiteral elements: (String, AnyObject)...) {
        var dictionary = [String: AnyObject]()
        
        for (key, value) in elements {
            dictionary[key] = value
        }
        
        self.init(dictionary)
    }
}

// MARK: ArrayLiteralConvertible
extension JSONObject: ArrayLiteralConvertible {
    public init(arrayLiteral elements: AnyObject...) {
        self.init(elements)
    }
}

// MARK: NilLiteralConvertible
extension JSONObject: NilLiteralConvertible {
    public init(nilLiteral: ()) {
        self.init(nil)
    }
}

// Helper methods to for deserilization custom objects from JSONObject
public extension JSONObject{
    
    // Converts the JSONObject to an array of custom objects. The custom objects must conforms to JSONSerialization protocol(can be initialized from an instance of JSONObject)
    static func arrayTransformer<T: JSONSerialization>(jsonObject: JSONObject) -> [T]? {
        // differentiate between empty and non-existent array
        if jsonObject.array == nil {
            return nil
        }
        
        var transformedObjectsArray: [T] = []
        for element in jsonObject {
            if let newelement = T(jsonObject: element) {
                transformedObjectsArray.append(newelement)
            } else {
                return nil
            }
        }
        
        return transformedObjectsArray
    }
    
    // Converts the JSONObject to an instance custom objects. The custom objects must conforms to JSONSerialization protocol(can be initialized from an instance of JSONObject)
    static func objectTransformer<T: JSONSerialization>(jsonObject: JSONObject) -> T? {
        return T(jsonObject: jsonObject)
    }
    
    static var dateFormatter:NSDateFormatter = NSDateFormatter()
    
    // Converts the JSONObject to an instance of NSDate?
    static func dateTransformer(jsonObject: JSONObject, dateFormatter:String) -> NSDate? {
        if let dateTimeString = jsonObject.string{
            JSONObject.dateFormatter.dateFormat = dateFormatter
            return JSONObject.dateFormatter.dateFromString(dateTimeString)
        }
        return nil
    }
    
}

// Default value for types
public extension JSONObject{
    /**
    Returns the default value for different types
    
    - parameter type: The specified type
    
    - returns:the default value for the given type
    */
    static func defaultValueForType<T: Any>(type: T.Type) -> T? {
        switch type {
        case is String.Type:
            return "" as? T
        case is Int.Type, is Int64.Type, is Int32.Type, is Int16.Type, is Int8.Type, is UInt.Type, is UInt64.Type, is UInt32.Type, is UInt16.Type, is UInt8.Type:
            return 0 as? T
        case is Double.Type:
            return 0.0 as? T
        case is Float.Type:
            return Float(0.0) as? T
        case is Bool.Type:
            return false as? T
        case is [String: AnyObject].Type:
            return [:] as? T
        case is [AnyObject].Type:
            return [] as? T
        case is [JSONObject].Type:
            return [JSONObject]() as? T
        case is [String:JSONObject].Type:
            return [String:JSONObject]() as? T
        case is NSURL.Type:
            return NSURL() as? T
        default:
            return nil
        }
    }
}
