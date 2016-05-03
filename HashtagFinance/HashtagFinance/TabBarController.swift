//
//  TabBarController.swift
//  HashtagFinance
//
//  Created by Rhiannon Weiss on 4/8/16.
//  Copyright © 2016 Rhiannon Weiss. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Give the tab bar buttons a new tint color
        self.tabBar.tintColor = UIColor(red:0.0, green:0.5, blue:0.25, alpha:1.0)
        
        // Start the tab controller on the middle selection
        self.selectedIndex = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
