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
                                        ViewModelStatusChangeListener,
                                        CollectionViewDiffableProtocol {
   
    typealias ViewModelType = SearchHomeViewModel
    
    var shouldFetchData: Bool { false }
    
    var viewModel: SearchHomeViewModel!
    
    var disposeBag: DisposeBag = DisposeBag()
    
    var items: [[any ModelAdaptable]]?
    
    lazy var handler: CollectionViewDiffableHandler! = .init(adaptable: self, collecionView: collectionView)
    
    var collectionView: UICollectionView! = UICollectionView(frame: .zero,
                                                             collectionViewLayout: BaseCollectionFlowLayout(direction: .vertical))
   
    override func configure() {
        registerCells()
        attachViewModelStatusChangeObserver()
    }
    
    override func configureUI() {
        super.configureUI()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func decorateCell(_ cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch cell {
        case is RelatedKeywordCell:
            let cell = cell as! RelatedKeywordCell
            
            cell.completableAction = { [weak self] action in
                switch action {
                case .didSelectKeyword(let keyword):
                    print("🟢 didSelectKeyword \(keyword)")
                    self?.viewModel.input.searchKeyword.accept(keyword)
                }
            }
            
        case is SearchResultCell:
            let cell = cell as! SearchResultCell
            
            
        default:
            return
        }
    }
    
    func bindViewModel() {
        viewModel.output.sectionType
            .share()
            .skip(1)
            .withUnretained(self)
            .bind { (self, section) in
                print("🔴 searchResultVC \(section)")
                
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
        collectionView.register(cellWithClass: RelatedKeywordCell.self)
        collectionView.register(cellWithClass: SearchResultCell.self)
    }
}
