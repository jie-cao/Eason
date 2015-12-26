EASON[中文介绍](Readme_cn.md)
=========
EASON = Easy JSON. It simplifies JSON deserialization in Swift.  It provides:  

- Deserialize string, array and dictionary into an object in JSON format.
- A powerful JSONObject structure that can be assigned and visited in different ways.
- A set of Utils methods and protocols to covert a JSONObject instance into custom class.
- A set of custom operators that make the deserialization and object mapping process easy.
- High performance in deserialization process comparing to a lot of JSON deserialization frameworks in Swift.

Installation
------------

### CocoaPods (iOS 8+)
You can use Cocoapods to install EASON adding it to your Podfile:


#### Podfile
```
platform :ios, '8.0'
use_frameworks!
pod 'EASON'
```
In the project, you can import the EASON framework  

```swift
import EASON
```  

### Manually
The source code from [here](https://github.com/jie-cao/EASON). You can manually add the source code into your project.  There is only one file you need to import:`EASON.swift` 

Usage
----------

### using JSONObject
After import, you can covert your JSON instance from Array, Dictionary, String or NSData into a JSONObject instance. The JSONObject instance is the main object you can interact with:
For example: 

Covert Dictionary to JSONObject  
```swift
let object = ["name": "Hello", "id": 123]
let jsonObject = JSONObject(object)
print(jsonObject["name"].stringValue)
print("\(jsonObject["id"].intValue)")
```
Covert Array to JSONObject  
```swift
let jsonArray:JSONObject = ["This", "is", "a", "string", 1, 2, 3, 4]
print(jsonArray[0].string)
print(jsonArray[1].string)
print(jsonArray[2].string)
print(jsonArray[3].string)
print("\(jsonArray[4].intValue)")
print("\(jsonArray[5].intValue)" + "\(jsonArray[6].intValue)")
```

Covert String to JSONObject  
use the following initialization function for converting String to JSONObject:  
```swift
public struct JSONObject {
	public init(string: String?)
	...
```
```swift
let jsonString = "{\"name\": \"hello\", \"id\":123}"
let jsonObject = JSONObject(string: jsonString)
print(jsonObject["name"].stringValue)
print("\(jsonObject["id"].intValue)")
```  

Covert NSData to JSONObject 
use the following initialization function for converting NSData to JSONObject:  
```swift
public struct JSONObject {
	public init(data: NSData?)
	...
```
```swift
 if let path = NSBundle(forClass: BaseTests.self).pathForResource("twitter", ofType: "json") {
	 let data: NSData?
	 do {
		 data = try NSData(contentsOfFile: path, options: [])
		} catch _ {
		data = nil
	    }
     let jsonArray = JSONObject(data:data)
     for jsonObject in jsonArray{
	     print("\(jsonObject["id"].int)")
         print(jsonObject["text"].string)
     }
}
```
### Accessing fields in JSONObject using subscript
The fields in JSONObject can be accessed using subscript. For example: 
```swift
let jsonString = "{\"name\": \"hello\", \"id\":123}"
let jsonObject = JSONObject(string: jsonString)
print(jsonObject["name"].stringValue)
print("\(jsonObject["id"].intValue)")
```  
Don't worry about accessing use subscript value that is out of the bound of the array or dictionary. It will not thrown exception and will return nil in these cases.

### Accessing fields in JSONObject using iterations
It is very common that the JSON object is an Array. You can use loop to iterate the elements in the array:  
```swift
	 let data: NSData?
	 do {
		 data = try NSData(contentsOfFile: path, options: [])
		} catch _ {
		data = nil
	    }
     let jsonArray = JSONObject(data:data)
     for jsonObject in jsonArray{
	     print("\(jsonObject["id"].int)")
         print(jsonObject["text"].string)
     }
```
### Converting JSONObject to User-defined class
A very common task is to convert a JSON response from the web service into user-defined class instances. EASON provides a set of Utils methods and protocol to help complete this task.
You can add the `JSONSerialization ` protocol to the class you defined. You will need to implement the required init:
```swift
init?(jsonObject: JSONObject)
```
In the init method, you can define the relationship between fields in JSON and properties in your class. For example, I have defined a class to represent a tweet in Twitter:
```swift
class Tweet: NSObject, JSONSerialization {
    var id:Int?
    var createdAt:NSDate?
    var user:TweetUser?
    var text:String?
    
    required init?(jsonObject: JSONObject) {
        self.id = jsonObject["id"].string
        self.text = jsonObject["text"].string
        self.createdAt = JSONObject.dateTransformer(jsonObject["created_at"], dateFormatter: "EEE MMM dd HH:mm:ss Z yyyy")
        
        self.user = JSONObject.objectTransformer(jsonObject["user"])
    }
}
``` 
The ```JSONObject.dateTransformer``` method is a helper class to convert string to NSDate object.

Noticed that the ```user``` property in ```Tweet``` class is also a user-defined class instance to the the field to a ```TweetUser``` instance.  

The```TweetUser```class needs to implement```JSONSerialization ```protocol as well.  After that, you can use the helper method  ```JSONObject.objectTransformer``` to transform the ```user```field to ```user```with ```TweetUser```class. The ```TweetUser``` class is defined as follows:
```swift
class TweetUser: NSObject, JSONSerialization {
    var id:Int?
    var name:String?
    var profile_image_url:NSURL?
    required init?(jsonObject: JSONObject) {
        self.name = jsonObject["name"].string
        self.id = jsonObject["id"].string
        self.profile_image_url = jsonObject["profile_image_url"].URL
    }
}
```
In some cases, you want to convert the sub-fields in a JSON response into an array of user-defined class objects. You can use the ```JSONObject.arrayTransformer``` helper method to achieve this.
For example, if you want to convert a sub-field in a JSON response to an Array of [Tweet] object, you can use the following command
```swift
var tweets = JSONObject.arrayTransformer(jsonObject["tweets"])
```

Follow this pattern, the JSON response can be transformed into user-defined class with multiple layers. Please see the examples for deserialize tweets from a sample response from Twitter in the Demo project.

### Using custom operators: =~ =? =!
Noticed that in the previous section, we need to decide whether we need to assign string or int value for fields in the class. You can simplify this by using the following custom operators. Their definitions are:  

1. =~ operator
If the JSONObject instance can be converted to the given class, assign the instance object with class with the converted value.
The operator will do nothing if the JSONObject instance cannot be converted to an object with the given class. Use the operator to convert the JSONOjbect instance to any non-optional type T

2. =? operator
If the JSONObject instance can be converted to the given class, assign the instance object with class with the converted value.
The operator will assign the the left hand side objet to nil if the JSONObject instance cannot be converted to an object with the given class.
Use this operator to covert the JSONObject instance to any optional Type T?

3. =! operator
 If the JSONObject instance can be converted to the given class, assign the instance object with class with the converted value.
The operator will assign the the left hand side objet to the default value of for the given class. If the JSONObject instance cannot be converted to an object with the given class.
This operator can be used to convert the JSONObject intance to any type T, T? or T!

Using the custom operators, the transformation process in the previous section can be simplified as follows:
```swift
class Tweet: NSObject, JSONSerialization {
    var id:Int?
    var createdAt:NSDate?
    var user:TweetUser?
    var text:String?
    
    required init?(jsonObject: JSONObject) {
        self.id =? jsonObject["id"]
        self.text =? jsonObject["text"]
        self.createdAt = JSONObject.dateTransformer(jsonObject["created_at"], dateFormatter: "EEE MMM dd HH:mm:ss Z yyyy")
        
        self.user = JSONObject.objectTransformer(jsonObject["user"])
    }
}
```  
```swift

class TweetUser: NSObject, JSONSerialization {
    var id:Int?
    var name:String?
    var profile_image_url:NSURL?
    required init?(jsonObject: JSONObject) {
        self.name =? jsonObject["name"]
        self.id =? jsonObject["id"]
        self.profile_image_url = jsonObject["profile_image_url"].URL
    }
}
``` 

## Licenses

All source code is licensed under the [MIT License](https://raw.github.com/rs/SDWebImage/master/LICENSE).
