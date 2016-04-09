//
//  ViewController.swift
//  HashtagFinance
//
//  Created by Rhiannon Weiss on 4/8/16.
//  Copyright © 2016 Rhiannon Weiss. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var homeButton: UITabBarItem!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var transactionList: UITableView!
    
    var transactions = [Transaction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load any saved items, otherwise toss in sample data
        if let savedItems = loadItems() {
            transactions += savedItems
        }
        else {
            // NEED TO REMOVE EVENTUALLY - FOR TESTING PURPOSES ONLY
            testItems()
        }
        
    }
    
    func testItems() {
        let testDate: NSDate!
        testDate = NSDate()
        let transaction1 = Transaction(amount: 450.98, name: "Paid electric bill", desc: "", date: testDate)!
        
                transactions.append(transaction1)
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

