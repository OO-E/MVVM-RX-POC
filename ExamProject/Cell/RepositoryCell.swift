//
//  RepositoryCell.swift
//  ExamProject
//
//  Created by ozgun ergen on 14.02.2019.
//  Copyright © 2019 ozgun ergen. All rights reserved.
//

import UIKit
import RxSwift

class RepositoryCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var ownerImageView: UIImageView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
