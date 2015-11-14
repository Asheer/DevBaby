//
//  Child.swift
//  BabyDev
//
//  Created by Jerry Herrera on 11/14/15.
//  Copyright © 2015 Jerry Herrera. All rights reserved.
//

import Foundation

class Child: NSObject, NSCoding {
    var name: String
    var gender: String
    var weight: Double
    var birthday: NSDate
    var autistic: Bool
    var dyslexia: Bool
    
    init(name: String, weight: Double, birthday: NSDate, autistic: Bool, dyslexia: Bool,gender: String) {
        self.name = name
        self.weight = weight
        self.birthday = birthday
        self.autistic = autistic
        self.dyslexia = dyslexia
        self.gender = gender
    }
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey(Keys.ChildName) as! String
        //self.weight = aDecoder.decodeObjectForKey(Keys.ChildWeight) as! Double
        self.weight = aDecoder.decodeDoubleForKey(Keys.ChildWeight) as! Double
        self.birthday = aDecoder.decodeObjectForKey(Keys.ChildBirthday) as! NSDate
        self.autistic = aDecoder.decodeBoolForKey(Keys.has_autistic) as! Bool
        self.dyslexia = aDecoder.decodeBoolForKey(Keys.has_dyslexia) as! Bool
        self.gender = aDecoder.decodeObjectForKey(Keys.gender) as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: Keys.ChildName)
        aCoder.encodeDouble(weight, forKey: Keys.ChildWeight)
        aCoder.encodeObject(birthday, forKey: Keys.ChildBirthday)
        aCoder.encodeBool(autistic, forKey: Keys.has_autistic)
        aCoder.encodeBool(dyslexia, forKey: Keys.has_dyslexia)
        aCoder.encodeObject(gender, forKey: Keys.gender)

    }
}