//
//  FourthViewController.swift
//  RxSwiftTest
//
//  Created by Ivan Rzhanoi on 06/11/2018.
//  Copyright © 2018 Ivan Rzhanoi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FourthViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBar: UISearchBar { return searchController.searchBar }
    
    var repositoriesViewModel: ViewModel?
    let api = APIProvider()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        
        repositoriesViewModel = ViewModel(APIProvider: api)
        if let viewModel = repositoriesViewModel {
            viewModel.data.drive(myTableView.rx.items(cellIdentifier: "Cell")) { _, repository, cell in
                cell.textLabel?.text = repository.name
                cell.detailTextLabel?.text = repository.url
            }.disposed(by: disposeBag)
            
            
            
            searchBar.rx.text.orEmpty.bind(to: viewModel.searchText).disposed(by: disposeBag)
            searchBar.rx.cancelButtonClicked.map{""}.bind(to: viewModel.searchText).disposed(by: disposeBag)
            viewModel.data.asDriver().map {
                "\($0.count) Repositories"
            }.drive(navigationItem.rx.title).disposed(by: disposeBag)
        }
    }
    
    func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.showsCancelButton = true
        searchBar.text = "IvanRzhanoi"
        searchBar.placeholder = "Enter user"
        myTableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
}
