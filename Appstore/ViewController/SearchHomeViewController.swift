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
                                      ViewModelStatusChangeListener,
                                      CollectionViewDiffableProtocol {
  
    typealias ViewModelType = SearchHomeViewModel
    
    var viewModel: SearchHomeViewModel!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    var items: [[any ModelAdaptable]]?
    
    private lazy var searchResultViewController = SearchResultViewController(viewModel: viewModel)
   
    private(set) lazy var searchController = UISearchController(searchResultsController: searchResultViewController)
    
    lazy var handler: CollectionViewDiffableHandler! = CollectionViewDiffableHandler(adaptable: self,
                                                                                     collecionView: collectionView)
    
    var collectionView: UICollectionView! = UICollectionView(frame: .zero,
                                                             collectionViewLayout: BaseCollectionFlowLayout(direction: .vertical))
    
    func decorateCell(_ cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch cell {
        case is RecentKeywordCell:
            let cell = cell as! RecentKeywordCell
            cell.completableAction = { [weak self] action in
                switch action {
                case .didSelectKeyword(let keyword):
                    self?.searchController.isActive = true
                    self?.viewModel.input.searchKeyword.accept(keyword)
                   break
                }
            }
        default:
            return
        }
    }

    func bindViewModel() {
        
        viewModel.output.searchText
            .withUnretained(self)
            .bind { (self, text) in
                self.searchController.searchBar.text = text
            }
            .disposed(by: disposeBag)
        
        viewModel.output.recentKeywords
            .withUnretained(self)
            .bind { (self, recentKeywords) in
                guard !recentKeywords.isEmpty else { return }
                var items: [[CellModel]] = []
                items.append([RecentKeywordTitleCellModel(title: "최근 검색어").toCellModel()])
                items.append(recentKeywords.map { $0.toCellModel() })
                self.handler.updateDataSource(items)
            }
            .disposed(by: disposeBag)

    }
    
    override func configureUI() {
        super.configureUI()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    override func configure() {
        searchResultViewController.searchControler = searchController
        configureSearchConttoller()
        attachViewModelStatusChangeObserver()
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
}

extension SearchHomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        viewModel.input.searchKeyword.accept(RelatedSearchKeyword(keyword: keyword))
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("\(#function)")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.input.didChangeKeywordText.accept(searchText)
    }
}
