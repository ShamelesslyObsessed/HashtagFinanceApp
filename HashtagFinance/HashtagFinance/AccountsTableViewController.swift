//
//  AccountsTableViewController.swift
//  HashtagFinance
//
//  Created by Rhiannon Weiss on 4/8/16.
//  Copyright © 2016 Rhiannon Weiss. All rights reserved.
//

import UIKit


class AccountsTableViewController: UITableViewController {

    var accounts = [Account]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        // Load any saved items, otherwise toss in sample data
        if let savedItems = loadItems() {
            accounts += savedItems
        }
        else {
            // NEED TO REMOVE EVENTUALLY - FOR TESTING PURPOSES ONLY
            testItems()
        }
        
    }
    
    func testItems() {
        let account1 = Account(account: "Checking", total: 8090.45)!
        
        accounts.append(account1)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AccountsTableViewCell", forIndexPath: indexPath) as! AccountsTableViewCell
        
        let account = accounts[indexPath.row]
        
        cell.accountNameLabel.text = account.account
        cell.accountTotalLabel.text = String(account.total)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Number of sections
        return 1
    }
    
    // MARK: NSCoding
    func saveItems() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(accounts, toFile: Account.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to load accounts.")
        }
    }
    
    func loadItems() -> [Account]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Account.ArchiveURL.path!) as? [Account]
    }
    
    @IBAction func unwindToList (sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddAccountViewController, account = sourceViewController.account {
            //
            //            if let selectedIndexPath = tableView.indexPathForSelectedRow {
            //                // Update an existing item
            //                transactions[selectedIndexPath.row] = transaction
            //                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            //            }
            //            else {
            //                // Add item
            let newIndexPath = NSIndexPath(forRow: accounts.count, inSection: 0)
            accounts.append(account)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Top)
            // }
            // Save items so that they persist if the app is closed
            saveItems()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! AccountsTableViewCell
        money = Double(currentCell.accountTotalLabel.text!)
        print(money)
        
        // Activate checkmark!
        let numberOfRows = tableView.numberOfRowsInSection(0)
        for row in 0..<numberOfRows {
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0)) {
                cell.accessoryType = row == indexPath.row ? .Checkmark : .None
            }
        }
    }
    
}
