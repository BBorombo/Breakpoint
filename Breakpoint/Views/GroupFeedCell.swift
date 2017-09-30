//
//  GroopFeedCell.swift
//  Breakpoint
//
//  Created by Erwan Rombo on 30/09/2017.
//  Copyright © 2017 Borombo. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func configureCell(profileImage: UIImage, email: String, content: String){
        self.imageProfile.image = profileImage
        self.emailLabel.text = email
        self.contentLabel.text = content
    }
    
}
