//
//  User.swift
//  HashtagFinance
//
//  Created by Bondzio, Kevin M (bondz001) on 4/14/16.
//  Copyright © 2016 Rhiannon Weiss. All rights reserved.
//

import Foundation

import UIKit

class User: NSObject, NSCoding{
    
    var username: String!
    var password: String!
    
    var firstname: String!
    var lastname: String!
    
    
    var listOfAccounts: [Account] = []
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("user")
    
    // MARK: Types
    struct PropertyKey {
        static let usernameKey = "username"
        static let passwordKey = "password"
        static let firstnameKey = "firstname"
        static let lastnameKey = "lastname"
        static let listOfAccountsKey = "listofaccounts"
        
    }
    
    // MARK: Initialization
    init?(username: String, password: String, firstname: String, lastname: String) {
        self.username = username
        self.password = password
        self.firstname = firstname
        self.lastname = lastname
        
        super.init()
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(username, forKey: PropertyKey.usernameKey)
        aCoder.encodeObject(password, forKey: PropertyKey.passwordKey)
        aCoder.encodeObject(username, forKey: PropertyKey.firstnameKey)
        aCoder.encodeObject(password, forKey: PropertyKey.lastnameKey)
        aCoder.encodeObject(username, forKey: PropertyKey.listOfAccountsKey)

        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let username = aDecoder.decodeObjectForKey(PropertyKey.usernameKey) as! String
        let password = aDecoder.decodeObjectForKey(PropertyKey.passwordKey) as! String
        let firstname = aDecoder.decodeObjectForKey(PropertyKey.firstnameKey) as! String
        let lastname = aDecoder.decodeObjectForKey(PropertyKey.lastnameKey) as! String
        let listOfAccounts = aDecoder.decodeObjectForKey(PropertyKey.listOfAccountsKey) as! [Account]
        
        
        // Must call designated initializer.
        self.init(username: username, password: password, firstname: firstname, lastname: lastname)
    }
    
    
}
