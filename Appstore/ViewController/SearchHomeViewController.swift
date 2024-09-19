//
//  SearchHomeViewController.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

final class SearchHomeViewController: BaseViewController,
                                      ViewModelBindable {
    
    typealias ViewModelType = SearchHomeViewModel
    
    var viewModel: SearchHomeViewModel!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    private let searchResultViewController = SearchResultViewController()
   
    
    func bindViewModel() {
        
        viewModel.output.response
            .bind { response in
                print("🟢 response \(response)")
            }
            .disposed(by: disposeBag)
    }
    
    override func configureUI() {
        super.configureUI()
        configureSearchConttoller()
    }
    
    private func configureSearchConttoller() {
        let searchController = UISearchController(searchResultsController: searchResultViewController)
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        
    
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "검색"
        
    }
}

extension SearchHomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("\(#function)")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("\(#function)")
    }
}
