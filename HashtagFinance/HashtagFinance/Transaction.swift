//
//  Transaction.swift
//  HashtagFinance
//
//  Created by Rhiannon Weiss on 4/8/16.
//  Copyright © 2016 Rhiannon Weiss. All rights reserved.
//

import UIKit


class Transaction: NSObject, NSCoding {
    
    // MARK: Properties
    var amount: Double!
    var name: String!
    var desc: String?
    var date: NSDate!
    
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("transactions")
    
    // MARK: Types
    struct PropertyKey {
        static let amountKey = "amount"
        static let nameKey = "name"
        static let descKey = "desc"
        static let dateKey = "date"
    }
    
    // MARK: Initialization
    init?(amount: Double, name: String, desc: String?, date: NSDate) {
        self.amount = amount
        self.name = name
        self.desc = desc
        self.date = date
        
        super.init()
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(amount, forKey: PropertyKey.amountKey)
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(desc, forKey: PropertyKey.descKey)
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let amount = aDecoder.decodeObjectForKey(PropertyKey.amountKey) as! Double
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let desc = aDecoder.decodeObjectForKey(PropertyKey.descKey) as? String
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! NSDate
        
        // Must call designated initializer.
        self.init(amount: amount, name: name, desc: desc, date: date)
    }
    
}