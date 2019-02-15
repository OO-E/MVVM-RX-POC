//
//  RepositoryViewModel.swift
//  ExamProject
//
//  Created by ozgun ergen on 14.02.2019.
//  Copyright © 2019 ozgun ergen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa



class RepositoryListViewModel {
    
    var networkLayer = NetworkLayer()
    var repositories = Variable<[RepositoryModel]>([])
    var type = Variable<ErrorManagement>(ErrorManagement())
    
    func getRepository(name: String, page: Int) {
        
        let modelType = ErrorManagement()
        
        networkLayer.getRepository(name: name, page: page, complate: { (model) in

            if model.count > 0 {
                
                if page == 0 { self.repositories.value.removeAll() }
                
                model.forEach({ (repository) in
                    self.repositories.value.append(repository)
                })
                
                modelType.type = ErrorAndType.hubHide //Hide Loading
                self.type.value = modelType
            }
            
        }) { (error) in
            
            modelType.message = error
            modelType.type = ErrorAndType.networkError
            self.type.value = modelType
            
        }
    }
    
}
