//
//  ResultArrayModel.swift
//  ExamProject
//
//  Created by ozgun ergen on 14.02.2019.
//  Copyright © 2019 ozgun ergen. All rights reserved.
//

import Foundation
import SwiftyJSON


protocol Models {
    
    init(object: Any)
    init(json: JSON)
    init()
}


class ResultArrayModel<G: Models> {
    
    
    
    public var DATA = [G]()
    public var T = String()
    public var KEY = Int()
    
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    
    public init(json: JSON) {
        
        
        json.array?.forEach({ (json) in
            
            DATA.append(G(json: json))
            
        })
        //T = json["T"].string!
        //KEY = json["KEY"].int!
    }
    
    
    
    
}
