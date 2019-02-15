//
//  UserProfileController.swift
//  ExamProject
//
//  Created by ozgun ergen on 14.02.2019.
//  Copyright © 2019 ozgun ergen. All rights reserved.
//

import UIKit
import RxSwift

enum ProfileSectionType {
    case Information
    case repositories
}

class UserProfileController: UIViewController {
    
    var ownerName = String()
    @IBOutlet weak var tableView: UITableView!
    var viewModel = UserProfileViewModel()
    var disposeBag = DisposeBag()
    var tableSectionType = [ProfileSectionType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ownerName
        configurationTableView()
        configurationReactiveBinding()
        
    }
    
    func configurationTableView() {
        
        self.tableSectionType.append(ProfileSectionType.Information)
        self.tableSectionType.append(ProfileSectionType.repositories)
        tableView.register(UINib(nibName: "UserProfileCell", bundle: nil), forCellReuseIdentifier: "UserProfileCell")
        tableView.rowHeight = 98
        
    }
    
    func configurationReactiveBinding() {
        
        viewModel.getUserProfileDetailInformation(name: ownerName)
        viewModel.userProfile.asObservable().subscribe { (event) in
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel.userRepositories.asObservable().subscribe { (event) in
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
}


extension UserProfileController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableSectionType.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.tableSectionType[section] {
        case .Information:
            return 1
        case .repositories:
            return self.viewModel.userRepositories.value.count
        default:
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.tableSectionType[indexPath.section] {
        case .Information:
            return self.getUserInformationCell(tableView: tableView, indexPath: indexPath)
        case .repositories:
            return self.getUserRepositoryCell(indexPath: indexPath)
        default:
            return UITableViewCell()
        }
        
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.tableSectionType[indexPath.section] {
        case .Information:
            return 98
        case .repositories:
            return 64
        default:
            return 0
        }
    }
    
    func getUserInformationCell(tableView: UITableView, indexPath: IndexPath) -> UserProfileCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserProfileCell", for: indexPath) as! UserProfileCell
        cell.setUpdateCell(profile: self.viewModel.userProfile.value)
        return cell
    }
    
    func getUserRepositoryCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let model = self.viewModel.userRepositories.value[indexPath.row]
            cell.textLabel?.text = model.name
            cell.detailTextLabel?.text = model.full_name
        return cell
    }
}
