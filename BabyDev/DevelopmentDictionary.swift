//
//  DevelopmentDictionary.swift
//  BabyDev
//
//  Created by Final on 11/15/15.
//  Copyright © 2015 Jerry Herrera. All rights reserved.
//

import Foundation

class Task {
    var name: String
    var minAge: Int
    var maxAge: Int
    var interactive: Bool
    var autistic: Bool = false
    var dyscalculia: Bool = false
    var adhd: Bool = false
    var dyslexic: Bool = false
    init(name: String, min: Int, max: Int, interactive: Bool, autistic: Bool = false, dyscalculia: Bool = false, adhd: Bool = false, dyslexic: Bool = false) {
        self.name = name
        self.minAge = min
        self.maxAge = max
        self.interactive = interactive
        self.autistic = autistic
        self.dyscalculia = dyscalculia
        self.adhd = adhd
        self.dyslexic = dyslexic
    }
}

struct Data {
    var dict = [String: [Task]]()
    init () {
        dict["Visual"] = [Task(name: "Exposure to Juggling", min: 3, max: 4, interactive: false), Task(name: "Direction of Tilt", min: 3, max: 4, interactive: false)]
        dict["Reading and Language"] = [Task(name: "Phonic Match/Phonic Word", min: 4, max: 18, interactive: false), Task(name: "Reading Stories Out Loud", min: 42, max: 144, interactive: false), Task(name: "FastForword Program", min: 42, max: 144, interactive: false, autistic: false, dyscalculia: false, adhd: false, dyslexic: true), Task(name: "Rapid Autonaming", min: 42, max: 144, interactive: false, autistic: false, dyscalculia: false, adhd: false, dyslexic: true), Task(name: "Phonic Match/Phonic Word", min: 42, max: 144, interactive: false, autistic: false, dyscalculia: false, adhd: false, dyslexic: true)]
        
        dict["Social Communication"] = [Task(name: "Exposure to Gestures", min: 3, max: 12, interactive: false, autistic: false), Task(name: "Facial Processing", min: 6, max: 9, interactive: false, autistic: false), Task(name: "Speech Therapy", min: 15, max: 144, interactive: false, autistic: true), Task(name: "ABA Therapy", min: 15, max: 144, interactive: false, autistic: true)]
        dict["Number Sensing"] = [Task(name: "Numerical Change Detection", min: 6, max: 7, interactive: false), Task(name: "Approximate Number System", min: 6, max: 42, interactive: false), Task(name: "Math Tutoring/Lattice Multiplication", min: 96, max: 108, interactive: false), Task(name: "Approximate Number System", min: 42, max: 144, interactive: false, dyscalculia: true)]
        dict["Memory"] = [Task(name: "Visual Paired Comparison", min: 0, max: 6, interactive: false), Task(name: "Location or Shapes Recall", min: 4, max: 120, interactive: false), Task(name: "Baby Mobile memory", min: 1, max: 1, interactive: false)]
        dict["Higher Level Function"] = [Task(name: "Self Restraint Task", min: 6, max: 20, interactive: false), Task(name: "Reading or Problem-Solving Engagement", min: 6, max: 20, interactive: false), Task(name: "Meditation", min: 48, max: 144, interactive: false, autistic: false, dyscalculia: false, adhd: true), Task(name: "Reading or Problem-Solving engagement", min: 48, max: 144, interactive: false, autistic: false, dyscalculia: false, adhd: true), Task(name: "Flanker/Stroop Test", min: 6, max: 20, interactive: false)]
    }
    
}



