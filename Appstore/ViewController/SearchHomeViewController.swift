//
//  SearchHomeViewController.swift
//  Appstore
//
//  Created by Junho Yoon on 9/19/24.
//

import UIKit
import RxSwift
import RxRelay

final class SearchHomeViewController: BaseViewController,
                                      ViewModelBindable,
                                      CollectionViewDiffableProtocol {
  
    typealias ViewModelType = SearchHomeViewModel
    
    var viewModel: SearchHomeViewModel!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    var items: [[any ModelAdaptable]]?
    
    private lazy var searchResultViewController = SearchResultViewController(viewModel: viewModel)
   
    private lazy var searchController = UISearchController(searchResultsController: searchResultViewController)
    
    lazy var handler: CollectionViewDiffableHandler! = CollectionViewDiffableHandler(adaptable: self,
                                                                                     collecionView: collectionView)
    
    var collectionView: UICollectionView! = UICollectionView(frame: .zero,
                                                             collectionViewLayout: BaseCollectionFlowLayout(direction: .vertical))

    func bindViewModel() {
        
        viewModel.output.recentKeywords
            .withUnretained(self)
            .bind { (self, recentKeywords) in
                print("🟢 최근 검색어 \(recentKeywords)")
                guard !recentKeywords.isEmpty else { return }
                let items = recentKeywords.map { [$0.toCellModel()] }
                self.handler.updateDataSource(items)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureUI() {
        super.configureUI()
        defer {
            registerCells()
            configureSearchConttoller()
        }
       
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func configureSearchConttoller() {
       
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
      
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.title = "검색"
    }
  
    private func registerCells() {
        self.collectionView.register(cellWithClass: RecentKeywordCell.self)
    }
}

extension SearchHomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        viewModel.input.searchButtonClicked.accept(SearchKeyword(keyword: keyword))
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("\(#function)")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.input.didChangeKeywordText.accept(searchText)
    }
}
