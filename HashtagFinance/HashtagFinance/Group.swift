//
//  Group.swift
//  HashtagFinance
//
//  Created by Rhiannon Weiss on 4/9/16.
//  Copyright © 2016 Rhiannon Weiss. All rights reserved.
//

import UIKit

// need to create a group object

class Group: NSObject, NSCoding{
    
    var name: String!
    var participants: [User]! = []
    var balance: Double!
    
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("group")
    
    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let participantsKey = "participants"
        static let balanceKey = "balance"
    }
    
    // MARK: Initialization
    init?(name: String, balance: Double, participants: [User]) {
        self.balance = balance
        self.name = name
        self.participants = participants
        
        super.init()
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(balance, forKey: PropertyKey.balanceKey)
        aCoder.encodeObject(participants, forKey: PropertyKey.participantsKey)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let balance = aDecoder.decodeObjectForKey(PropertyKey.balanceKey) as! Double
        let participants = aDecoder.decodeObjectForKey(PropertyKey.participantsKey) as? [User]

        
        // Must call designated initializer.
        self.init(name: name, balance: balance, participants: participants!)
    }

}