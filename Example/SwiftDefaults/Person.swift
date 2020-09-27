//
//  Person.swift
//  SwiftDefaults
//
//  Created by VLADIMIR KONEV on 22.01.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

class Person: NSObject, NSCoding{
    public func encode(with aCoder: NSCoder) {
    }

    var firstName: String? = ""
    var lastName: String? = ""
    var age: Int = 18

    override init(){
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        firstName = aDecoder.decodeObject(forKey: "firstName") as? String
        lastName = aDecoder.decodeObject(forKey: "lastName") as? String
        age = aDecoder.decodeInteger(forKey: "age")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(age, forKey: "age")
    }
}

extension Person{
    // Readable print
    override var description: String{
        return "Person=\((firstName, lastName, age))"
    }
}
