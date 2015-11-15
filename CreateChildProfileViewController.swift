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
    weak var delegate: CreateChildViewControllerDelegate?
    @IBOutlet weak var autisticSwitch: UISwitch!
    @IBOutlet weak var dyslexiaSwitch: UISwitch!

    @IBOutlet weak var genderSegment: UISegmentedControl!
    
    @IBOutlet weak var dyscallculiaSwitch: UISwitch!
    @IBOutlet weak var dateField: UITextField!
    var titleLabel = UILabel();
    var gender = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            var background = UIImage(imageLiteral: "iphone5_ios7.jpg")
            var backgroundImage = UIImageView.init(frame: self.view.frame)
        
    
        backgroundImage.image = background
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        
        gender = "Male"
        autisticSwitch.on = false
        dyslexiaSwitch.on  = false
        dyscallculiaSwitch.on  = false

        self.view.backgroundColor = UIColor.whiteColor()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapGestureRecognizer)
        nameTextField.delegate = self
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
        dateField.delegate = self
        self.navigationItem.titleView = titleLabel
    self.navigationController?.navigationBar.configureFlatNavigationBarWithColor(UIColor.clearColor())
        
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
                    
                    print("\(child!.name) \(child!.birthday.description)")
                }
            }
            
        } else {
            print("Nothing stored in defaults")
        }
    }
    
    @IBAction func submitProfileInfo(sender: AnyObject) {
        
        if nameTextField.text == "" { print("name text field empty"); return }
        
            var isAutistic: Bool
            var isDyslexia: Bool
            var dyscall: Bool
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
        if dyscallculiaSwitch.on {
            dyscall = true
        }
        else {
            dyscall = false
            print("not dys")
        }
        
            print("gender is \(gender)")
        
        
        var dateString = dateField.text
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.dateFromString(dateString!)
            
        let newChild = Child(name: nameTextField.text!, birthday: date!, autistic: isAutistic,dyslexia: isDyslexia, dyscall: dyscall ,gender: self.gender)
            
        var profiles = NSUserDefaults.standardUserDefaults().arrayForKey(Keys.ChildProfiles) as? [NSData]
        var archivedChild = NSKeyedArchiver.archivedDataWithRootObject(newChild)
        if profiles == nil {
            var arrayData = [NSData]()
            arrayData.append(archivedChild)
            NSUserDefaults.standardUserDefaults().setObject(arrayData, forKey: Keys.ChildProfiles)
        } else {
            profiles!.append(archivedChild)
            NSUserDefaults.standardUserDefaults().setObject(profiles!, forKey: Keys.ChildProfiles)
        }
        NSUserDefaults.standardUserDefaults().setObject(archivedChild, forKey: Keys.CurrentChild)
        delegate?.presentTasksViewController()
        if delegate == nil {
            var viewstack = self.navigationController?.viewControllers
            var index = viewstack!.count - 2
            (viewstack![index] as! ChildrenViewController).childrenTableView.reloadData()
            self.navigationController?.popViewControllerAnimated(true)
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
        case nameTextField: self.view.endEditing(true)
        default: break
        }
        return true
    }
}
