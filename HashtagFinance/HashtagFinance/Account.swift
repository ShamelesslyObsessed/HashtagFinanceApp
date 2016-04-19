
import UIKit


class Account: NSObject, NSCoding {
    
    // MARK: Properties
    var account: String!
    var total: Double!
    
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("accounts")
    
    // MARK: Types
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
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(account, forKey: PropertyKey.accountKey)
        aCoder.encodeObject(total, forKey: PropertyKey.totalKey)

    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let total = aDecoder.decodeObjectForKey(PropertyKey.totalKey) as! Double
        let account = aDecoder.decodeObjectForKey(PropertyKey.accountKey) as! String
        
        // Must call designated initializer.
        self.init(account: account, total: total)
    }
    
}