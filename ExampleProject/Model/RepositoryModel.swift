//
//  RepositoryModel.swift
//  ExamProject
//
//  Created by ozgun ergen on 14.02.2019.
//  Copyright © 2019 ozgun ergen. All rights reserved.
//

import Foundation
import SwiftyJSON


class RepositoryModel: Models {
    
    var name = String()
    var ownerName = String()
    var ownerImage = String()
    var full_name = String()
    var forkCount = Int()
    var defaultBrach = String()
    var language = String()
    var description = String()
    
    
    required init() {
     
    }
    
    required convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    required init(json: JSON) {
        self.name = json["name"].string ?? ""
        self.ownerImage = json["owner"]["avatar_url"].string ?? ""
        self.ownerName = json["owner"]["login"].string ?? ""
        self.full_name = json["full_name"].string ?? ""
        self.language = json["language"].string ?? ""
        self.defaultBrach = json["default_branch"].string ?? ""
        self.forkCount = json["forks_count"].int ?? 0
        self.description = json["description"].string ?? ""
    }
    
    
 
    
}
