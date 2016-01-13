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
    }
}
