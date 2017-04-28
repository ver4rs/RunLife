//
//  FirstViewController.swift
//  RuLife
//
//  Created by Martin Sekerák on 14.02.16.
//  Copyright © 2016 Martin Sekerák. All rights reserved.
//

import UIKit

@IBDesignable
class HomeViewController: UIViewController {

    /*
        button start
    */
    @IBOutlet weak var buttonBeginRun: UIButton! {
        didSet {
            buttonBeginRun.backgroundColor = UIColor(red: 90/255.0, green: 195/255.0, blue: 175/255.0, alpha: 1)
            //buttonBeginRun.backgroundColor = self.navigationController?.navigationBar.barTintColor
            buttonBeginRun.tintColor = UIColor.whiteColor() //UIColor(red: 22/255.0, green: 160/255.0, blue: 133/255.0, alpha: 1)
            
            buttonBeginRun.layer.borderWidth = 0
            buttonBeginRun.layer.cornerRadius = 8
            buttonBeginRun.layer.borderColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1).CGColor
            buttonBeginRun.alpha = 0.9
        }
    }
    @IBOutlet weak var tableView: UITableView!
   
    
    @IBOutlet weak var settingButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //tab bar
        self.tabBarController?.tabBar.hidden = false
        
        
//        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
//        print(paths[0])
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.tabBar.hidden = false
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

