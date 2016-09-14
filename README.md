

# NRMirror

[![Version](https://img.shields.io/cocoapods/v/NRMirror.svg?style=flat)](http://cocoapods.org/pods/NRMirror)
[![License](https://img.shields.io/cocoapods/l/NRMirror.svg?style=flat)](http://cocoapods.org/pods/NRMirror)
[![Platform](https://img.shields.io/cocoapods/p/NRMirror.svg?style=flat)](http://cocoapods.org/pods/NRMirror)


## Introduction

NRMirror helps you to sync your models with web service response or any input dictionary and. So its work like a object mapper for your project. So dont worry about manually mapping your model object with your json/dictionary , you have to just declare your model and name your key same as your dictionary/Json key and you are done. NRMirror supporting of all types Int, String ,Float , Bool etc.. and NRMirror subclass models. NRMirror is based on swift mirror refelection. For more info about Mirror refer apple doc [Mirror Info](https://developer.apple.com/library/tvos/documentation/Swift/Reference/Swift_Mirror_Structure/index.html)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
Xcode 7+ , Swift 2 , iOS 9 and above

## Installation

NRMirror is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "NRMirror"
```

## Usage
```
let jsonString = "{\"userId\": 1 ,\"name\":\"naveen\",\"emailId\":\"naveen@appster\",\"isActiveUser\": true,\"category\":{\"categoryId\": 2 , \"categoryName\": \"testnaveenrana\"},\"categoryArray\":[{\"categoryId\": 2 , \"categoryName\": \"innerarray\"}],\"subUsers\":[\"array1\",\"array2\"]}"
let dict = try! NSJSONSerialization.JSONObjectWithData(jsonString.dataUsingEncoding(NSUTF8StringEncoding)!, options: .MutableContainers)

let user = User(dict: dict) //You can pass any dictionary not neccessarily from Json only
```

```Swift
class User: NRMirror {

var name: String?  //optional string
var userId = 0 // integer
var emailId = "" //String
var isActiveUser = false   //Bool
var category: Category?    //Optional NRMirror subclass
var categoryArray = [Category]()  // Array of NRMirror subclass
var subUsers =  [String]() //Array of strings
var dictTest =  ["categories": [Category]()]  //Dictionary with key as a string and value is any NRMirror class

}


class Category: NRMirror {
var categoryId = 1
var categoryName = ""

}

```
## Release Notes
Following types not supported in NRMirror :
- **Optional Int** for ex userID: Int? is not allowed in NRMirror you have to intialize it with default value like userId = 0
- **Array of Optionals** for  var subUsers =  [String?] not allowed.
- If you are sure value is not going to be optional/nil then intialize property with default value like with blank string or 0 for Int


## Contributing

Contributions are always welcome! (:

1. Fork it ( http://github.com/naveenrana1309/NRMirror/fork )
2. Create your feature branch ('git checkout -b my-new-feature')
3. Commit your changes ('git commit -am 'Add some feature')
4. Push to the branch ('git push origin my-new-feature')
5. Create new Pull Request

## Compatibility

Xcode 8+ , Swift 3 , iOS 9+ and above

## Author

Naveen Rana. [See Profile](https://www.linkedin.com/in/naveen-rana-9a371a40)

Email: 
naveenrana1309@gmail.com. 

Check out [Facebook Page](https://www.facebook.com/iOSByHeart/) for detail.

## License

NRMirror is available under the MIT license. See the LICENSE file for more info.
