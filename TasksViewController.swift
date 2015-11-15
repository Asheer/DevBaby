//
//  TasksViewController.swift
//  BabyDev
//
//  Created by Jerry Herrera on 11/14/15.
//  Copyright © 2015 Jerry Herrera. All rights reserved.
//

import UIKit
import SpriteKit

class TasksViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    var tasks = ["Jump", "Walk", "Talk"] // baby activities
    var data = Data()
    var categories = [String]()
    var titleLabel = UILabel();
    var months = Int()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        for (key, _) in data.dict {
            categories.append(key)
        }
        
        printNSUser(self)

        // init the label for nav bar title
        
       // titleLabel = (self.navigationItem.titleView is? UILabel)!
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel = (UILabel.init(frame: CGRectZero))
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont(name: "Verdana", size: 14)
        let babyData = NSUserDefaults.standardUserDefaults().objectForKey(Keys.CurrentChild) as! NSData
        let baby = NSKeyedUnarchiver.unarchiveObjectWithData(babyData) as! Child
        titleLabel.text = baby.name
        titleLabel.textAlignment = .Center
        (titleLabel.sizeToFit())
        self.navigationItem.titleView = titleLabel
        self.navigationController?.navigationBar.configureFlatNavigationBarWithColor(UIColor.peterRiverColor())
        self.navigationController?.navigationBarHidden = false
        tableView.delegate = self
        tableView.dataSource = self
     //   tableView.separatorColor = UIColor.redColor()
        // Do any additional setup after loading the view.
        
        self.navigationItem.setLeftBarButtonItem(UIBarButtonItem(title: "Children", style: UIBarButtonItemStyle.Plain, target: self, action: "childrenPressed"), animated: false)
        
    }
    
    func childrenPressed() {
        print("children pressed")
        performSegueWithIdentifier("toChildren", sender: self)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("called segue")

        switch segue.identifier! {
        case "showTask":
            //let destinationVC = segue.destinationViewController as! TaskDetailsViewController
            //destinationVC.
            let destinationVC = segue.destinationViewController as! TasksDetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            let cell = tableView.cellForRowAtIndexPath(indexPath!)
            destinationVC.tasks = data.dict[categories[indexPath!.row]]!
            tableView.deselectRowAtIndexPath(indexPath!, animated: false)
            break
        case "toChildren":
            print("Hi")
        default: break
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    @IBAction func clearDefaults(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(nil, forKey: Keys.ChildProfiles)
    }
    
  
    func barButtonItemClicked(sender : UIBarButtonItem) {
        print("clicked button")
    }
    @IBAction func printNSUser(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let childProfiles = defaults.arrayForKey(Keys.ChildProfiles) as? [NSData] {
            print("We had child profiles")
            
            for childData in childProfiles {
                print("spot 1")
                let child = NSKeyedUnarchiver.unarchiveObjectWithData(childData) as? Child
                print("spot 2")
                if child != nil {
                    var calendar: NSCalendar = NSCalendar.currentCalendar()
                    var todayDate = NSDate()
                    let flags = NSCalendarUnit.Day
                    let components = calendar.components(flags, fromDate: child!.birthday, toDate: todayDate,options:[])
                    months = components.day
                   
                    print("\(child!.name) \(child!.birthday.description)")
                    if child?.autistic == true {
                        print("child is autistic")
                    } else {
                        print("child is not autistic")
                    }
                
                    if(child?.dyslexia == true) {
                        print("child has dyslexia")
                    } else {
                        print("child does not have dyslexia")
                    }
                }
            }
            
            // tasks here
            
            
            
            
        } else {
            print("We have nothing stored")
        }
    }
}


extension TasksViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell?.textLabel?.text = categories[indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showTask", sender: nil)

    }
    
}
