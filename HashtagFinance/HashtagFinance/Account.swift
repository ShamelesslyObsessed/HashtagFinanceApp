//
//  Account.swift
//  HashtagFinance
//
//  Created by Rhiannon Weiss on 4/8/16.
//  Copyright © 2016 Rhiannon Weiss. All rights reserved.
//

import UIKit

// This is an account object. Every time an account is added, one of these is created.
// Each account object contains the account name and the total of the account.

class Account: NSObject, NSCoding {

    static var accounts : [Account] = []
    
    static var this : Account? {
        get {
            for i in accounts {
                if i.isCurrent {
                    return i
                }
            }
            return nil
        }
    }
    
    //static var lastId : Int! = 0
    
    // MARK: Properties
    var id: Int!
    var account: String!
    var total: Double!
    var isCurrent: Bool
    
    var transactions: [Transaction] {
        get {
            var bank: [Transaction] = []
            for i in Transaction.transactions {
                if i.accountId == self.id {
                    bank.append(i)
                }
            }
            return bank
        }
    }
    
    
    // MARK: Archiving Paths
    // This is where we determine where the account items will be stored in the file directory.
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("accounts")
    
    // MARK: Types
    // Defining keys for encoding/decoding.
    struct PropertyKey {
        static let idKey = "id"
        static let totalKey = "total"
        static let accountKey = "account"
        static let isCurrentKey = "isCurrent"
    }
    
    // MARK: Initialization
    init?(account: String, total: Double) {
        self.id = Account.accounts.count
        self.total = total
        self.account = account
        self.isCurrent = true
        
        //self.id = Account.lastId
        //Account.lastId = Account.lastId + 1
        
        super.init()
        
        Account.accounts.append(self)
    }
    
    init?(id: Int!, account: String, total: Double, isCurrent: Bool) {
        self.id = id
        self.total = total
        self.account = account
        self.isCurrent = isCurrent
        super.init()
        Account.accounts.append(self)
    }
    
    // MARK: NSCoding
    // This is the function that encodes and saves each of the account items
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(id, forKey: PropertyKey.idKey)
        aCoder.encodeObject(account, forKey: PropertyKey.accountKey)
        aCoder.encodeObject(total, forKey: PropertyKey.totalKey)
        aCoder.encodeObject(isCurrent, forKey: PropertyKey.isCurrentKey)
    }
    
    // This is the function that decodes each of the account items for use again
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObjectForKey(PropertyKey.idKey) as! Int
        let total = aDecoder.decodeObjectForKey(PropertyKey.totalKey) as! Double
        let account = aDecoder.decodeObjectForKey(PropertyKey.accountKey) as! String
        let isCurrent = aDecoder.decodeObjectForKey(PropertyKey.isCurrentKey) as! Bool
        
        // Must call designated initializer.
        self.init(id: id, account: account, total: total, isCurrent: isCurrent)
    }
    
}