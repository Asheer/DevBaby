//
//  TasksDetailViewController.swift
//  BabyDev
//
//  Created by Final on 11/14/15.
//  Copyright © 2015 Jerry Herrera. All rights reserved.
//

import UIKit

class TasksDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tasks = [Task]()
    var relevantTasks = [Task]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
            var titleLabel = UILabel()
        // titleLabel = (self.navigationItem.titleView is? UILabel)!
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel = (UILabel.init(frame: CGRectZero))
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont(name: "Verdana", size: 14)
        titleLabel.text = "Baby Name Here"
        titleLabel.textAlignment = .Center
        (titleLabel.sizeToFit())
        self.title = titleLabel.text!
        self.navigationController?.navigationBarHidden = false
        // Do any additional setup after loading the view.
        
        let currentChildData = NSUserDefaults.standardUserDefaults().objectForKey(Keys.CurrentChild) as! NSData
        let currentChild = NSKeyedUnarchiver.unarchiveObjectWithData(currentChildData) as! Child
        //to calc age
        let startDate = currentChild.birthday
        let endDate = NSDate()
        let cal = NSCalendar.currentCalendar()
        let unit = NSCalendarUnit.Month
        let components = cal.components(unit, fromDate: startDate, toDate: endDate, options: NSCalendarOptions.SearchBackwards)
        self.title = currentChild.name + ", \(components.month) months"
        let monthsOld = components.month
        for task in tasks {
            if monthsOld >= task.minAge && monthsOld <= task.maxAge {
                if currentChild.autistic == task.autistic || currentChild.dyscall == task.dyscalculia || currentChild.dyslexia == task.dyslexic {
                    relevantTasks.append(task)
                }
            }
        }
        
        
        //to do:
        //1) add different children
        //2) pick relevant exercises
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toMatch" {
            //pass whatever info
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
       func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //return categories.count
            return relevantTasks.count
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            //
            var cell = tableView.dequeueReusableCellWithIdentifier("cell")
            if cell == nil {
                cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
            }
            cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell!.textLabel?.text = relevantTasks[indexPath.row].name

            return cell!
        }
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         //   self.performSegueWithIdentifier("showTask", sender: indexPath)
            
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            
            if (cell!.textLabel!.text == "Phonic Match/Phonic Word") {
                self.performSegueWithIdentifier("toMatch", sender: nil)
                
            } else {
                //navigate to other VC
                self.performSegueWithIdentifier("fromDetail", sender: nil)
            }
            
        }
 }