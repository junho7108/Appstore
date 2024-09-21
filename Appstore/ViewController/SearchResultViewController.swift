//
//  SearchResultViewController.swift
//  Appstore
//
//  Created by Junho Yoon on 9/20/24.
//

import UIKit
import RxSwift


final class SearchResultViewController: BaseViewController,
                                        ViewModelBindable,
                                        CollectionViewDiffableProtocol {
   
    typealias ViewModelType = SearchHomeViewModel
    
    var shouldFetchData: Bool { false }
    
    var viewModel: SearchHomeViewModel!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    var items: [[any ModelAdaptable]]?
    
    lazy var handler: CollectionViewDiffableHandler! = .init(adaptable: self, collecionView: collectionView)
    
    var collectionView: UICollectionView! = UICollectionView(frame: .zero,
                                                             collectionViewLayout: BaseCollectionFlowLayout(direction: .vertical))
   
    override func configureUI() {
        super.configureUI()
        defer {
            registerCells()
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func bindViewModel() {
        viewModel.output.sectionType
            .skip(1)
            .withUnretained(self)
            .bind { (self, section) in
                print("🔴 section \(section)")
                
                switch section {
                case .relatedKeywords:
                    let items = self.viewModel.output.relatedKeywords.value.map { [$0.toCellModel()]}
                    self.handler.updateDataSource(items)
                    
                case .searchResult:
                    let items = self.viewModel.output.searchResults.value.map { [$0.toCellModel()]}
                    self.handler.updateDataSource(items)
                    
                }
            }
            .disposed(by: disposeBag)
    }


    func registerCells() {
        collectionView.register(cellWithClass: RecentKeywordCell.self)
        collectionView.register(cellWithClass: SearchResultCell.self)
    }
}
