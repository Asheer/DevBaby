//
//  CreateChildProfileViewController.swift
//  BabyDev
//
//  Created by Jerry Herrera on 11/14/15.
//  Copyright © 2015 Jerry Herrera. All rights reserved.
//

import UIKit

class CreateChildProfileViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    weak var delegate: CreateChildViewControllerDelegate!
    @IBOutlet weak var autisticSwitch: UISwitch!
    @IBOutlet weak var dyslexiaSwitch: UISwitch!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    var titleLabel = UILabel();
    var gender = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gender = "Male"
        autisticSwitch.on = false
        dyslexiaSwitch.on  = false
        self.view.backgroundColor = UIColor.whiteColor()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapGestureRecognizer)
        nameTextField.delegate = self
        weightTextField.delegate = self
        birthdayPicker.datePickerMode = UIDatePickerMode.Date
        self.navigationController?.navigationBarHidden = false
        
        // init the label for nav bar title
        
        // titleLabel = (self.navigationItem.titleView is? UILabel)!
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel = (UILabel.init(frame: CGRectZero))
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont(name: "Verdana", size: 14)
        titleLabel.text = "Set Baby Profile"
        titleLabel.textAlignment = .Center
        (titleLabel.sizeToFit())
        self.navigationItem.titleView = titleLabel
    self.navigationController?.navigationBar.configureFlatNavigationBarWithColor(UIColor.peterRiverColor())
        
        genderSegment.setTitle("Male", forSegmentAtIndex: 0)
        genderSegment.setTitle("Female", forSegmentAtIndex: 1)
    }
    
    @IBAction func segmentedPressed(sender: AnyObject){
        switch genderSegment.selectedSegmentIndex
    {
        case 0:
            gender = "Male"
        case 1:
            gender = "Female"
            
        default:
            break;
    }
}
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func autisticAction(sender: AnyObject) {
        
        if autisticSwitch.on {
            
        }
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func printNSDefaults(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let childProfiles = defaults.arrayForKey(Keys.ChildProfiles) as? [NSData] {
            print("We had child profiles")
            
            for childData in childProfiles {
                let child = NSKeyedUnarchiver.unarchiveObjectWithData(childData) as? Child
                if child != nil {
                    print("\(child!.name) \(child!.weight) \(child!.birthday.description)")
                }
            }
            
        } else {
            print("Nothing stored in defaults")
        }
    }
    
    @IBAction func submitProfileInfo(sender: AnyObject) {
        
        if nameTextField.text == "" { print("name text field empty"); return }
        if let weight = NSNumberFormatter().numberFromString(weightTextField.text!)?.doubleValue {
            
            var isAutistic: Bool
            var isDyslexia: Bool
            
            if autisticSwitch.on {
                isAutistic = true
            }
            else {
                isAutistic = false
                print("not aut")
            }
            
            if dyslexiaSwitch.on {
                isDyslexia = true
            }
            else {
                isDyslexia = false
                print("not dys")
            }
            
            print("gender is \(gender)")
            
            let newChild = Child(name: nameTextField.text!, weight: weight, birthday: birthdayPicker.date, autistic: isAutistic,dyslexia: isDyslexia,gender: self.gender)
            
            var profiles = NSUserDefaults.standardUserDefaults().arrayForKey(Keys.ChildProfiles) as? [NSData]
            if profiles == nil {
                var arrayData = [NSData]()
                let archivedData = NSKeyedArchiver.archivedDataWithRootObject(newChild)
                arrayData.append(archivedData)
                NSUserDefaults.standardUserDefaults().setObject(arrayData, forKey: Keys.ChildProfiles)
            } else {
                profiles!.append(NSKeyedArchiver.archivedDataWithRootObject(newChild))
                NSUserDefaults.standardUserDefaults().setObject(profiles!, forKey: Keys.ChildProfiles)
            }
            delegate.presentTasksViewController()
        } else {
            print("Weight invalid")
            return
        }
        //could validate date as well
    }
}

protocol CreateChildViewControllerDelegate: class {
    func presentTasksViewController()
}

extension CreateChildProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case nameTextField: weightTextField.becomeFirstResponder()
        case weightTextField: dismissKeyboard()
        default: break
        }
        return true
    }
}
