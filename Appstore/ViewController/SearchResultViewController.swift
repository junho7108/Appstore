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
    
    var searchControler: UISearchController?
    
    lazy var handler: CollectionViewDiffableHandler! = .init(adaptable: self, collecionView: collectionView)
    
    var collectionView: UICollectionView! = UICollectionView(frame: .zero,
                                                             collectionViewLayout: BaseCollectionFlowLayout(direction: .vertical))
    
    override func configure() {
        attachViewModelStatusChangeObserver()
    }
    
    override func configureUI() {
        super.configureUI()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func decorateCell(_ cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch cell {
        case is DuplicatedKeywordCell:
            let cell = cell as! DuplicatedKeywordCell
            cell.completableAction = { [weak self] action in
                switch action {
                case .didSelectKeyword(let keyword):
                    self?.viewModel.input.searchKeyword.accept(keyword)
                }
            }
            
        case is RelatedKeywordCell:
            let cell = cell as! RelatedKeywordCell
            cell.completableAction = { [weak self] action in
                switch action {
                case .didSelectKeyword(let keyword):
                    self?.viewModel.input.searchKeyword.accept(keyword)
                }
            }
            
        case is SearchResultCell:
            let cell = cell as! SearchResultCell
            cell.completableAction = { [weak self] action in
                switch action {
                case .coordinateToSearchDetail(let result):
                    self?.viewModel.coordinate.coordinateToSearchDetail.accept(result)
                }
            }
            
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
                switch section {
                case .relatedKeywords:
                    var items: [[ModelAdaptable]] = [[]]
                    
                    let duplicatedKeywors = self.viewModel.output.duplicatedKeywords.value

                    if !duplicatedKeywors.isEmpty {
                        let duplicatedCellModels = duplicatedKeywors.map { $0.toCellModel() }
                        items.append(duplicatedCellModels)
                    }
                    
                    let relatedCellModels = self.viewModel.output.relatedKeywords.value.map { $0.toCellModel() }
                    items.append(relatedCellModels)
                    
                    self.handler.updateDataSource(items)
                    
                case .searchResult:
                    self.searchControler?.searchBar.resignFirstResponder()

                    let items = self.viewModel.output.searchResults.value.map { $0.toCellModel()}
                    self.handler.updateDataSource([items])
                    
                }
            }
            .disposed(by: disposeBag)
    }
}
