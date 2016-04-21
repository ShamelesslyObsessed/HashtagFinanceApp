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
        
        let navItemImage = UIImageView(frame: CGRectMake(1, 1, 10, 10))
        let logo = UIImage(named: "logo-black-sm.png")
        navItemImage.image = logo
        
        navigationItem.titleView = navItemImage
        self.tabBar.tintColor = UIColor(red:0.0, green:0.5, blue:0.25, alpha:1.0)
        self.selectedIndex = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
