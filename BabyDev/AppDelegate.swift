//
//  AppDelegate.swift
//  BabyDev
//
//  Created by Jerry Herrera on 11/14/15.
//  Copyright © 2015 Jerry Herrera. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CreateChildViewControllerDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        var initialViewController: UIViewController!
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let childProfiles = defaults.arrayForKey(Keys.ChildProfiles) as? [NSData] {
            initialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("tasksVC")
            /*for childData in childProfiles {
                let child = NSKeyedUnarchiver.unarchiveObjectWithData(childData) as? Child
            }*/

        } else {
            /*let array = [Child(name: "Tucker", weight: 19.2, birthday: NSDate()), Child(name: "Max", weight: 1.2, birthday: NSDate())]
            var arrayData = [NSData]()
            for child in array {
                let childData = NSKeyedArchiver.archivedDataWithRootObject(child)
                arrayData.append(childData)
            }
            defaults.setObject(arrayData, forKey: Keys.ChildProfiles)*/
            initialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("createVC")
            (initialViewController as! CreateChildProfileViewController).delegate = self
        }
        let navCont = UINavigationController(rootViewController: initialViewController)
        window?.rootViewController = navCont
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func presentTasksViewController() {
        let navCont = window?.rootViewController as! UINavigationController
        navCont.setViewControllers([UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("tasksVC")], animated: true)
    }
}



//if we have child profiles, go to tasksViewController
//if not, go to createChildProfileViewController

