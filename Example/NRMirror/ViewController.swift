//
//  ViewController.swift
//  NRMirror
//
//  Created by Naveen Rana on 27/07/16.
//  Copyright © 2016 Naveen Rana. All rights reserved.
//

import UIKit
import NRMirror


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        liveTest()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func liveTest() {
        let jsonString = "{\"userId\": 1 ,\"name\":\"naveen\",\"emailId\":\"naveen@appster\",\"isActiveUser\": true,\"category\":{\"categoryId\": 2 , \"categoryName\": \"testnaveenrana\"},\"categoryArray\":[{\"categoryId\": 1 , \"categoryName\": \"naveen\"}],\"subUsers\":[\"array1\",\"array2\"]}"
        let dict = try! NSJSONSerialization.JSONObjectWithData(jsonString.dataUsingEncoding(NSUTF8StringEncoding)!, options: .MutableContainers)
        let user = User(dict: jsonString)
        print("name = \(user.name)")
        
    }
    
}

class User: NRMirror {
    
    var name: String?
    var userId = 0
    var emailId = ""
    var isActiveUser = false
    var category: Category?
    var categoryArray = [Category]()
    var subUsers =  [String]()
    var dictTest =  ["categories": [Category]()]
    
    
}

class PureClass {
    
}

class Category: NRMirror {
    
    var categoryId = 1
    var categoryName = ""
}


 