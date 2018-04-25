//
//  MyDefaults.swift
//  SwiftDefaults
//
//  Created by 杉本裕樹 on 2016/01/12.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import SwiftDefaults

class MyDefaults: SwiftDefaults {
    @objc dynamic var value: String? = "10"
    @objc dynamic var value2: String = "10"
    @objc dynamic var value3: Int = 1
    @objc dynamic var value4: Person? = nil
    @objc dynamic var value5: Date? = nil
}

