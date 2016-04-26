//
//  PeriodicTransaction.swift
//  HashtagFinance
//
//  Created by Bondzio, Kevin M (bondz001) on 4/26/16.
//  Copyright © 2016 Rhiannon Weiss. All rights reserved.
//

import Foundation

import UIKit

class PeriodicTransaction: NSObject, NSCoding{
    
    var name: String
    var amount: Double
    var startDate: NSDate
    var endDate: NSDate
    var dayOfMonth: Int
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("periodicTransaction")
    
    
    struct PropertyKey {
        static let amountKey = "amount"
        static let nameKey = "name"
        static let endDateKey = "endDate"
        static let startDayKey = "startDate"
        static let dayOfMonthKey = "dauOfMonth"
        
    }
    
    // MARK: Initialization
    init?(name: String, amount: Double, startDate: NSDate, endDate: NSDate, dayOfMonth: Int) {
        
        self.amount = amount
        self.name = name
        self.endDate = endDate
        self.startDate = startDate
        self.dayOfMonth = dayOfMonth
        
        super.init()
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(amount, forKey: PropertyKey.amountKey)
        aCoder.encodeObject(endDate, forKey: PropertyKey.endDateKey)
        aCoder.encodeObject(startDate, forKey: PropertyKey.startDayKey)
        aCoder.encodeObject(dayOfMonth, forKey: PropertyKey.dayOfMonthKey)
        
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let amount = aDecoder.decodeObjectForKey(PropertyKey.amountKey) as! Double
        let endDate = aDecoder.decodeObjectForKey(PropertyKey.endDateKey) as! NSDate
        let startDate = aDecoder.decodeObjectForKey(PropertyKey.startDayKey) as! NSDate
        let dayOfMonth = aDecoder.decodeObjectForKey(PropertyKey.dayOfMonthKey) as! Int
        
        // Must call designated initializer.
        self.init(name: name, amount: amount, startDate: startDate, endDate: endDate,  dayOfMonth: dayOfMonth)
    }

    
}