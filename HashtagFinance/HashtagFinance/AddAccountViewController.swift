//
//  AddAccountViewController.swift
//  HashtagFinance
//
//  Created by Rhiannon Weiss on 4/8/16.
//  Copyright © 2016 Rhiannon Weiss. All rights reserved.
//

import UIKit

class AddAccountViewController: UIViewController, UITextFieldDelegate {

    // Outlets for the two text fields and the submit button.
    @IBOutlet weak var accountNameTextField: UITextField!
    @IBOutlet weak var accountTotalTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var account: Account?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Make each of the text fields delegates of themselves.
        accountNameTextField.delegate = self
        accountTotalTextField.delegate = self
        
        // If editing an exisitng account, fill in the text fields with those values.
        if let account = account {
            accountNameTextField.text = account.account
            accountTotalTextField.text = String(account.total)
        }
        
        // Give the button rounded corners and a green border.
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor(red:0.0, green:0.5, blue:0.25, alpha:1.0).CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // If the submit button is pressed, create an account with the data entered into the text fields
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if submitButton === sender {
            let name = accountNameTextField.text!
            let total = Double(accountTotalTextField.text!)!
            
            account = Account(account: name, total: total)
            NSKeyedArchiver.archiveRootObject(account!, toFile: Account.ArchiveURL.path!)
        }
    }
    
}
