//
//  AddGroupViewController.swift
//  HashtagFinance
//
//  Created by Rhiannon Weiss on 4/9/16.
//  Copyright © 2016 Rhiannon Weiss. All rights reserved.
//

import UIKit

class AddGroupViewController: UIViewController {
    
    // Here's outlets to all of the UI items we'll work with for this view controller
    @IBOutlet weak var groupTotalTextField: UITextField!
    @IBOutlet weak var groupNameTextField: UITextField!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addMembersButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Give each of the buttons a rounded, green border
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor(red:0.0, green:0.5, blue:0.25, alpha:1.0).CGColor
        
        addMembersButton.layer.cornerRadius = 5
        addMembersButton.layer.borderWidth = 1
        addMembersButton.layer.borderColor = UIColor(red:0.0, green:0.5, blue:0.25, alpha:1.0).CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
