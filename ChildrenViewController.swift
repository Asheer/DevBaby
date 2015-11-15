//
//  ChildrenViewController.swift
//  BabyDev
//
//  Created by Final on 11/15/15.
//  Copyright © 2015 Jerry Herrera. All rights reserved.
//

import UIKit

class ChildrenViewController: UIViewController {
    var children = [Child]()
    

    @IBOutlet weak var childrenTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        childrenTableView.delegate = self
        childrenTableView.dataSource = self
  
        
        self.modalPresentationStyle = UIModalPresentationStyle.Popover
 
        
        var childrenData = NSUserDefaults.standardUserDefaults().arrayForKey(Keys.ChildProfiles) as! [NSData]
        for data in childrenData {
            children.append(NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Child)
        }
    }

    @IBAction func addChild(sender: AnyObject) {
        print("prssed")
    }
}

extension ChildrenViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return children.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = children[indexPath.row].name
        return cell!
    }
    
}
