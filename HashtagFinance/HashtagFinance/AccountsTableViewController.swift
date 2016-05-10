//
//  AccountsTableViewController.swift
//  HashtagFinance
//
//  Created by Rhiannon Weiss on 4/8/16.
//  Copyright © 2016 Rhiannon Weiss. All rights reserved.
//

import UIKit


class AccountsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make the table view a delegate of itself
        tableView.delegate = self
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AccountsTableViewCell", forIndexPath: indexPath) as! AccountsTableViewCell
        
        // For the selected row, grab the account
        let account = accounts[indexPath.row]
        
        // Set the "account name" label to the account's name, and the "account total" label to the account's total.
        cell.accountNameLabel.text = account.account
        cell.accountTotalLabel.text = String(account.total)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // The number of rows in the section is equal the number of accounts.
        return accounts.count
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print("debug: Did you select me?")
        
        // If selected, grab the account
        let account = accounts[indexPath.row]
        
        // Save off the current account
//        Account.this?.isCurrent = false
//        account.isCurrent = true
        Account.this = account
        
//        // Reseting the transactions
//        transactions = []
//        transactions = account.transactions
        
        // Save the accounts?
        saveItems()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Number of sections: just one section
        return 1
    }
    
    // MARK: NSCoding
    func saveItems() {
        // This function saves each account so that the data persists
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(accounts, toFile: Account.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save accounts.")
        } else {
            print("Saved account")
        }
    }

    func loadItems() -> [Account]? {
        print("Loading accounts")
        // This function loads each of the saved accounts from the file
        let accounts = NSKeyedUnarchiver.unarchiveObjectWithFile(Account.ArchiveURL.path!) as? [Account]
        
        if accounts == nil {
            print("Failed to load accounts")
        } else {
            print("Successfully loaded accounts")
        }
        
        return accounts
    }
    
        // When the 'submit' button in the AddAccountViewController is pressed, it performs an exit segue with this view. This is the function that handles it.
    @IBAction func unwindToList (sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddAccountViewController, account = sourceViewController.account {
            
            // Add the new item to the table
            let newIndexPath = NSIndexPath(forRow: accounts.count, inSection: 0)
            print("Appending")
            accounts.append(account)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Top)
            
            // Save items so that they persist if the app is closed
            saveItems()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! AccountsTableViewCell
        money = Double(currentCell.accountTotalLabel.text!)
        
        // Activate checkmark if that row was selected
        let numberOfRows = tableView.numberOfRowsInSection(0)
        for row in 0..<numberOfRows {
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0)) {
                cell.accessoryType = row == indexPath.row ? .Checkmark : .None
            }
        }
    }
}
