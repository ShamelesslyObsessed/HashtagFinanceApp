//
//  ViewController.swift
//  HashtagFinance
//
//  Created by Rhiannon Weiss on 4/8/16.
//  Copyright © 2016 Rhiannon Weiss. All rights reserved.
//

import UIKit


public var money: Double!
public var transactionTotal = 0.0

// globally accessible arrays to hold transactions and accounts
var transactions = [Transaction]()
var accounts = [Account]()

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!      // table view containing the transactions
    @IBOutlet weak var homeButton: UITabBarItem!
    @IBOutlet weak var moneyLabel: UILabel!         // big label displaying the total
    
    // used to save off original money value
    var moneyOriginal: Double!
    var selectedRow: NSIndexPath!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        // Load any saved items, otherwise toss in sample data
        if let savedItems = loadItems() {
            transactions += savedItems
        }
        else {
            testItems()
        }
    }
    
    // When the view appears
    override func viewDidAppear(animated: Bool) {
        // Used the saved value to refresh the money label text
        moneyOriginal = money
        
        // If money is nil, set the amount to the first account's total, otherwise update the total for 
        if (money == nil) {
            moneyLabel.text = "$" + String(accounts.first!.total)
        }
        else {
            if (transactionTotal == 0) {
                moneyLabel.text = "$" + String(money)
            }
            else {
                updateMoneyLabel()
            }
        }
    }
    
    func updateMoneyLabel() {
        // This function updates the big money label whenever a transaction has been made.
        let moneyAfterTransactions = moneyOriginal + transactionTotal
        let moneyString = "$" + String(moneyAfterTransactions)
        moneyLabel.text = moneyString
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TransactionTableViewCell", forIndexPath: indexPath) as! TransactionTableViewCell
        
        // For the selected row, grab that transaction
        let transaction = transactions[indexPath.row]
        
        // Set the "amount" label to the transaction's amount.
        // Set the "name" label to the transaction's name
        cell.amountLabel.text = String(transaction.amount)
        cell.nameLabel.text = transaction.name
        
        // Format the transaction's date and set the "date" label to it
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        let dateString = formatter.stringFromDate(transaction.date)
        
        cell.dateLabel.text = dateString
        
        // Decides whether the tranasction is positive or negative. If it is positive, make the 
        // text color green, otherwise make the text color red.
        let transactionAmount = String(transaction.amount)
        if (transactionAmount[transactionAmount.startIndex.advancedBy(0)] != "-") {
            cell.amountLabel.textColor = UIColor(red:0.0, green:0.5, blue:0.25, alpha:1.0)
        }
        else {
            cell.amountLabel.textColor = UIColor.redColor()
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                // The number of rows in the section is equal the number of tranasctions.
        return transactions.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Number of sections - only need one.
        return 1
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         selectedRow = tableView.indexPathForSelectedRow
        
        let itemDetailViewController = segue.destinationViewController as! AddTransactionViewController
        if let selectedCell = sender as? TransactionTableViewCell {
            
            // Get the cell that was selected
            let indexPath = tableView.indexPathForCell(selectedCell)!
            let selectedItem = transactions[indexPath.row]
            itemDetailViewController.transaction = selectedItem
        }
        
    }
    
    // When the 'submit' button in the AddTransactionViewController is pressed, it performs an exit segue with this main view. This is the function that handles it.
    @IBAction func unwindToList (sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddTransactionViewController, transaction = sourceViewController.transaction {
            
            // If one of the rows is selected...
            if let selectedIndexPath = selectedRow {
                // Update an existing item
                transactions[selectedIndexPath.row] = transaction
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                print("selected")
            }
            else {
                // Add the new item to the table
                let newIndexPath = NSIndexPath(forRow: 0, inSection: 0)
                transactions.insert(transaction, atIndex: 0)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Top)
                
            }
            // Save items so that they persist if the app is closed
            saveItems()
            updateMoneyLabel()
        }
    }
    
    // I only wrote this so that if a user clicks on a row, it won't stay visually selected (hence animated = true)
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: NSCoding
    func saveItems() {
        // This function saves each account so that the data persists
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(transactions, toFile: Transaction.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to load transactions.")
        }
    }
    
    func loadItems() -> [Transaction]? {
        // This function loads each of the saved tranasctions from the file
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Transaction.ArchiveURL.path!) as? [Transaction]
    }
    
    // For testing purposes only
    func testItems() {
        let account1 = Account(account: "Checking", total: 8090.45)!
        
        accounts.append(account1)
    }
    
    func testItems2() {
        let testDate: NSDate!
        testDate = NSDate()
        let transaction1 = Transaction(amount: 450.98, name: "Paid electric bill", desc: "", date: testDate)!
        
        transactions.append(transaction1)
    }
    
}

