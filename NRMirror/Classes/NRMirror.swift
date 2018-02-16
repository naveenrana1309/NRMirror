//
//  NRMirror.swift
//  NRMirror
//
//  Created by Naveen Rana on 27/07/16.
//  Copyright © 2016 Naveen Rana. All rights reserved.
//

import Foundation

@objcMembers
open
class NRMirror: NSObject {
    
    
    required override public init() {
        super.init()
    }
    override open func setValue(_ value: Any!, forUndefinedKey key: String) {
        print("\(key) should be in proper format i.e: it should not be optional or it should be of NRMirror type class")
    }
    
    required public init(dict: Any) {
        super.init()
        let mirror = Mirror(reflecting: self) // NRMirror subclass mirroring
        
        if let finalDict = dict as? NSDictionary {
            _ = mirror.children.reduce(self) { (self, child: Mirror.Child) in
                let childMirror = Mirror(reflecting: child.value) // use reduce method for recursion of child->child .... mirroring
                
                if let childMirrorDisplayStyle = childMirror.displayStyle  {
                    
                    switch childMirrorDisplayStyle {
                        
                    case .class,.struct: // when property is of type NRMirror class
                        
                        if let _ = (childMirror.subjectType as? NRMirror.Type) {
                            if let key = child.label {
                                if let objectValue = finalDict[key] {
                                    if !(objectValue is NSNull) {
                                        let subObject = (childMirror.subjectType as! NRMirror.Type).init(dict: objectValue as AnyObject)
                                        self.setValue(subObject, forKey: key)
                                        
                                    }
                                }
                                
                            }
                            
                        }
                        else {
                            print("Class should be of NRMirror type error:\(childMirror.subjectType) not allowed")
                        }
                    case .collection, .set:
                        
                        if let className = NRMirror.getClassName(String(describing: childMirror.subjectType)) {
                            if let finalClass =  NSClassFromString("\(NRMirror.getAppName()).\(className)") {
                                if let _ = (finalClass as? NRMirror.Type) {
                                    if let key = child.label {
                                        if let objectValue = finalDict[key] {
                                            if !(objectValue is NSNull) {
                                                if objectValue is NSArray {
                                                    var resultArray = [NRMirror]()
                                                    for objectOfArray in (objectValue as! NSArray) {
                                                        let subObject = (finalClass as! NRMirror.Type).init(dict: objectOfArray as AnyObject)
                                                        resultArray.append(subObject)
                                                        
                                                    }
                                                    self.setValue(resultArray, forKey: key)
                                                    
                                                }
                                                else {
                                                    self.setValue([], forKey: key)
                                                    
                                                }
                                                
                                                
                                            }
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            else { // not a valid class name means this is either the [AnyObject?] optional case or its swift native class String , Array etc
                                if let key = child.label {
                                    if let objectValue = finalDict[key] {
                                        if !(objectValue is NSNull) {
                                            if NRMirror.isArrayDictionaryContainOptionalProperty(String(describing: childMirror.subjectType)) {
                                                print("Array of optional not supported")
                                                
                                            }
                                            else {
                                                self.setValue(objectValue, forKey: key)
                                                
                                            }
                                            
                                        }
                                        else {
                                            self.setValue([], forKey: key)
                                            
                                        }
                                    }
                                    
                                }
                                
                            }
                        }
                        else {
                            print("This type of collection format not supported in NRMirror yet")
                        }
                    case .dictionary:
                        
                        if let className = NRMirror.getClassName(String(describing: childMirror.subjectType)) {
                            var dictValueClassName = ""
                            if  className.components(separatedBy: ",").count > 0 { // get the value type of dictionary
                                dictValueClassName = className.components(separatedBy: ",").last!
                                dictValueClassName = dictValueClassName.trimmingCharacters(in: CharacterSet.whitespaces)
                            }
                            
                            if let finalClass =  NSClassFromString("\(NRMirror.getAppName()).\(dictValueClassName)") {
                                if let _ = (finalClass as? NRMirror.Type) {
                                    if let key = child.label {
                                        if let objectValue = finalDict[key] {
                                            if !(objectValue is NSNull) {
                                                if objectValue is NSDictionary {
                                                    var finalDict = [String: NRMirror]()
                                                    for (dictKey, dictValue) in (objectValue as! NSDictionary) {
                                                        if dictValue is NSDictionary {
                                                            let subObject = (finalClass as! NRMirror.Type).init(dict: dictValue as AnyObject)
                                                            finalDict[dictKey as! String] = subObject
                                                        }
                                                    }
                                                    
                                                    
                                                    self.setValue(finalDict, forKey: key)
                                                    
                                                }
                                                else {
                                                    self.setValue([:], forKey: key)
                                                    
                                                }
                                                
                                                
                                            }
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            else { // not a valid class name means this is either the [AnyObject?] optional case or its swift native class String , Array etc
                                if let key = child.label {
                                    if let objectValue = finalDict[key] {
                                        if !(objectValue is NSNull) {
                                            if NRMirror.isArrayDictionaryContainOptionalProperty(String(describing: childMirror.subjectType)) {
                                                print("Dictionary of optional not supported")
                                                
                                            }
                                            else {
                                                self.setValue(objectValue, forKey: key)
                                                
                                            }
                                            
                                        }
                                        else {
                                            self.setValue([], forKey: key)
                                            
                                        }
                                    }
                                    
                                }
                                
                            }
                        }
                        else {
                            print("This type of collection format not supported in NRMirror yet")
                        }
                        
                        
                    case .optional:
                        
                        if let className = NRMirror.getClassName(String(describing: childMirror.subjectType)) {
                            if let finalClass =  NSClassFromString("\(NRMirror.getAppName()).\(className)") {
                                if let _ = (finalClass as? NRMirror.Type) {
                                    if let key = child.label {
                                        if let objectValue = finalDict[key] {
                                            if !(objectValue is NSNull) {
                                                let subObject = (finalClass as! NRMirror.Type).init(dict: objectValue as AnyObject)
                                                self.setValue(subObject, forKey: key)
                                                
                                            }
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            else {
                                if let key = child.label {
                                    if let objectValue = finalDict[key] {
                                        if !(objectValue is NSNull) {
                                            if objectValue is Int {
                                                print("\(key) Int should not be of optional type , please intialize to some default value")
                                                
                                            }
                                            else {
                                                self.setValue(objectValue , forKey: key)
                                                
                                            }
                                            
                                            
                                        }
                                    }
                                    
                                }
                                
                            }
                        }
                        
                        
                    default:
                        print(mirror.displayStyle.debugDescription)
                    }
                }
                    
                else { //no display style means it is pure swift type(String, Int , double etc..) string (it is not optional)
                    if let key = child.label {
                        
                        if let objectValue = finalDict[key] {
                            if !(objectValue is NSNull) {
                                self.setValue(objectValue, forKey: key)
                                
                            }
                        }
                        
                    }
                    
                }
                
                return self
            }
            
        }
    }
    
    class func getClassName(_ className: String) -> String? { // class name i.e <Swift.String>
        
        if className.contains(">") {
            let subtype = className.components(separatedBy: ">")[0].components(separatedBy: "<").last
            return subtype
            
        }
        return nil
        
    }
    
    class func isArrayDictionaryContainOptionalProperty(_ className: String) -> Bool {
        if className.contains("Optional") { // check is array or dictionary contain any optional property
            return true
        }
        return false
    }
    
    class func getAppName(_ forObject: NSObject? = nil) -> String {
        // if an object was specified, then always use the bundle name of that class
        if forObject != nil {
            return nameForBundle(Bundle(for: type(of: forObject!)))
        }
        
        // If no object was specified but an identifier was set, then use that identifier.
        
        // use the bundle name from the main bundle, if that's not set use the identifier
        return nameForBundle(Bundle.main)
    }
    
    fileprivate static func nameForBundle(_ bundle: Bundle) -> String {
        // get the bundle name from what is set in the infoDictionary
        var appName = bundle.infoDictionary?[kCFBundleNameKey as String] as? String ?? ""
        
        // If it was not set, then use the bundleIdentifier (which is the same as kCFBundleIdentifierKey)
        if appName == "" {
            appName = bundle.bundleIdentifier ?? ""
        }
        appName = appName.split(whereSeparator: {$0 == "."}).map({ String($0) }).last ?? ""
        
        // remove special characters and join them with _
        return appName.components(separatedBy: specialIllegalCharacterSet).joined(separator: "_")
    }
    /// Character that will be replaced by _ from the keys in a dictionary / json
    fileprivate static let specialIllegalCharacterSet = CharacterSet(charactersIn: " -&%#@!$^*()<>?.,:;")
    
}
