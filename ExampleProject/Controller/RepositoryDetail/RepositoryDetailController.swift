//
//  RepositoryDetailController.swift
//  ExamProject
//
//  Created by ozgun ergen on 15.02.2019.
//  Copyright © 2019 ozgun ergen. All rights reserved.
//

import UIKit

class RepositoryDetailController: UIViewController {
    
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryForkCountLabel: UILabel!
    @IBOutlet weak var repositoryLanguageLabel: UILabel!
    @IBOutlet weak var repositoryDefaultBranchLabel: UILabel!
    @IBOutlet weak var repositoryAvatarNameLabel: UILabel!
    @IBOutlet weak var repositoryDescriptionLabel: UILabel!
    
    var repository : RepositoryModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = repository.name
        configurationRepository()
    }
    
    func configurationRepository() {
        
        repositoryNameLabel.text = "Repository Name : " + repository.name
        repositoryLanguageLabel.text = "Repository Language : " + repository.language
        repositoryForkCountLabel.text = "Fork Count : \(repository.forkCount)"
        repositoryAvatarNameLabel.text = "Avatar Name : " + repository.ownerName
        repositoryDefaultBranchLabel.text = "Default Branch : " + repository.defaultBrach
        repositoryDescriptionLabel.text = "Repository Description : " + repository.description
        
    }
}
