//
//  ViewController.swift
//  ExamProject
//
//  Created by ozgun ergen on 13.02.2019.
//  Copyright © 2019 ozgun ergen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class RepositoryListController: UIViewController, UISearchBarDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    private let cellIdentifier = "RepositoryCell"
    var viewModel = RepositoryListViewModel()
    var page : Int = 1
    var searchingText : String = ""
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search for repository"
        return searchController
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureProperties()
        configureReactiveBinding()
        
    }
    
    private func configureProperties() {
        searchController.searchBar.delegate = self
        tableView.register(UINib(nibName: "RepositoryCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        navigationItem.searchController = searchController
        navigationItem.title = "Repository Finder"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.rowHeight = 90
    }
    
    private func configureReactiveBinding() {
        
        searchController.searchBar
                        .rx.text
                        .orEmpty
                        .debounce(0.5, scheduler: MainScheduler.instance)
                        .distinctUntilChanged()
                        .filter { !$0.isEmpty }
                        .subscribe({ _ in
                            self.searchingText = self.searchController.searchBar.text ?? ""
                            self.page = 1
                            self.viewModel.getRepository(name: (self.searchingText), page: self.page)
                        }).disposed(by: disposeBag)
        
        viewModel.repositories
                 .asObservable()
                 .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: RepositoryCell.self)) { index, model, cell in
                    
                        cell.repositoryName.text = model.name
                        cell.userName.text = model.ownerName
                        cell.ownerImageView.downloadImage(url: model.ownerImage)

                        let tapGesture = UITapGestureRecognizer()
                        cell.ownerImageView.addGestureRecognizer(tapGesture)
                        cell.ownerImageView.isUserInteractionEnabled = true
                        tapGesture.rx.event.bind(onNext: { recognizer in
                            //Push Owner Profile
                            let ownerController = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileController") as! UserProfileController
                            ownerController.ownerName = model.ownerName
                            self.navigationController?.pushViewController(ownerController, animated: true)
                        }).disposed(by: self.disposeBag)
                    }
      
            tableView.rx.modelSelected(RepositoryModel.self)
                .subscribe(onNext: {
                    repository in
                    if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                        self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                    }
                    let repositoryDetail = self.storyboard?.instantiateViewController(withIdentifier: "RepositoryDetailController") as! RepositoryDetailController
                    repositoryDetail.repository = repository
                    self.navigationController?.pushViewController(repositoryDetail, animated: true)
                }).disposed(by: disposeBag)
        
        
            tableView.addInfiniteScroll { (tableView) in
                if (self.viewModel.repositories.value.count > 0) {
                    self.page += 1
                    self.viewModel.getRepository(name: self.searchingText, page: self.page)
                } else {
                    tableView.finishInfiniteScroll(completion: nil)
                }
            }
        
        self.viewModel.type.asObservable().subscribe { (event) in
            
            switch event.element!.type {
                case .hubHide:
                    print("Hud Hide")
                    self.searchController.searchBar.endEditing(true)
                    self.searchController.resignFirstResponder()
                    self.tableView.finishInfiniteScroll(completion: nil)
                break
                case .networkError:
                    
                break
                case .none:
                    
                break
            }
            
            
        }
       
    }
    

    
}

