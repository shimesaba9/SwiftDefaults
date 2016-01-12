//
//  MyDefaults.swift
//  SwiftDefaults
//
//  Created by 杉本裕樹 on 2016/01/12.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import Cocoa

class MyDefaults: SwiftDefaults {
    static let sharedInstance = MyDefaults()
    private override init() { super.init() }
    
    dynamic var value: String? = "10"
    dynamic var value2: String = "10"
    dynamic var value3: Int = 1
}
