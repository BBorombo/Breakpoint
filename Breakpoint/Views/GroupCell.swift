//
//  GroupCell.swift
//  Breakpoint
//
//  Created by Erwan Rombo on 30/09/2017.
//  Copyright © 2017 Borombo. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    @IBOutlet weak var groupTitleLabel: UILabel!
    @IBOutlet weak var groupDescLabel: UILabel!
    @IBOutlet weak var memberCoutLabel: UILabel!
    
    
    func configureCell(title: String, description: String, memberCount: Int){
        self.groupTitleLabel.text = title
        self.groupDescLabel.text = description
        self.memberCoutLabel.text = "\(memberCount) members"
    }
}
