//
//  Transaction.swift
//  HashtagFinance
//
//  Created by Rhiannon Weiss on 4/8/16.
//  Copyright © 2016 Rhiannon Weiss. All rights reserved.
//

import UIKit

// This is a transaction object. Every time a transaction is added, one of these is created. 
// Each transaction object contains the transaction amount, transaction description, title/name
// of the transaction, and the date.

class Transaction: NSObject, NSCoding {
    
    static var transactions: [Transaction] = []
    
    var transactionIndex: Int?
    
    // MARK: Properties
    var accountId: Int
    var amount: Double!
    var name: String!
    var desc: String?
    var date: NSDate!
    
    // MARK: Archiving Paths
    // This is where we determine where the transaction items will be stored in the file directory.
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("transactions")
    
    // MARK: Types
    // Defining keys for encoding/decoding.
    struct PropertyKey {
        static let accountId = "accountId"
        static let amountKey = "amount"
        static let nameKey = "name"
        static let descKey = "desc"
        static let dateKey = "date"
    }
    
    // MARK: Initialization
    init?(amount: Double, name: String, desc: String?, date: NSDate) {
//        var this: Account? = nil
        
        self.accountId = 0
        
        if let this = Account.this {
            self.accountId = this.id
        }
        
        self.amount = amount
        self.name = name
        self.desc = desc
        self.date = date
        
        print("debug: I'm a transaction.  My accountId is \(self.accountId)")
        super.init()
        
//        if this != nil {
//            this!.addTransaction(self)
//        }
        Transaction.transactions.append(self)
    }
    
    init?(accountId: Int, amount: Double, name: String, desc: String?, date: NSDate) {
        self.accountId = accountId
        self.amount = amount
        self.name = name
        self.desc = desc
        self.date = date
        
        print("debug: I'm a transaction.  My accountId is \(self.accountId)")
        super.init()
        
        
//        if let account = Account.getAccountForId(accountId) {
//            account.addTransaction(self)
//        } else {
//            Account.this!.addTransaction(self)
//        }
        
        Transaction.transactions.append(self)
    }
    
    // MARK: NSCoding
    // This is the function that encodes and saves each of the transaction items
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(accountId, forKey: PropertyKey.accountId)
        aCoder.encodeObject(amount, forKey: PropertyKey.amountKey)
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(desc, forKey: PropertyKey.descKey)
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
    }
    
    // This is the function that decodes each of the tranasaction items for use again
    required convenience init?(coder aDecoder: NSCoder) {
        let accountId = aDecoder.decodeObjectForKey(PropertyKey.accountId) as! Int
        let amount = aDecoder.decodeObjectForKey(PropertyKey.amountKey) as! Double
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let desc = aDecoder.decodeObjectForKey(PropertyKey.descKey) as? String
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! NSDate
        
        // Must call designated initializer.
        self.init(accountId: accountId, amount: amount, name: name, desc: desc, date: date)
    }
    
}