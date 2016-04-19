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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var homeButton: UITabBarItem!
    
    @IBOutlet weak var moneyLabel: UILabel!
    
    var moneyOriginal: Double!
    
    var transactions = [Transaction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        // Load any saved items, otherwise toss in sample data
        if let savedItems = loadItems() {
            transactions += savedItems
        }
        else {
            // NEED TO REMOVE EVENTUALLY - FOR TESTING PURPOSES ONLY
            //testItems()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        moneyOriginal = money
        
        if (money == nil) {
            moneyLabel.text = "$0.00"
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
        let moneyAfterTransactions = moneyOriginal + transactionTotal
        let moneyString = "$" + String(moneyAfterTransactions)
        moneyLabel.text = moneyString
    }
    
    func testItems() {
        let testDate: NSDate!
        testDate = NSDate()
        let transaction1 = Transaction(amount: 450.98, name: "Paid electric bill", desc: "", date: testDate)!
        
        transactions.append(transaction1)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TransactionTableViewCell", forIndexPath: indexPath) as! TransactionTableViewCell
        
        let transaction = transactions[indexPath.row]
        
        cell.amountLabel.text = String(transaction.amount)
        cell.nameLabel.text = transaction.name
        
        
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
        return transactions.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Number of sections
        return 1
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
            let itemDetailViewController = segue.destinationViewController as! AddTransactionViewController
            if let selectedCell = sender as? TransactionTableViewCell {
                
                // Get the cell that was selected
                let indexPath = tableView.indexPathForCell(selectedCell)!
                let selectedItem = transactions[indexPath.row]
                itemDetailViewController.transaction = selectedItem
            }
        
    }
    
    @IBAction func unwindToList (sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddTransactionViewController, transaction = sourceViewController.transaction {
            
                        if let selectedIndexPath = tableView.indexPathForSelectedRow {
                            // Update an existing item
                            transactions[selectedIndexPath.row] = transaction
                            tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                        }
                        else {
                            // Add item
            let newIndexPath = NSIndexPath(forRow: transactions.count, inSection: 0)
            transactions.append(transaction)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Top)
            
             }
            // Save items so that they persist if the app is closed
            saveItems()
            updateMoneyLabel()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: NSCoding
    func saveItems() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(transactions, toFile: Transaction.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to load transactions.")
        }
    }
    
    func loadItems() -> [Transaction]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Transaction.ArchiveURL.path!) as? [Transaction]
    }
    
}

