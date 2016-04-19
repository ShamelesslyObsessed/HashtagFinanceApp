//
//  LoginViewController.swift
//  HashtagFinance
//
//  Created by Rhiannon Weiss on 4/9/16.
//  Copyright © 2016 Rhiannon Weiss. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor(red:0.0, green:0.5, blue:0.25, alpha:1.0).CGColor

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
