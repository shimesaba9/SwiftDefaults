//
//  Person.swift
//  SwiftDefaults
//
//  Created by VLADIMIR KONEV on 22.01.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

class Person: NSObject, NSCoding{
    var firstName: String? = ""
    var lastName: String? = ""
    var age: Int = 18

    override init(){
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        firstName = aDecoder.decodeObjectForKey("firstName") as? String
        lastName = aDecoder.decodeObjectForKey("lastName") as? String
        age = aDecoder.decodeIntegerForKey("age")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(firstName, forKey: "firstName")
        aCoder.encodeObject(lastName, forKey: "lastName")
        aCoder.encodeInteger(age, forKey: "age")
    }
}

extension Person{
    // Readable print
    override var description: String{
        return "Person=\(firstName, lastName, age)"
    }
}