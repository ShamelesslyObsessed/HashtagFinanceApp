//
//  AccountsTableViewCell.swift
//  HashtagFinance
//
//  Created by Rhiannon Weiss on 4/8/16.
//  Copyright © 2016 Rhiannon Weiss. All rights reserved.
//

import UIKit

class AccountsTableViewCell: UITableViewCell {

    // The UI labels for each account cell, so they can be set in the AccountsTableViewController
    @IBOutlet weak var accountTotalLabel: UILabel!
    @IBOutlet weak var accountNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
