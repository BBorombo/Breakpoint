//
//  UserCell.swift
//  Breakpoint
//
//  Created by Erwan Rombo on 30/09/2017.
//  Copyright © 2017 Borombo. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    // Outlet
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!

    // Variables
    var showing = false
    
    func configureCell(profileImage image: UIImage, email: String, isSelected: Bool){
        self.profileImage.image = image
        self.emailLabel.text = email
        if  isSelected {
            self.checkImage.isHidden = false
        }else{
            self.checkImage.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if  showing == false {
                checkImage.isHidden = false
                showing = true
            }else{
                checkImage.isHidden = true
                showing = false
            }
        }
    }

}
