//
//  AddAccountViewController.swift
//  HashtagFinance
//
//  Created by Rhiannon Weiss on 4/8/16.
//  Copyright © 2016 Rhiannon Weiss. All rights reserved.
//

import UIKit

class AddAccountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var accountNameTextField: UITextField!
    @IBOutlet weak var accountTotalTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var account: Account?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        accountNameTextField.delegate = self
        accountTotalTextField.delegate = self
        
        if let account = account {
            accountNameTextField.text = account.account
            accountTotalTextField.text = String(account.total)
        }
        
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor(red:0.0, green:0.5, blue:0.25, alpha:1.0).CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if submitButton === sender {
            let name = accountNameTextField.text!
            let total = Double(accountTotalTextField.text!)!
            
            account = Account(account: name, total: total)
        }
    }
    
}
