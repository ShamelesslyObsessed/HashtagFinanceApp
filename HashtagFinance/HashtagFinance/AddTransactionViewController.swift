//
//  AddTransactionViewController.swift
//  HashtagFinance
//
//  Created by Rhiannon Weiss on 4/8/16.
//  Copyright © 2016 Rhiannon Weiss. All rights reserved.
//

import UIKit

class AddTransactionViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate  {
    
    // Each of the outlets for UI items in this view controller
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // Custom subtract and add buttons
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var newTransaction: Bool = true
    
    var transaction: Transaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Make each item its own delegate
        amountTextField.delegate = self
        nameTextField.delegate = self
        descriptionTextView.delegate = self
        
        // Set up views if editing an existing item
        if let transaction = transaction {
            amountTextField.text = String(transaction.amount)
            nameTextField.text = transaction.name
            descriptionTextView.text = transaction.desc
            datePicker.date = transaction.date
            newTransaction = false
        }
        
        // Make the button have rounded corners and green border.
        descriptionTextView.layer.cornerRadius = 5
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor(red:0.0, green:0.5, blue:0.25, alpha:1.0).CGColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedAdd(sender: UIButton) {
        // Make transaction positive
        let text: String = amountTextField.text!
        if (text[text.startIndex.advancedBy(0)] == "-") {
            amountTextField.text = String(amountTextField.text!.characters.dropFirst())
        }
    }
    
    @IBAction func pressedSubtract(sender: UIButton) {
        // Make tranasction negative
        let text: String = amountTextField.text!
        if (text[text.startIndex.advancedBy(0)] != "-"){
            amountTextField.text = "-" + amountTextField.text!
        }
    }
    
    // Create an item for the CustomListTable to use if the Save button was pressed
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if submitButton === sender {
            
            let amount = Double(amountTextField.text!)!
            let name = nameTextField.text!
            let desc = descriptionTextView.text ?? ""
            let date = datePicker.date
            
            if (newTransaction){
                transaction = Transaction(amount: amount, name: name, desc: desc, date: date)
                transactionTotal = transactionTotal + amount
            }
            else {
                transaction?.amount = amount
                transaction?.name = name
                transaction?.date = date
                transaction?.desc = desc
            }
        }
    }
    
}
