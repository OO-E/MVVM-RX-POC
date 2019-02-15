//
//  NetworkLayer.swift
//  ExamProject
//
//  Created by ozgun ergen on 14.02.2019.
//  Copyright © 2019 ozgun ergen. All rights reserved.
//

import Foundation



class NetworkLayer {
    
    
    func getRepository(name: String,page: Int, complate:@escaping(_ json:[RepositoryModel])->Void,error:@escaping(_ error:String)->Void) {
        let path = "search/repositories?q=\(name)&per_page=12&page=\(page)"
        print("path ",path)
        NetworkManager.shared().get(path: path, complate: { (json) in
            
            let modelArray = ResultArrayModel<RepositoryModel>(json: json["items"])
            complate(modelArray.DATA)
            
        }) { (errorMessage) in
            error(errorMessage)
        }
    }
    
    
    func getUserProfileDetail(name: String,complate:@escaping(_ json:ProfileModel)->Void,error:@escaping(_ error:String)->Void) {
        
        let path = "users/" + name
        NetworkManager.shared().get(path: path, complate: { (json) in
            
            let profileModel = ProfileModel(json: json)
            complate(profileModel)
            
        }) { (errorMessage) in
            error(errorMessage)
        }
    }
    
    func getUserProfileRepositoryDetail(name: String,complate:@escaping(_ json:[RepositoryModel])->Void,error:@escaping(_ error:String)->Void) {
        
        let path = "users/" + name + "/repos"
        NetworkManager.shared().get(path: path, complate: { (json) in
            
            let repositories = ResultArrayModel<RepositoryModel>(json: json)
            complate(repositories.DATA)
            
        }) { (errorMessage) in
            error(errorMessage)
        }
    }
    
    
}
