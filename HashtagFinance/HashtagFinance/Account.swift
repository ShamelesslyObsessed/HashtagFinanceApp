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
    
    static var lastInsertId: Int = 0

    static var accounts : [Int:Account] = [:]
    
    static var this : Account? {
        get {
            for (_, i) in accounts {
                if i.isCurrent {
                    return i
                }
            }
            return nil
        }
        set {
            for (_, i) in accounts {
                i.isCurrent = false
            }
            newValue?.isCurrent = true
        }
    }
    
    //static var lastId : Int! = 0
    
    // MARK: Properties
    var id: Int!
    var account: String!
    var total: Double!
    var isCurrent: Bool
    
    var transactions: [Transaction]! {
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
    
//    var transactions: [Transaction] {
//        get {
//            var bank: [Transaction] = []
//            for i in Transaction.transactions {
//                if i.accountId == self.id {
//                    bank.append(i)
//                }
//            }
//            return bank
//        }
//    }
    
    
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
        static let transactionsKey = "transactions"
    }
    
    // MARK: Initialization
    init?(account: String, total: Double) {
        print("Last Insert Id = \(Account.lastInsertId)")
        self.id = ++Account.lastInsertId
        self.total = total
        self.account = account
        self.isCurrent = false
        
        //self.id = Account.lastId
        //Account.lastId = Account.lastId + 1
        
        super.init()
        
        Account.accounts[self.id] = self
    }
    
    init?(id: Int!, account: String, total: Double, isCurrent: Bool){//, transactions: [Transaction]) {
        if id > Account.lastInsertId {
            Account.lastInsertId = id
            print("Last insert id = \(Account.lastInsertId)")
        }
        self.id = id
        self.total = total
        self.account = account
        self.isCurrent = isCurrent
//        self.transactions = transactions
        super.init()
        Account.accounts[self.id] = self
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
//        let transactions = aDecoder.decodeObjectForKey(PropertyKey.transactionsKey) as? [Transaction] ?? []
        
//        print("Transactions decoded \(transactions.count)")
//        for i in transactions {
//            print(i.name)
//        }
        
        // Must call designated initializer.
        self.init(id: id, account: account, total: total, isCurrent: isCurrent)//, transactions: transactions)
    }
    
//    func addTransaction(transaction: Transaction) {
//        self.transactions.append(transaction)
//    }
    
    static func getAccountForId(accountId: Int) -> Account? {
//        for i in Account.accounts {
//            if i.id == accountId {
//                return i
//            }
//        }
//        return nil
        return Account.accounts[accountId]
    }
    
}