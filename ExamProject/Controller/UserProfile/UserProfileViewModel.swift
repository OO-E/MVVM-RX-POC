//
//  UserProfileViewModel.swift
//  ExamProject
//
//  Created by ozgun ergen on 14.02.2019.
//  Copyright © 2019 ozgun ergen. All rights reserved.
//

import Foundation
import RxSwift


class UserProfileViewModel {

    var networkLayer = NetworkLayer()
    var userProfile = Variable<ProfileModel>.init(ProfileModel())
    var userRepositories = Variable<[RepositoryModel]>([])
    
    func getUserProfileDetailInformation(name: String) {
    
        networkLayer.getUserProfileDetail(name: name, complate: { (profile) in
            self.userProfile.value = profile
        }) { (error) in
            
        }
        
        
        networkLayer.getUserProfileRepositoryDetail(name: name, complate: { (repositoryModel) in
            self.userRepositories.value = repositoryModel
        }) { (errorMessage) in
            
        }
        
        
    }
    
    
}
