//
//  UserProfileCell.swift
//  ExamProject
//
//  Created by ozgun ergen on 14.02.2019.
//  Copyright © 2019 ozgun ergen. All rights reserved.
//

import UIKit

class UserProfileCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpdateCell(profile: ProfileModel) {
        self.nameLabel.text = profile.name
        self.urlLabel.text = profile.profileUrl
        self.profileImageView.downloadImage(url: profile.avatarUrl)
    }
    
}
