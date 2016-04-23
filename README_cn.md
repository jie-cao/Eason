Eason
=========
Eason = Easy JSON. 使用EASON能大大简化在Swift中处理JSON数据结构和从JSON数据结构到各种类的转换的各种操作。Eason包括了:  
- 一个JSONObject结构用来简化和优化对JSON数据结构的操作访问
- 将JSON的各种数据结构如String, Array和Dictionary 转换成JSONObject结构以便对JSON数据进行各种操作
- 一系列的工具函数和protocols来将JSONObject结构转换成自己定义的class对象
- 一套自定的operator来优化JSONObject和自定义类转换的操作
- Eason的JSON到自定义类的转换的performance优于现在流行的swift的JSON处理框架

安装
------------

### CocoaPods (iOS 8+)
可以通过Cocoapods来安装EASON:

#### Podfile
```
platform :ios, '8.0'
use_frameworks!
pod 'Eason'
```
在Project当中import:

```swift
import Eason
```  

### 直接嵌入源代码
Eason是一个开源库，可以从[这里](https://github.com/jie-cao/EASON).直接找到源代码并加入项目。EASON是一个非常轻量级的框架，唯一需要嵌入项目的源代码文件是`EASON.swift` 

如何使用
----------

### 使用 JSONObject
在安装Eason到你的项目后，你可以通过下面这些方法来把Array，Dictionary，String或者NSData转换成一个JSONObject结构的对象。在转换成JSONObject后，你可以通过下面这些方法来访问JSON数据结构中个各个对象：
将Dictionary转换成JSONObject并访问JSONObject对象:
```swift
let object = ["name": "Hello", "id": 123]
let jsonObject = JSONObject(object)
print(jsonObject["name"].stringValue)
print("\(jsonObject["id"].intValue)")
```
将Array转会成JSONObject并访问JSONObject对象:
```swift
let jsonArray:JSONObject = ["This", "is", "a", "string", 1, 2, 3, 4]
print(jsonArray[0].string)
print(jsonArray[1].string)
print(jsonArray[2].string)
print(jsonArray[3].string)
print("\(jsonArray[4].intValue)")
print("\(jsonArray[5].intValue)" + "\(jsonArray[6].intValue)")
```

将String转会成JSONObject并访问JSONObject对象:
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

将NSData转会成JSONObject并访问JSONObject对象:
用下面的初始化函数来将NSData转换成JSONObject:
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
### 用下标来访问JSONObject的结构
JSON的数据结构是基于Dictionary和Array的，JSONObject提供了用下标访问JSON的各个field。例如:
```swift
let jsonString = "{\"name\": \"hello\", \"id\":123}"
let jsonObject = JSONObject(string: jsonString)
print(jsonObject["name"].stringValue)
print("\(jsonObject["id"].intValue)")
```  
对于Dictionary的子结构，下标是key。对于Array的子结构，下标是index。对于JSONObject，不要担心下标越界和访问没有的key。JSONObject结构不会抛出exception而会返回nil。

### 用iterations来访问JSONObject
用for loop或者其他iteration方式来访问JSON数据结构中的Array中的各个元素。EASON也提供对JSONObject用iteration来访问:
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
### 将JSONObject转换成自定义的类
在处理JSON数据结构时，一个常见的需求就是将API返回的JSON数据结构转换成自定义的类的对象。EASON提供了一系列的工具函数和protocol来帮助实现这一目的：
你可以用前面提供的方法将JSON数据结构转换成JSONObject， 然后通过JSONObject转换成定义的类的对象。你可以在定义的class来继承一个`JSONSerialization `的protocol。这个protocol唯一需要实现的函数是下面这个初始化函数:
```swift
init?(jsonObject: JSONObject)
```
你可以通过这个函数来实现JSONObject的子结构到自定义的类的property的一一对应关系。  
下面提供了一个将Twitter的Sample JSON Response转换成一个自定义的Tweet的类例子：
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
```JSONObject.objectTransformer```函数是一个Helper函数来负责讲String转换成NSDate的对象。

#### 使用```JSONObject.objectTransformer``` 函数
在上面的例子中间，我们注意到 ```user```这个proprty也是一个自定义的```TweetUser```类，在指定一对一转换关系的时候，用```JSONObject.objectTransformer``` 来帮助实现。在```TweetUser```中，只要和```Tweet```类一样继承`JSONSerialization `protocol。```TweetUser```可以如下定义：
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
#### 使用```JSONObject.arrayTransformer```函数
除了Dictionary的结构，JSON数据或者它的子结构也会是Array结构。如果想要将Array转换成自定类的一个Array，可以使用```JSONObject.arrayTransformer``` 函数。下面的一个例子是将一个包含Tweets的JSON数据转换成一个自定义的Tweet的Array。
```swift
var tweets = JSONObject.arrayTransformer(jsonObject["tweets"])
```
利用```JSONObject.arrayTransformer``` 和```JSONObject.objectTransformer``` ，可以将JSON数据结构转换成各个自定义的复杂或者简单的类。关于将JSON数据结构转换成自定义类的复杂引用，请参考Demo的项目中的基于Twitter的JSON Response的例子。  

**下面我会会介绍几个自定义的操作符来使这一过程更加简化**。

### 使用自定义操作符: =~ =? =!
我们主要上面的例子中，我们要访问JSONObject中的int或者string值来给赋值给自定义类中的property。EASON提供了几个自定义的操作符来大大简化这一过程。下面是这些操作符的定义:

1. =~ 操作符  
这个operator的作用就是将一个JSONObject的对象转换成operator左边的类对象。但是如果这个JSONObject对象不能转换成指定的类，这个操作符不会进行任何动作。  
当左边的类是一个non-optional的类T时，使用这个操作符。

2. =? 操作符  
这个operator的作用就是将一个JSONObject的对象转换成operator左边的类对象。但是如果这个JSONObject对象不能转换成指定的类，这个操作符会将左边的对象设置成nil。  
当左边的类是一个optional的类T？时，使用这个操作符。

3. =! 操作符  
这个operator的作用就是将一个JSONObject的对象转换成operator左边的类对象。但是如果这个JSONObject对象不能转换成指定的类，这个操作符会返回这个类的指定default值。  
这个操作符可以用在任何T，T？和T！类。
因为无法的事用户自定义的类的default值，所以=！操作符无法运用在用户自定义的类上。可以用=？或者=~来实现转换功能。  

使用上面这个几个操作符，可以大大简化从JSONObject到自定义类的转换过程。例如上面的例子可以简化为下面的代码：

```swift
class Tweet: NSObject, JSONSerialization {
    var id:Int?
    var createdAt:NSDate?
    var user:TweetUser?
    var text:String?
    
    required init?(jsonObject: JSONObject) {
        self.id =? jsonObject["id"]
        self.text =? jsonObject["text"]
        self.user =? jsonObject["user"]
        
        // Use custom transformer to convert string to NSDate
        self.createdAt = JSONObject.dateTransformer(jsonObject["created_at"], dateFormatter: "EEE MMM dd HH:mm:ss Z yyyy")

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
        self.profile_image_url =? jsonObject["profile_image_url"]
    }
}
``` 
## Licenses

All source code is licensed under the [MIT License](https://raw.github.com/rs/SDWebImage/master/LICENSE).