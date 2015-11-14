//
//  TasksViewController.swift
//  BabyDev
//
//  Created by Jerry Herrera on 11/14/15.
//  Copyright © 2015 Jerry Herrera. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var tasks = ["Jump", "Walk", "Talk"] // baby activities
    var titleLabel = UILabel();
    override func viewDidLoad() {
        
        super.viewDidLoad()
        printNSUser(self)
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "barButtonItemClicked:"), animated: true) // add bbutton on bar
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.blackColor()
        // init the label for nav bar title
        
       // titleLabel = (self.navigationItem.titleView is? UILabel)!
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel = (UILabel.init(frame: CGRectZero))
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont(name: "Verdana", size: 14)
        titleLabel.text = "Baby Tasks"
        titleLabel.textAlignment = .Center
        (titleLabel.sizeToFit())
        self.navigationItem.titleView = titleLabel
        
        self.navigationController?.navigationBar.configureFlatNavigationBarWithColor(UIColor.peterRiverColor())
        self.navigationController?.navigationBarHidden = false
        tableView.delegate = self
        tableView.dataSource = self
     //   tableView.separatorColor = UIColor.redColor()
        // Do any additional setup after loading the view.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
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
                let child = NSKeyedUnarchiver.unarchiveObjectWithData(childData) as? Child
                if child != nil {
                    print("\(child!.name) \(child!.weight) \(child!.birthday.description)")
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
        return tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = tasks[indexPath.row]
        return cell!
    }
}
