//
//  NetworkManager.swift
//  ExamProject
//
//  Created by ozgun ergen on 14.02.2019.
//  Copyright © 2019 ozgun ergen. All rights reserved.
//

import UIKit
import Alamofire_SwiftyJSON
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    var baseUrl :String = ""
    
    init() { }
    
    class func shared() -> NetworkManager {
        let rm = NetworkManager()
        rm.baseUrl = "https://api.github.com/"
        return rm
    }
    
    func get(path:String,complate:@escaping(_ json:JSON)->Void,error:@escaping(_ error:String)->Void){
        
        let url = self.baseUrl + path
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        Alamofire.request(URL(string: urlString ?? "")!, method: .get, parameters: nil, encoding: URLEncoding.default)
            .responseSwiftyJSON { dataResponse in
                if dataResponse.value != nil {
                    complate(dataResponse.value!)
                }
        }
    }
    
}

