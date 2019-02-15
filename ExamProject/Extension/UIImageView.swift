//
//  UIImageView.swift
//  ExamProject
//
//  Created by ozgun ergen on 15.02.2019.
//  Copyright © 2019 ozgun ergen. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

    func downloadImage(url: String) {
        self.kf.setImage(with: URL(string: url))
    }
    
}
