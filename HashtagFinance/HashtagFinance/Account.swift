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
    
    // MARK: Properties
    var account: String!
    var total: Double!
    
    
    // MARK: Archiving Paths
    // This is where we determine where the account items will be stored in the file directory.
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("accounts")
    
    // MARK: Types
    // Defining keys for encoding/decoding.
    struct PropertyKey {
        static let totalKey = "total"
        static let accountKey = "account"
    }
    
    // MARK: Initialization
    init?(account: String, total: Double) {
        self.total = total
        self.account = account
        
        super.init()
    }
    
    // MARK: NSCoding
    // This is the function that encodes and saves each of the account items
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(account, forKey: PropertyKey.accountKey)
        aCoder.encodeObject(total, forKey: PropertyKey.totalKey)

    }
    
    // This is the function that decodes each of the account items for use again
    required convenience init?(coder aDecoder: NSCoder) {
        let total = aDecoder.decodeObjectForKey(PropertyKey.totalKey) as! Double
        let account = aDecoder.decodeObjectForKey(PropertyKey.accountKey) as! String
        
        // Must call designated initializer.
        self.init(account: account, total: total)
    }
    
}