//
//  ViewController.swift
//  SwiftDefaults
//
//  Created by shimesaba9 on 01/12/2016.
//  Copyright (c) 2016 shimesaba9. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(MyDefaults().value2)
        MyDefaults().value2 = "2"
        print(MyDefaults().value2)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self, selector: #selector(ViewController.value4DidChanged),
            name: "value4DidChanged", object: nil)
        
        print("Stored person instance: \(MyDefaults().value4)")
        let p = Person()
        p.firstName = "Elvis"
        p.lastName = "Presley"
        p.age = 42
        MyDefaults().value4 = p
        print("Stored person instance: \(MyDefaults().value4)")
        MyDefaults().value4 = nil
        print("Stored nil person: \(MyDefaults().value4)")
    }
    
    func value4DidChanged() {
        print("value4 did changed.")
    }
}
