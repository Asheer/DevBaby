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
    var birthday: NSDate
    var autistic: Bool
    var dyslexia: Bool
    var dyscall: Bool
    init(name: String, birthday: NSDate, autistic: Bool, dyslexia: Bool ,dyscall: Bool,gender: String) {
        self.name = name
        self.birthday = birthday
        self.autistic = autistic
        self.dyslexia = dyslexia
        self.gender = gender
        self.dyscall = dyscall
    }
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey(Keys.ChildName) as! String
        //self.weight = aDecoder.decodeObjectForKey(Keys.ChildWeight) as! Double
        self.birthday = aDecoder.decodeObjectForKey(Keys.ChildBirthday) as! NSDate
        self.autistic = aDecoder.decodeBoolForKey(Keys.has_autistic) as! Bool
        self.dyslexia = aDecoder.decodeBoolForKey(Keys.has_dyslexia) as! Bool
        self.gender = aDecoder.decodeObjectForKey(Keys.gender) as! String
        print("spot 1.5")
        self.dyscall = aDecoder.decodeBoolForKey(Keys.has_dyscall) 

    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: Keys.ChildName)
        aCoder.encodeObject(birthday, forKey: Keys.ChildBirthday)
        aCoder.encodeBool(autistic, forKey: Keys.has_autistic)
        aCoder.encodeBool(dyslexia, forKey: Keys.has_dyslexia)
        aCoder.encodeObject(gender, forKey: Keys.gender)
        aCoder.encodeBool(dyscall, forKey: Keys.has_dyscall)

    }
}