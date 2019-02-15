//
//  ProfileModel.swift
//  ExamProject
//
//  Created by ozgun ergen on 14.02.2019.
//  Copyright © 2019 ozgun ergen. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProfileModel: Models {
    
    var name = String()
    var profileUrl = String()
    var avatarUrl = String()
    
    
    required init() {
        
    }
    
    required convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    required init(json: JSON) {
        name = json["name"].string ?? ""
        profileUrl = json["url"].string ?? ""
        avatarUrl = json["avatar_url"].string ?? ""
    }
    
    
    
    
}
